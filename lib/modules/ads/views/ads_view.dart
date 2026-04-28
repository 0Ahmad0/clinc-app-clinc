import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/ads_controller.dart';

class AdsView extends GetView<AdsController> {
  const AdsView({super.key});

  static const _bg = Color(0xFFF1F3F8);
  static const _primary = Color(0xFF3498DB);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          tr('ads.list.title'),
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Get.toNamed(
              AppRoutes.adsType,
              arguments: {'role': controller.accountType.value.name},
            ),
            icon: const Icon(Icons.add, color: _primary),
            label: Text(
              tr('ads.list.create_short'),
              style: const TextStyle(color: _primary, fontWeight: FontWeight.w700),
            ),
          ),
          8.horizontalSpace,
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 24.h),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  const Icon(Icons.badge_rounded, color: _primary),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      tr('ads.list.role_label', args: [tr(controller.currentRoleLabelKey)]),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            14.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed(
                  AppRoutes.adsType,
                  arguments: {'role': controller.accountType.value.name},
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  tr('ads.list.create'),
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17.sp),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),
            ),
            14.verticalSpace,
            Expanded(
              child: Obx(
                () => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.ads.length,
                  separatorBuilder: (_, __) => 12.verticalSpace,
                  itemBuilder: (_, index) {
                    final ad = controller.ads[index];
                    return _AdCard(ad: ad, controller: controller);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdCard extends StatelessWidget {
  final AdCampaign ad;
  final AdsController controller;

  const _AdCard({required this.ad, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = ad.isActive ? const Color(0xFF22C55E) : const Color(0xFFEF4444);

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ad.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 30.sp,
            ),
          ),
          10.verticalSpace,
          Row(
            children: [
              Container(
                width: 10.r,
                height: 10.r,
                decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
              ),
              8.horizontalSpace,
              Text(
                ad.isActive ? tr('ads.status.active') : tr('ads.status.finished'),
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            '${tr('ads.list.start')}: ${controller.formatDateTime(ad.startAt)}',
            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          4.verticalSpace,
          Text(
            '${tr('ads.list.end')}: ${controller.formatDateTime(ad.endAt)}',
            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          4.verticalSpace,
          Text(
            '${tr('ads.list.remaining')}: ${controller.remainingForAd(ad)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

