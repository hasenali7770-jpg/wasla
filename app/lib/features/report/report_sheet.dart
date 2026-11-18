import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/chat/chat_store.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/net/rpc_exception.dart';
import '../../gen/proto/wasla/v1/moderation.pb.dart';

/// What is being reported.
class ReportTarget {
  ReportTarget.user(Int64 this.userId) : chatId = null, seqs = const [];
  ReportTarget.messages(Int64 this.chatId, this.seqs, {this.authorId}) : userId = null;
  final Int64? userId;
  final Int64? chatId;
  final List<Int64> seqs;

  /// For message reports in private chats: who would be blocked.
  Int64? authorId;

  Int64? get blockable => userId ?? authorId;
}

Map<ReportReason, String> reportReasons(AppLocalizations l) => {
      ReportReason.REPORT_REASON_SPAM: l.reasonSpam,
      ReportReason.REPORT_REASON_SCAM: l.reasonScam,
      ReportReason.REPORT_REASON_HARASSMENT: l.reasonHarassment,
      ReportReason.REPORT_REASON_VIOLENCE: l.reasonViolence,
      ReportReason.REPORT_REASON_TERRORISM: l.reasonTerrorism,
      ReportReason.REPORT_REASON_CHILD_ABUSE: l.reasonChildAbuse,
      ReportReason.REPORT_REASON_PORNOGRAPHY: l.reasonPornography,
      ReportReason.REPORT_REASON_ILLEGAL_GOODS: l.reasonIllegalGoods,
      ReportReason.REPORT_REASON_PERSONAL_DATA: l.reasonPersonalData,
      ReportReason.REPORT_REASON_FAKE_ACCOUNT: l.reasonFakeAccount,
      ReportReason.REPORT_REASON_COPYRIGHT: l.reasonCopyright,
      ReportReason.REPORT_REASON_OTHER: l.reasonOther,
    };

/// Shows the report sheet. Returns true when a report was sent.
Future<bool> showReportSheet(BuildContext context, WidgetRef ref, ReportTarget target) async {
  final sent = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _ReportSheet(target: target),
  );
  if (sent == true && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).reportSent)));
  }
  return sent == true;
}

class _ReportSheet extends ConsumerStatefulWidget {
  const _ReportSheet({required this.target});
  final ReportTarget target;
  @override
  ConsumerState<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends ConsumerState<_ReportSheet> {
  ReportReason? _reason;
  final _comment = TextEditingController();
  bool _block = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final t = widget.target;
    final req = ReportRequest(reason: _reason, comment: _comment.text.trim(), block: _block);
    if (t.userId != null) {
      req.userId = t.userId!;
    } else {
      req.messages = ReportedMessages(chatId: t.chatId, seqs: t.seqs);
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(chatApiProvider).report(req);
      if (_block && t.blockable != null) {
        ref.read(chatStoreProvider.notifier).markBlocked(t.blockable!);
      }
      if (mounted) Navigator.pop(context, true);
    } on RpcException catch (e) {
      if (mounted) setState(() => _error = e.message(AppLocalizations.of(context)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l.reportTitle, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(l.reportWhy),
              RadioGroup<ReportReason>(
                groupValue: _reason,
                onChanged: (v) => setState(() => _reason = v),
                child: Column(children: [
                  for (final e in reportReasons(l).entries)
                    RadioListTile<ReportReason>(
                      key: ValueKey('reason-${e.key.value}'),
                      value: e.key,
                      title: Text(e.value),
                      dense: true,
                    ),
                ]),
              ),
              TextField(
                controller: _comment,
                maxLength: 512,
                maxLines: 2,
                decoration: InputDecoration(labelText: l.reportComment),
              ),
              if (widget.target.blockable != null)
                CheckboxListTile(
                  key: const Key('report-also-block'),
                  value: _block,
                  onChanged: (v) => setState(() => _block = v ?? false),
                  title: Text(l.reportAlsoBlock),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsetsDirectional.zero,
                ),
              if (_error != null)
                Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              const SizedBox(height: 8),
              FilledButton(
                key: const Key('report-send'),
                onPressed: _reason == null || _busy ? null : _send,
                child: Text(l.reportSend),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
