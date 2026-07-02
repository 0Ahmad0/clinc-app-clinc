import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/contact_support_controller.dart';

class ContactSupportView extends GetView<ContactSupportController> {
  const ContactSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('settings.contact_support'))),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            Obx(
              () => DropdownButtonFormField<String>(
                initialValue: controller.selectedSubject.value,
                decoration: InputDecoration(
                  labelText: tr('settings.support.subject'),
                  prefixIcon: const Icon(Icons.topic_outlined),
                ),
                items: ContactSupportController.subjects
                    .map(
                      (subject) => DropdownMenuItem(
                        value: subject,
                        child: Text(tr('settings.support.subjects.$subject')),
                      ),
                    )
                    .toList(),
                onChanged: (value) => controller.selectedSubject.value = value,
                validator: (value) => value == null
                    ? tr('settings.support.subject_required')
                    : null,
              ),
            ),
            Obx(
              () => controller.isOther
                  ? Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: TextFormField(
                        controller: controller.customSubjectController,
                        decoration: InputDecoration(
                          labelText: tr('settings.support.custom_subject'),
                        ),
                        validator: controller.validateRequired,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            16.verticalSpace,
            TextFormField(
              controller: controller.descriptionController,
              decoration: InputDecoration(
                labelText: tr('settings.support.description'),
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.description_outlined),
              ),
              minLines: 5,
              maxLines: 8,
              validator: controller.validateRequired,
            ),
            18.verticalSpace,
            OutlinedButton.icon(
              onPressed: controller.pickImages,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: Text(tr('settings.support.add_images')),
            ),
            Obx(
              () => controller.imagePaths.isEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(top: 14.h),
                      child: SizedBox(
                        height: 92.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.imagePaths.length,
                          separatorBuilder: (_, _) => 10.horizontalSpace,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.file(
                                    File(controller.imagePaths[index]),
                                    width: 92.r,
                                    height: 92.r,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                PositionedDirectional(
                                  top: 2,
                                  end: 2,
                                  child: IconButton.filled(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () =>
                                        controller.removeImage(index),
                                    icon: const Icon(Icons.close, size: 16),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
            ),
            28.verticalSpace,
            Obx(
              () => FilledButton.icon(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.submit,
                icon: controller.isLoading.value
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_outlined),
                label: Text(tr('settings.support.submit')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
