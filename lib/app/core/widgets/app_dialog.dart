import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../design/app_gradients.dart';
import 'app_gradient_button.dart';

enum AppDialogType { confirm, alert, info, danger }

class AppDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? body;
  final AppDialogType type;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showCancel;
  final IconData? icon;

  const AppDialog({
    super.key,
    required this.title,
    this.message,
    this.body,
    this.type = AppDialogType.confirm,
    this.confirmLabel = 'تأكيد',
    this.cancelLabel = 'إلغاء',
    this.onConfirm,
    this.onCancel,
    this.showCancel = true,
    this.icon,
  });

  static Future<bool?> show({
    required String title,
    String? message,
    Widget? body,
    AppDialogType type = AppDialogType.confirm,
    String confirmLabel = 'تأكيد',
    String cancelLabel = 'إلغاء',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool showCancel = true,
    IconData? icon,
  }) {
    return Get.dialog<bool>(
      AppDialog(
        title: title,
        message: message,
        body: body,
        type: type,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        showCancel: showCancel,
        icon: icon,
      ),
      barrierDismissible: true,
    );
  }

  LinearGradient get _gradient {
    switch (type) {
      case AppDialogType.confirm:
        return AppGradients.teal;
      case AppDialogType.info:
        return AppGradients.indigo;
      case AppDialogType.alert:
        return AppGradients.amber;
      case AppDialogType.danger:
        return AppGradients.red;
    }
  }

  Color get _shadowColor {
    switch (type) {
      case AppDialogType.confirm:
        return AppGradients.tealShadow;
      case AppDialogType.info:
        return AppGradients.indigoShadow;
      case AppDialogType.alert:
        return AppGradients.amberShadow;
      case AppDialogType.danger:
        return AppGradients.redShadow;
    }
  }

  IconData get _defaultIcon {
    switch (type) {
      case AppDialogType.confirm:
        return Icons.check_circle_outline_rounded;
      case AppDialogType.info:
        return Icons.info_outline_rounded;
      case AppDialogType.alert:
        return Icons.warning_amber_rounded;
      case AppDialogType.danger:
        return Icons.delete_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gradient top strip with icon
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24.h),
              decoration: BoxDecoration(gradient: _gradient),
              child: Column(
                children: [
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon ?? _defaultIcon, color: Colors.white, size: 32.r),
                  ),
                  12.verticalSpace,
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (message != null) ...[
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13.sp,
                        height: 1.6,
                      ),
                    ),
                    16.verticalSpace,
                  ],
                  if (body != null) ...[body!, 16.verticalSpace],
                  AppGradientButton(
                    label: confirmLabel,
                    gradient: _gradient,
                    shadowColor: _shadowColor,
                    height: 46,
                    borderRadius: 12,
                    onTap: () {
                      Get.back(result: true);
                      onConfirm?.call();
                    },
                  ),
                  if (showCancel) ...[
                    8.verticalSpace,
                    AppOutlineGradientButton(
                      label: cancelLabel,
                      height: 46,
                      borderRadius: 12,
                      borderColor: Colors.grey.shade300,
                      textColor: Colors.grey.shade600,
                      onTap: () {
                        Get.back(result: false);
                        onCancel?.call();
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
