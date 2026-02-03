import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../controllers/settings_controller.dart';

class LanguageDialog extends GetView<SettingsController> {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AlertDialog(
      title: Text(
        tr(LocaleKeys.settings_language),
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Obx(() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageOption(
            title: 'العربية',
            code: 'ar',
            isSelected: controller.currentLanguage.value == 'ar',
            onTap: () => controller.changeLanguage('ar'),
          ),
          12.verticalSpace,
          _LanguageOption(
            title: 'English',
            code: 'en',
            isSelected: controller.currentLanguage.value == 'en',
            onTap: () => controller.changeLanguage('en'),
          ),
        ],
      )),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            tr(LocaleKeys.settings_close),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? cs.primary.withOpacity(0.1) : cs.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? cs.primary : cs.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Text(
              code.toUpperCase(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: isSelected ? cs.primary : cs.onSurfaceVariant,
              ),
            ),
            12.horizontalSpace,
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? cs.onSurface : cs.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: cs.primary,
              ),
          ],
        ),
      ),
    );
  }
}