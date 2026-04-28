import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/ads_controller.dart';

class AdsTypeView extends GetView<AdsController> {
  const AdsTypeView({super.key});

  static const _bg = Color(0xFFF1F3F8);

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
          tr('ads.type.title'),
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
        child: Column(
          children: [
            _TypeCard(
              title: tr('ads.type.single'),
              icon: Icons.campaign_outlined,
              onTap: controller.chooseSingleFlow,
            ),
            14.verticalSpace,
            Obx(
              () => _TypeCard(
                title: tr('ads.type.package'),
                icon: Icons.inventory_2_outlined,
                disabled: !controller.canUsePackages,
                subtitle: !controller.canUsePackages ? tr('ads.messages.not_available_for_role') : null,
                onTap: controller.choosePackageFlow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool disabled;
  final VoidCallback onTap;

  const _TypeCard({
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: disabled ? 0.7 : 0.92),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  if (subtitle != null) ...[
                    6.verticalSpace,
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(color: const Color(0xFFEF4444)),
                    ),
                  ],
                ],
              ),
            ),
            Icon(icon, color: const Color(0xFF3498DB), size: 26.sp),
          ],
        ),
      ),
    );
  }
}

