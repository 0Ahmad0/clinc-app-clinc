import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

import '../../../generated/locale_keys.g.dart';
import '../controllers/add_doctor_controller.dart';

class AddDoctorView extends GetView<AddDoctorController> {
  const AddDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
              () => Text(
            controller.isEditMode.value
                ? tr(LocaleKeys.add_doctor_edit_title)
                : tr(LocaleKeys.add_doctor_title),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. Image Picker ---
              Center(
                child: GestureDetector(
                  onTap: controller.pickImage,
                  child: Obx(() {
                    return CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: controller.selectedImage.value.isNotEmpty
                          ? FileImage(File(controller.selectedImage.value))
                          : null,
                      child: controller.selectedImage.value.isEmpty
                          ? Icon(
                        Icons.camera_alt,
                        size: 30.sp,
                        color: Colors.grey,
                      )
                          : null,
                    );
                  }),
                ),
              ),
              SizedBox(height: 20.h),

              // --- 2. Basic Info ---
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller.nameArController,
                      tr(LocaleKeys.add_doctor_labels_name_ar),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildTextField(
                      controller.nameEnController,
                      tr(LocaleKeys.add_doctor_labels_name_en),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              // Specialty Dropdown
              Obx(
                    () => DropdownButtonFormField<String>(
                  decoration: _inputDecoration(
                    tr(LocaleKeys.add_doctor_labels_specialty),
                  ),
                  hint: Text(tr(LocaleKeys.add_doctor_labels_specialty_hint)),
                  value: controller.selectedSpecialty.value.isEmpty
                      ? null
                      : controller.selectedSpecialty.value,
                  items: controller.specialties.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) => controller.selectedSpecialty.value = val!,
                  validator: (val) => val == null
                      ? tr(LocaleKeys.add_doctor_validations_required)
                      : null,
                ),
              ),

              SizedBox(height: 10.h),
              _buildTextField(
                controller.feeController,
                tr(LocaleKeys.add_doctor_labels_fee),
                isNumber: true,
              ),

              // --- 3. Professional Info ---
              SizedBox(height: 20.h),
              _buildTextField(
                controller.licenseController,
                tr(LocaleKeys.add_doctor_labels_license),
              ),
              SizedBox(height: 10.h),
              _buildTextField(
                controller.experienceController,
                tr(LocaleKeys.add_doctor_labels_experience),
                isNumber: true,
              ),
              SizedBox(height: 10.h),
              _buildTextField(
                controller.aboutController,
                tr(LocaleKeys.add_doctor_labels_about),
                maxLines: 3,
              ),

              // --- 4. Qualification Files (PDFs) ---
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(LocaleKeys.add_doctor_labels_qualification_files),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: controller.pickPDFs,
                    icon: Icon(Icons.attach_file),
                    label: Text(tr(LocaleKeys.add_doctor_buttons_upload_files)),
                  ),
                ],
              ),

              // عرض الملفات المختارة
              Obx(() => Column(
                children: controller.qualificationFiles.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String path = entry.value;
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                      title: Text(path.split('/').last, maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.removeFile(idx),
                      ),
                    ),
                  );
                }).toList(),
              )),


              // --- 5. Working Hours Section ---
              SizedBox(height: 20.h),
              Text(
                tr(LocaleKeys.working_hours_title),
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor
                ),
              ),
              SizedBox(height: 10.h),

              Obx(() => Column(
                children: List.generate(controller.workingHoursList.length, (index) {
                  var workDay = controller.workingHoursList[index];
                  // Assuming "working_hours.days.Saturday" key format exists
                  String dayNameKey = "working_hours.days.${workDay.day}";
                  // Fallback to English day name if translation fails/is missing for now to prevent crash
                  String dayName = tr(dayNameKey);
                  if (dayName == dayNameKey) dayName = workDay.day;

                  return Card(
                    margin: EdgeInsets.only(bottom: 8.h),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dayName,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                              ),
                              Row(
                                children: [
                                  Text(
                                    workDay.isDayOff
                                        ? tr(LocaleKeys.working_hours_day_off)
                                        : tr(LocaleKeys.working_hours_work_day),
                                    style: TextStyle(
                                        color: workDay.isDayOff ? Colors.red : Colors.green,
                                        fontSize: 12.sp
                                    ),
                                  ),
                                  Switch(
                                    value: !workDay.isDayOff,
                                    activeColor: Colors.green,
                                    onChanged: (val) => controller.toggleDayOff(index, val),
                                  ),
                                ],
                              )
                            ],
                          ),
                          if (!workDay.isDayOff) ...[
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTimePicker(
                                    context,
                                    title: tr(LocaleKeys.working_hours_from),
                                    time: workDay.startTime ?? "--:--",
                                    onTap: () => controller.selectTime(context, index, true),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Icon(Icons.arrow_forward, size: 16.sp, color: Colors.grey),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: _buildTimePicker(
                                    context,
                                    title: tr(LocaleKeys.working_hours_to),
                                    time: workDay.endTime ?? "--:--",
                                    onTap: () => controller.selectTime(context, index, false),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
              )),


              // --- 6. Availability ---
              SizedBox(height: 20.h),
              Obx(
                    () => SwitchListTile(
                  title: Text(tr(LocaleKeys.add_doctor_labels_availability)),
                  value: controller.isAvailable.value,
                  onChanged: (val) => controller.isAvailable.value = val,
                ),
              ),

              // --- 7. Submit Button ---
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: controller.saveDoctor,
                  child: Obx(
                        () => Text(
                      controller.isEditMode.value
                          ? tr(LocaleKeys.add_doctor_buttons_update)
                          : tr(LocaleKeys.add_doctor_buttons_save),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController ctrl,
      String label, {
        bool isNumber = false,
        int maxLines = 1,
      }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      validator: (val) =>
      val!.isEmpty ? tr(LocaleKeys.add_doctor_validations_required) : null,
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      labelText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    );
  }

  Widget _buildTimePicker(BuildContext context, {required String title, required String time, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.access_time, size: 16.sp, color: Theme.of(context).primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
