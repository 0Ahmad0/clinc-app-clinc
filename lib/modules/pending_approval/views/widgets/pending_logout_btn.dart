import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/pending_approval_controller.dart';

/// Logout button displayed in the header trailing area.
class PendingLogoutBtn extends GetView<PendingApprovalController> {
  const PendingLogoutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.logout,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout_rounded, color: Colors.white, size: 15.r),
            6.horizontalSpace,
            Text(
              'تسجيل الخروج',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
