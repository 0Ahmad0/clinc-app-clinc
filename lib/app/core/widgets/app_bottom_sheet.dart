import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../design/app_gradients.dart';

class AppBottomSheet {
  AppBottomSheet._();

  /// Generic bottom sheet with a gradient header strip + scrollable body
  static Future<T?> show<T>({
    required String title,
    required Widget body,
    String? subtitle,
    LinearGradient gradient = AppGradients.teal,
    bool isDismissible = true,
    bool isScrollControlled = true,
    double initialChildSize = 0.5,
    double maxChildSize = 0.9,
    double minChildSize = 0.3,
  }) {
    return Get.bottomSheet<T>(
      _AppBottomSheetContent(
        title: title,
        subtitle: subtitle,
        body: body,
        gradient: gradient,
        initialChildSize: initialChildSize,
        maxChildSize: maxChildSize,
        minChildSize: minChildSize,
      ),
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
    );
  }

  /// Quick options picker (list of tiles)
  static Future<T?> showOptions<T>({
    required String title,
    required List<AppBottomSheetOption<T>> options,
    String? subtitle,
    LinearGradient gradient = AppGradients.teal,
  }) {
    return show<T>(
      title: title,
      subtitle: subtitle,
      gradient: gradient,
      initialChildSize: 0.35 + (options.length * 0.08),
      maxChildSize: 0.85,
      body: Column(
        children: options
            .map((o) => _OptionTile<T>(option: o))
            .toList(),
      ),
    );
  }
}

class AppBottomSheetOption<T> {
  final IconData icon;
  final String label;
  final String? subtitle;
  final T value;
  final Color? color;

  const AppBottomSheetOption({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.value,
    this.color,
  });
}

// ─── Private Widgets ───────────────────────────────────────────────────────

class _AppBottomSheetContent extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget body;
  final LinearGradient gradient;
  final double initialChildSize;
  final double maxChildSize;
  final double minChildSize;

  const _AppBottomSheetContent({
    required this.title,
    required this.body,
    required this.gradient,
    required this.initialChildSize,
    required this.maxChildSize,
    required this.minChildSize,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      minChildSize: minChildSize,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 4.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              // Header strip
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 28.r,
                            height: 28.r,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close_rounded, color: Colors.white, size: 16.r),
                          ),
                        ),
                      ],
                    ),
                    if (subtitle != null) ...[
                      4.verticalSpace,
                      Text(
                        subtitle!,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.78),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Body
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  padding: EdgeInsets.all(20.r),
                  child: body,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OptionTile<T> extends StatelessWidget {
  final AppBottomSheetOption<T> option;

  const _OptionTile({required this.option});

  @override
  Widget build(BuildContext context) {
    final color = option.color ?? const Color(0xFF009688);
    return GestureDetector(
      onTap: () => Get.back(result: option.value),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(option.icon, color: color, size: 20.r),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  if (option.subtitle != null) ...[
                    2.verticalSpace,
                    Text(
                      option.subtitle!,
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 20.r),
          ],
        ),
      ),
    );
  }
}
