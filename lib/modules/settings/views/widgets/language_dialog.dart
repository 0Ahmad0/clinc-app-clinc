import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../controllers/settings_controller.dart';

void showLanguageBottomSheet() {
  Get.bottomSheet(
    const _LanguageSheet(),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class _LanguageSheet extends GetView<SettingsController> {
  const _LanguageSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.language_rounded, color: Colors.white, size: 20.sp),
                ),
                14.horizontalSpace,
                Text(
                  tr(LocaleKeys.settings_language),
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(() => Column(
              children: [
                _LangTile(
                  flagEmoji: '🇸🇦',
                  nativeName: 'العربية',
                  englishName: 'Arabic',
                  code: 'ar',
                  isSelected: controller.currentLanguage.value == 'ar',
                  onTap: () => controller.changeLanguage('ar'),
                ),
                SizedBox(height: 10.h),
                _LangTile(
                  flagEmoji: '🇺🇸',
                  nativeName: 'English',
                  englishName: 'الإنجليزية',
                  code: 'en',
                  isSelected: controller.currentLanguage.value == 'en',
                  onTap: () => controller.changeLanguage('en'),
                ),
              ],
            )),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    side: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.4)),
                  ),
                ),
                child: Text(
                  tr(LocaleKeys.settings_close),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
        ],
      ),
    );
  }
}

class _LangTile extends StatelessWidget {
  final String flagEmoji;
  final String nativeName;
  final String englishName;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  const _LangTile({
    required this.flagEmoji,
    required this.nativeName,
    required this.englishName,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    const green = Color(0xFF10B981);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? green.withValues(alpha: 0.08) : cs.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? green : cs.outlineVariant.withValues(alpha: 0.2),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flagEmoji, style: TextStyle(fontSize: 28.sp)),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nativeName,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isSelected ? green : cs.onSurface,
                    ),
                  ),
                  Text(
                    englishName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22.r,
              height: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? green : Colors.transparent,
                border: Border.all(
                  color: isSelected ? green : cs.outlineVariant,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check_rounded, color: Colors.white, size: 13.sp)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
