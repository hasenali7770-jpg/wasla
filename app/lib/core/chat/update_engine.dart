import 'dart:async';
import 'dart:collection';

import 'package:fixnum/fixnum.dart';

import '../../gen/proto/wasla/v1/updates.pb.dart';
import 'chat_api.dart';

/// Applies server updates in exact pts order (docs/03-protocol.md §5).
///
/// * pts == 0: ephemeral (typing, status), applied immediately.
/// * local + pts_count == pts: apply, advance.
/// * pts <= local: duplicate, ignore.
/// * otherwise: a gap; buffer it, wait 500 ms for the missing update to
///   arrive, then fetch exactly what is missing with GetDifference.
///
/// [apply] must be idempotent: an update can arrive both as a push and in a
/// GetDifference page.
class UpdateEngine {
  UpdateEngine({
    required this.api,
    required this.apply,
    required this.onTooLong,
    this.onPts,
    this.gapWait = const Duration(milliseconds: 500),
  });

  /// Called whenever the local pts moves (persist it).
  final void Function(Int64 pts)? onPts;

  final ChatApi api;
  final void Function(Update u) apply;

  /// The server no longer has our history: reload the chat list (and call
  /// [reset] with its pts).
  final Future<void> Function() onTooLong;
  final Duration gapWait;

  Int64 _pts = Int64.ZERO;
  final _buffer = SplayTreeMap<Int64, Update>();
  Timer? _gapTimer;
  Future<void>? _syncing;

  Int64 get pts => _pts;

  /// Sets the starting point (from ListDialogs) and drops anything older.
  void reset(Int64 pts) {
    _setPts(pts);
    _buffer.removeWhere((k, _) => k <= pts);
  }

  void _setPts(Int64 pts) {
    _pts = pts;
    onPts?.call(pts);
  }

  void onPush(UpdatesPush push) {
    for (final u in push.updates) {
      _handle(u);
    }
  }

  void _handle(Update u) {
    if (u.pts == Int64.ZERO) {
      apply(u);
      return;
    }
    if (u.pts <= _pts) return; // already applied
    if (u.pts - u.ptsCount == _pts) {
      _apply(u);
      _drain();
      return;
    }
    _buffer[u.pts] = u;
    _gapTimer ??= Timer(gapWait, () {
      _gapTimer = null;
      if (_buffer.isNotEmpty) sync();
    });
  }

  void _apply(Update u) {
    apply(u);
    _setPts(u.pts);
  }

  void _drain() {
    while (_buffer.isNotEmpty) {
      final first = _buffer.firstKey()!;
      final u = _buffer[first]!;
      if (first <= _pts) {
        _buffer.remove(first);
      } else if (u.pts - u.ptsCount == _pts) {
        _buffer.remove(first);
        _apply(u);
      } else {
        return;
      }
    }
    _gapTimer?.cancel();
    _gapTimer = null;
  }

  /// Fetches everything after the local pts. Safe to call often (reconnects,
  /// gaps); concurrent calls share one run.
  Future<void> sync() => _syncing ??= _sync().whenComplete(() => _syncing = null);

  Future<void> _sync() async {
    while (true) {
      final d = await api.getDifference(_pts);
      if (d.tooLong) {
        _buffer.clear();
        await onTooLong();
        return;
      }
      for (final u in d.updates) {
        if (u.pts > _pts) _apply(u);
      }
      if (d.pts > _pts) _setPts(d.pts);
      _drain();
      if (!d.hasMore) return;
    }
  }

  void dispose() {
    _gapTimer?.cancel();
  }
}
