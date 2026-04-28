import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/ads_controller.dart';

class AdsPaymentView extends GetView<AdsController> {
  const AdsPaymentView({super.key});

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
          tr('ads.payment.title'),
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  Text(
                    tr('ads.payment.price'),
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Obx(
                    () => Text(
                      '${controller.currentPrice} ${tr('ads.payment.currency')}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: _primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            14.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('ads.payment.methods_title'),
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  12.verticalSpace,
                  _MethodTile(
                    id: 'card',
                    icon: Icons.credit_card_rounded,
                    label: tr('ads.payment.methods.card'),
                    controller: controller,
                  ),
                  10.verticalSpace,
                  _MethodTile(
                    id: 'apple',
                    icon: Icons.phone_iphone_rounded,
                    label: tr('ads.payment.methods.apple'),
                    controller: controller,
                  ),
                  10.verticalSpace,
                  _MethodTile(
                    id: 'mada',
                    icon: Icons.account_balance_wallet_rounded,
                    label: tr('ads.payment.methods.mada'),
                    controller: controller,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.completePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  tr('ads.payment.pay_now'),
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final String id;
  final IconData icon;
  final String label;
  final AdsController controller;

  const _MethodTile({
    required this.id,
    required this.icon,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedPaymentMethod.value == id;
      return InkWell(
        onTap: () => controller.selectedPaymentMethod.value = id,
        borderRadius: BorderRadius.circular(11.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.r),
            border: Border.all(
              color: selected ? const Color(0xFF3498DB) : const Color(0xFFCBD5E1),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF3498DB)),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                ),
              ),
              Icon(
                selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: const Color(0xFF3498DB),
              ),
            ],
          ),
        ),
      );
    });
  }
}

