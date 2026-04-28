import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/ads_controller.dart';

class CreateSingleAdView extends GetView<AdsController> {
  const CreateSingleAdView({super.key});

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
          tr('ads.create.title'),
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _ImageUploader(controller: controller),
                  14.verticalSpace,
                  _Field(
                    controller: controller.titleController,
                    hint: tr('ads.form.title_hint'),
                    maxLines: 1,
                  ),
                  12.verticalSpace,
                  _Field(
                    controller: controller.descriptionController,
                    hint: tr('ads.form.description_hint'),
                    maxLines: 4,
                  ),
                  16.verticalSpace,
                  RichText(
                    text: TextSpan(
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                      children: [
                        TextSpan(text: '${tr('ads.payment.price')}: '),
                        TextSpan(
                          text: '${controller.currentPrice} ${tr('ads.payment.currency')}',
                          style: const TextStyle(color: _primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.selectedFlowType.value = AdFlowType.single;
                  controller.goToPayment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary.withValues(alpha: 0.6),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  tr('ads.create.publish'),
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

class _ImageUploader extends StatelessWidget {
  final AdsController controller;

  const _ImageUploader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final path = controller.selectedImagePath.value;
      return InkWell(
        onTap: controller.pickImage,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          height: 140.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: path.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_a_photo_outlined, color: Color(0xFF3498DB)),
                    8.verticalSpace,
                    Text(
                      tr('ads.form.upload_image'),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.file(
                    File(path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 140.h,
                  ),
                ),
        ),
      );
    });
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _Field({
    required this.controller,
    required this.hint,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
    );
  }
}

