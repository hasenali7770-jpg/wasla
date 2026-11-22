import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/chat/format.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/media/media_storage.dart';
import '../../core/media/source.dart';

/// Data and storage: how long downloaded media stays on the phone, and a
/// button to clear it now.
class StorageScreen extends ConsumerStatefulWidget {
  const StorageScreen({super.key});
  @override
  ConsumerState<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends ConsumerState<StorageScreen> {
  late final MediaStorage _media = ref.read(mediaStorageProvider);
  late Future<CacheUsage> _usage = _media.usage();
  int? _days;

  @override
  void initState() {
    super.initState();
    _media.keepDays().then((d) {
      if (mounted) setState(() => _days = d);
    });
  }

  // A block body: `setState(() => _usage = ...)` would return the Future to
  // setState, which Flutter rejects.
  void _refreshUsage() => setState(() {
        _usage = _media.usage();
      });

  String _label(AppLocalizations l, int days) => switch (days) {
        3 => l.keepDays3,
        7 => l.keepDays7,
        30 => l.keepDays30,
        _ => l.keepForever,
      };

  Future<void> _choose(int days) async {
    setState(() => _days = days);
    await _media.setKeepDays(days);
    await _media.sweep(force: true); // apply a shorter period right away
    if (mounted) _refreshUsage();
  }

  Future<void> _clear() async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        content: Text(l.clearMediaConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(l.cancel)),
          TextButton(
            key: const Key('confirm-clear-media'),
            onPressed: () => Navigator.pop(c, true),
            child: Text(l.clear, style: TextStyle(color: Theme.of(c).colorScheme.error)),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final freed = await _media.clear();
    if (!mounted) return;
    _refreshUsage();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.clearMediaDone(fileSize(freed, l)))));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.storageTitle)),
      body: ListView(children: [
        FutureBuilder<CacheUsage>(
          future: _usage,
          builder: (_, s) => ListTile(
            leading: const Icon(Icons.sd_storage_outlined),
            title: Text(l.storageUsage),
            subtitle: Text(
              s.hasData ? l.storageUsageValue(s.data!.files, fileSize(s.data!.bytes, l)) : '…',
              key: const Key('media-usage'),
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          child: Text(l.keepMedia, style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary)),
        ),
        RadioGroup<int>(
          groupValue: _days,
          onChanged: (v) => v == null ? null : _choose(v),
          child: Column(children: [
            for (final d in MediaStorage.choices)
              RadioListTile<int>(key: Key('keep-$d'), value: d, title: Text(_label(l, d))),
          ]),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
          child: Text(l.keepMediaHint, style: theme.textTheme.bodySmall),
        ),
        const Divider(),
        ListTile(
          key: const Key('clear-media'),
          leading: Icon(Icons.delete_sweep_outlined, color: theme.colorScheme.error),
          title: Text(l.clearMedia, style: TextStyle(color: theme.colorScheme.error)),
          onTap: _clear,
        ),
      ]),
    );
  }
}
