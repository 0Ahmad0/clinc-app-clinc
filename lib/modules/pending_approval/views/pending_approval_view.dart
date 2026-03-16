import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_button.dart';
import '../../../app/core/widgets/app_gradient_header.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/pending_approval_controller.dart';

class PendingApprovalView extends GetView<PendingApprovalController> {
  const PendingApprovalView({super.key});

  static const _amber = Color(0xFFF59E0B);
  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: AppGradientHeader(
              gradient: AppGradients.amber,
              icon: Icons.access_time_rounded,
              iconCircleSize: 90,
              iconSize: 50,
              bottomRadius: 40,
              title: tr(LocaleKeys.pending_approval_title),
              subtitle: tr(LocaleKeys.pending_approval_subtitle),
              trailing: _buildLogoutButton(),
              badge: Container(
                width: 22.r,
                height: 22.r,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: _amber, width: 1.5),
                ),
                child: Icon(Icons.hourglass_empty_rounded, size: 12.r, color: _amber),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                28.verticalSpace,
                _buildStatusCard(),
                20.verticalSpace,
                _buildStepsCard(),
                20.verticalSpace,
                _buildActionsCard(),
                32.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
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

  Widget _buildStatusCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42.r,
                height: 42.r,
                decoration: BoxDecoration(
                  color: _amber.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.info_rounded, color: _amber, size: 22.r),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'حالة الطلب',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    4.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: _amber.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'قيد المراجعة',
                        style: TextStyle(
                          color: _amber,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              tr(LocaleKeys.pending_approval_description),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12.sp,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsCard() {
    final steps = [
      _Step(icon: Icons.check_circle_rounded, color: _teal, label: 'تسجيل الحساب', done: true),
      _Step(icon: Icons.pending_rounded, color: _amber, label: 'مراجعة الطلب', done: false, active: true),
      _Step(icon: Icons.verified_rounded, color: Colors.grey.shade400, label: 'التفعيل والانطلاق', done: false),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مراحل التفعيل',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14.sp,
              color: Colors.grey.shade800,
            ),
          ),
          16.verticalSpace,
          ...List.generate(steps.length, (i) {
            final step = steps[i];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: step.color.withValues(alpha: step.done || step.active ? 0.12 : 0.06),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: step.active ? step.color : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(step.icon, color: step.color, size: 18.r),
                    ),
                    if (i < steps.length - 1)
                      Container(
                        width: 2.w,
                        height: 28.h,
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        color: Colors.grey.shade200,
                      ),
                  ],
                ),
                12.horizontalSpace,
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    step.label,
                    style: TextStyle(
                      fontWeight: step.active ? FontWeight.w800 : FontWeight.w500,
                      fontSize: 13.sp,
                      color: step.done || step.active ? Colors.grey.shade800 : Colors.grey.shade400,
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionsCard() {
    return Column(
      children: [
        Obx(() => AppGradientButton(
          label: tr(LocaleKeys.pending_approval_buttons_check_status),
          isLoading: controller.isLoading.value,
          onTap: controller.checkStatus,
          gradient: AppGradients.amber,
          shadowColor: AppGradients.amberShadow,
          prefixIcon: Icon(Icons.refresh_rounded, color: Colors.white, size: 18.r),
        )),
        16.verticalSpace,
        AppOutlineGradientButton(
          label: tr(LocaleKeys.pending_approval_buttons_contact_support),
          onTap: controller.contactSupport,
          borderColor: Colors.grey.shade200,
          textColor: Colors.grey.shade700,
          prefixIcon: Icon(Icons.support_agent_rounded, color: Colors.grey.shade600, size: 18.r),
        ),
      ],
    );
  }
}

class _Step {
  final IconData icon;
  final Color color;
  final String label;
  final bool done;
  final bool active;

  const _Step({
    required this.icon,
    required this.color,
    required this.label,
    required this.done,
    this.active = false,
  });
}
