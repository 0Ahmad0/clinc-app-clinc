import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/settings_controller.dart';
import '../profile_view.dart';

class SettingsHeroHeader extends GetView<SettingsController> {
  const SettingsHeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SliverAppBar(
      pinned: true,
      expandedHeight: 200.h,
      backgroundColor: const Color(0xFF4527A0),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: Get.back,
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
      ),
      title: Text(
        tr(LocaleKeys.settings_title),
        style: theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _HeaderBackground(isDark: isDark),
      ),
    );
  }
}

class _HeaderBackground extends GetView<SettingsController> {
  final bool isDark;
  const _HeaderBackground({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF311B92), const Color(0xFF1A0050)]
              : [const Color(0xFF673AB7), const Color(0xFF311B92)],
        ),
      ),
      child: SafeArea(
        child: Obx(() {
          final profile = controller.profile.value;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              60.verticalSpace,
              GestureDetector(
                onTap: () => Get.to(() => const ProfileView()),
                child: Stack(
                  children: [
                    Container(
                      width: 72.r,
                      height: 72.r,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF9C27B0), Color(0xFF673AB7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          profile.name.isNotEmpty ? profile.name[0] : 'م',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 22.r,
                        height: 22.r,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C4DFF),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.edit_rounded,
                          color: Colors.white,
                          size: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              Text(
                profile.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              4.verticalSpace,
              Text(
                profile.email,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
