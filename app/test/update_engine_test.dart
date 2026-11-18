import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasla/core/chat/update_engine.dart';
import 'package:wasla/gen/proto/wasla/v1/updates.pb.dart';

import 'fakes/fake_chat_api.dart';

Update up(int pts, {int count = 1}) => Update(pts: Int64(pts), ptsCount: count, readOutbox: ReadOutbox(maxSeq: Int64(pts)));

void main() {
  late FakeChatApi api;
  late List<int> applied;
  late UpdateEngine engine;
  var tooLong = 0;

  setUp(() {
    api = FakeChatApi();
    applied = [];
    tooLong = 0;
    engine = UpdateEngine(
      api: api,
      apply: (u) => applied.add(u.pts.toInt()),
      onTooLong: () async => tooLong++,
      gapWait: const Duration(milliseconds: 20),
    );
    engine.reset(Int64(10));
  });

  test('applies in order and ignores duplicates', () {
    engine.onPush(UpdatesPush(updates: [up(11), up(12), up(12), up(9)]));
    expect(applied, [11, 12]);
    expect(engine.pts, Int64(12));
  });

  test('ephemeral updates (pts 0) apply immediately without moving pts', () {
    engine.onPush(UpdatesPush(updates: [Update(typing: Typing())]));
    expect(applied, [0]);
    expect(engine.pts, Int64(10));
  });

  test('an out-of-order update waits for the missing one', () async {
    engine.onPush(UpdatesPush(updates: [up(12)]));
    expect(applied, isEmpty);
    engine.onPush(UpdatesPush(updates: [up(11)]));
    expect(applied, [11, 12]);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(api.differenceCalls, isEmpty, reason: 'gap filled by push; no fetch needed');
  });

  test('a real gap is filled with GetDifference', () async {
    api.difference = (pts) => GetDifferenceResponse(updates: [up(11), up(12)], pts: Int64(12));
    engine.onPush(UpdatesPush(updates: [up(13)]));
    await Future<void>.delayed(const Duration(milliseconds: 80));
    expect(api.differenceCalls, [Int64(10)]);
    expect(applied, [11, 12, 13]);
    expect(engine.pts, Int64(13));
  });

  test('paged difference and too_long', () async {
    var call = 0;
    api.difference = (pts) => ++call == 1
        ? GetDifferenceResponse(updates: [up(11)], pts: Int64(11), hasMore: true)
        : GetDifferenceResponse(updates: [up(12)], pts: Int64(12));
    await engine.sync();
    expect(applied, [11, 12]);

    api.difference = (_) => GetDifferenceResponse(tooLong: true, pts: Int64(500));
    await engine.sync();
    expect(tooLong, 1);
  });
}
