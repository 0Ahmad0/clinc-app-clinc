import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/settings_controller.dart';

class SettingsLogoutBtn extends GetView<SettingsController> {
  const SettingsLogoutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: GestureDetector(
          onTap: controller.showLogoutDialog,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
                10.horizontalSpace,
                Text(
                  tr(LocaleKeys.settings_logout),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
