import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/pending_approval_controller.dart';

class PendingApprovalView extends GetView<PendingApprovalController> {
  const PendingApprovalView({super.key});

  static const _amber = Color(0xFFF59E0B);
  static const _darkAmber = Color(0xFF92400E);
  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildTopBanner(context)),
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

  Widget _buildTopBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF78350F), _darkAmber, _amber],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
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
                            style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            28.verticalSpace,
            Container(
              width: 90.r,
              height: 90.r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.access_time_rounded, size: 50.r, color: Colors.white),
                    Positioned(
                      bottom: 14.r,
                      right: 14.r,
                      child: Container(
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
                  ],
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              tr(LocaleKeys.pending_approval_title),
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                tr(LocaleKeys.pending_approval_subtitle),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.82), fontSize: 12.sp, height: 1.5),
              ),
            ),
            28.verticalSpace,
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
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 4))],
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
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.sp, color: Colors.grey.shade800),
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
                        style: TextStyle(color: _amber, fontSize: 11.sp, fontWeight: FontWeight.w700),
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
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp, height: 1.6),
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
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('مراحل التفعيل', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.sp, color: Colors.grey.shade800)),
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
        Obx(() => GestureDetector(
          onTap: controller.isLoading.value ? null : controller.checkStatus,
          child: Container(
            width: double.infinity,
            height: 52.h,
            decoration: BoxDecoration(
              gradient: controller.isLoading.value
                  ? null
                  : const LinearGradient(
                      colors: [_amber, Color(0xFFD97706)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: controller.isLoading.value ? Colors.grey.shade300 : null,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: controller.isLoading.value
                  ? []
                  : [BoxShadow(color: _amber.withValues(alpha: 0.38), blurRadius: 14, offset: const Offset(0, 5))],
            ),
            child: Center(
              child: controller.isLoading.value
                  ? SizedBox(
                      width: 22.r,
                      height: 22.r,
                      child: const CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh_rounded, color: Colors.white, size: 18.r),
                        8.horizontalSpace,
                        Text(
                          tr(LocaleKeys.pending_approval_buttons_check_status),
                          style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
            ),
          ),
        )),
        16.verticalSpace,
        GestureDetector(
          onTap: controller.contactSupport,
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 3))],
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.support_agent_rounded, color: Colors.grey.shade600, size: 18.r),
                  8.horizontalSpace,
                  Text(
                    tr(LocaleKeys.pending_approval_buttons_contact_support),
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
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
  const _Step({required this.icon, required this.color, required this.label, required this.done, this.active = false});
}
