import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/enums/app_feedback_type.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../../../shared/widgets/app_toast.dart';

// ponytail: copying is the whole action — add url_launcher and swap in
// `launchUrl` if tel:/mailto:/https: should actually open.
/// Copies a contact detail and confirms it with a toast.
Future<void> copyContactDetail(BuildContext context, String value) async {
  final l10n = context.l10n;
  await Clipboard.setData(ClipboardData(text: value));
  if (!context.mounted) return;
  AppToast.show(
    context,
    title: l10n.legalContactTitle,
    message: l10n.legalCopied,
    type: AppFeedbackType.success,
  );
}
