import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

import '../../../app/data/doctor_model.dart';
import '../../../generated/locale_keys.g.dart';
import '../../add_doctor/views/add_doctor_view.dart';
import '../controllers/doctors_controller.dart';

class DoctorDetailsView extends GetView<DoctorsController> {
  const DoctorDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctor = Get.arguments as DoctorModel;

    final theme = Theme.of(context);
    final isAr = context.locale.languageCode == 'ar';
    final name = isAr ? doctor.nameAr : doctor.nameEn;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 260.h,
            pinned: true,
            backgroundColor: theme.primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => const AddDoctorView(), arguments: doctor);
                },
                icon: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
              ),
              SizedBox(width: 8.w),
              // زر الحذف
              IconButton(
                onPressed: () => _showDeleteDialog(context, doctor),
                icon: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
              ),
              SizedBox(width: 16.w),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'doctor_img_${doctor.id}',
                    child: doctor.imagePath.isNotEmpty
                        ? Image.file(File(doctor.imagePath), fit: BoxFit.cover)
                        : Image.network(
                            'https://img.freepik.com/free-photo/doctor-offering-medical-advice_23-2147796524.jpg',
                            // Placeholder احترافي
                            fit: BoxFit.cover,
                          ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. المحتوى الرئيسي
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: Offset(0, -30.h), // رفع المحتوى ليتداخل مع الصورة
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    // --- بطاقة المعلومات الرئيسية ---
                    _buildMainInfoCard(context, doctor, name),

                    SizedBox(height: 20.h),

                    // --- أزرار الاتصال السريع ---
                    _buildQuickActions(context, doctor),

                    SizedBox(height: 20.h),

                    // --- النبذة ---
                    _buildSectionHeader(
                      context,
                      tr(LocaleKeys.add_doctor_labels_about),
                      Icons.person_outline,
                    ),
                    _buildContentCard(
                      child: Text(
                        doctor.about,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // --- جدول المواعيد (Working Hours) ---
                    _buildSectionHeader(
                      context,
                      tr(LocaleKeys.working_hours_title),
                      Icons.access_time,
                    ),
                    _buildWorkingHoursCard(context, doctor),

                    SizedBox(height: 20.h),

                    // --- الملفات المرفقة (إن وجدت) ---
                    if (doctor.qualificationFiles.isNotEmpty) ...[
                      _buildSectionHeader(
                        context,
                        tr(LocaleKeys.add_doctor_labels_qualification_files),
                        Icons.file_present,
                      ),
                      _buildDocumentsList(doctor),
                      SizedBox(height: 30.h),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // Widgets Components
  // ===========================================================================

  Widget _buildMainInfoCard(
    BuildContext context,
    DoctorModel doctor,
    String name,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              doctor.specialty,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // إحصائيات سريعة (خبرة، سعر، حالة)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                value: "${doctor.yearsOfExperience}+",
                label: tr(LocaleKeys.add_doctor_labels_experience),
              ),
              Container(width: 1, height: 40.h, color: Colors.grey[200]),
              _buildStatItem(
                context,
                value: "\$${doctor.fee.toInt()}",
                label: tr(LocaleKeys.add_doctor_labels_fee),
              ),
              Container(width: 1, height: 40.h, color: Colors.grey[200]),
              _buildStatItem(
                context,
                value: doctor.isAvailable
                    ? tr(LocaleKeys.doctors_page_status_active)
                    : tr(LocaleKeys.doctors_page_status_inactive),
                label: "الحالة",
                textColor: doctor.isAvailable ? Colors.green : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String value,
    required String label,
    Color? textColor,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.black87,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, DoctorModel doctor) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            context,
            icon: Icons.call,
            label: "اتصال",
            color: Colors.green,
            onTap: () {
              // Logic to launch dialer
              Get.snackbar(
                "اتصال",
                "جاري الاتصال بـ ${doctor.phone}...",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildActionButton(
            context,
            icon: Icons.email,
            label: "إيميل",
            color: Colors.blueAccent,
            onTap: () {
              Get.snackbar(
                "إيميل",
                "جاري فتح الإيميل لـ ${doctor.email}...",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHoursCard(BuildContext context, DoctorModel doctor) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: doctor.workingHours.map((wh) {
          final isClosed = wh.isDayOff;
          // جلب اسم اليوم المترجم
          String dayName = tr("working_hours.days.${wh.day}");
          // (fallback if translation fails)
          if (dayName.contains("working_hours")) dayName = wh.day;

          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isClosed ? Colors.red[200] : Colors.green,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      dayName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Text(
                  isClosed
                      ? tr(LocaleKeys.working_hours_day_off)
                      : "${wh.startTime} - ${wh.endTime}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isClosed ? Colors.red[300] : Colors.black54,
                    fontWeight: isClosed ? FontWeight.normal : FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDocumentsList(DoctorModel doctor) {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: doctor.qualificationFiles.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          String path = doctor.qualificationFiles[index];
          String fileName = path.split('/').last;

          return Container(
            width: 200.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(Icons.picture_as_pdf, color: Colors.red),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "PDF Document",
                        style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: Theme.of(context).primaryColor),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  // --- Delete Dialog ---
  void _showDeleteDialog(BuildContext context, DoctorModel doctor) {
    final isAr = context.locale.languageCode == 'ar';
    Get.defaultDialog(
      title: tr(LocaleKeys.doctor_details_dialogs_delete_title),
      titleStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      middleText: tr(
        LocaleKeys.doctor_details_dialogs_delete_msg,
        args: [isAr ? doctor.nameAr : doctor.nameEn],
      ),
      contentPadding: EdgeInsets.all(20.w),
      textConfirm: tr(LocaleKeys.doctor_details_dialogs_confirm),
      textCancel: tr(LocaleKeys.doctor_details_dialogs_cancel),
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      cancelTextColor: Colors.black,
      onConfirm: () => controller.deleteDoctor(doctor.id!),
      radius: 16.r,
    );
  }
}
