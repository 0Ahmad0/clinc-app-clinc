import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../controllers/settings_controller.dart';

void showThemeBottomSheet() {
  Get.bottomSheet(
    const _ThemeSheet(),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class _ThemeSheet extends GetView<SettingsController> {
  const _ThemeSheet();

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
                      colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.brightness_6_rounded, color: Colors.white, size: 20.sp),
                ),
                14.horizontalSpace,
                Text(
                  tr(LocaleKeys.settings_theme),
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
                _ThemeTile(
                  icon: Icons.brightness_auto_rounded,
                  title: tr(LocaleKeys.settings_theme_system),
                  subtitle: 'يتبع إعدادات الجهاز',
                  mode: ThemeMode.system,
                  isSelected: controller.themeMode.value == ThemeMode.system,
                  onTap: () => controller.changeTheme(ThemeMode.system),
                  color: const Color(0xFF6366F1),
                ),
                SizedBox(height: 10.h),
                _ThemeTile(
                  icon: Icons.light_mode_rounded,
                  title: tr(LocaleKeys.settings_theme_light),
                  subtitle: 'واجهة فاتحة دائماً',
                  mode: ThemeMode.light,
                  isSelected: controller.themeMode.value == ThemeMode.light,
                  onTap: () => controller.changeTheme(ThemeMode.light),
                  color: const Color(0xFFF59E0B),
                ),
                SizedBox(height: 10.h),
                _ThemeTile(
                  icon: Icons.dark_mode_rounded,
                  title: tr(LocaleKeys.settings_theme_dark),
                  subtitle: 'واجهة داكنة دائماً',
                  mode: ThemeMode.dark,
                  isSelected: controller.themeMode.value == ThemeMode.dark,
                  onTap: () => controller.changeTheme(ThemeMode.dark),
                  color: const Color(0xFF6366F1),
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
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                child: Text(
                  tr(LocaleKeys.settings_close),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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

class _ThemeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final ThemeMode mode;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _ThemeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.mode,
    required this.isSelected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.08) : cs.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? color : cs.outlineVariant.withValues(alpha: 0.2),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: isSelected ? color.withValues(alpha: 0.15) : cs.outlineVariant.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: isSelected ? color : cs.onSurfaceVariant, size: 20.sp),
            ),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isSelected ? color : cs.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
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
                color: isSelected ? color : Colors.transparent,
                border: Border.all(
                  color: isSelected ? color : cs.outlineVariant,
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
