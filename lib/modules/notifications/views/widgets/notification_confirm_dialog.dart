import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../generated/locale_keys.g.dart';

/// Reusable confirm/alert dialog used by header actions and card dismissal.
class NotificationConfirmDialog extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onConfirm;
  final bool isDestructive;

  const NotificationConfirmDialog({
    super.key,
    required this.title,
    required this.body,
    required this.onConfirm,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
      ),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(tr(LocaleKeys.notifications_cancel)),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Get.back(result: true);
          },
          child: Text(
            tr(LocaleKeys.notifications_confirm),
            style: TextStyle(
              color: isDestructive ? cs.error : cs.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
