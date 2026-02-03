import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/data/doctor_model.dart';
import '../controllers/doctors_controller.dart';

class DoctorDetailsView extends GetView<DoctorsController> {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final doctor = Get.arguments as DoctorModel;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Sliver App Bar مع صورة الطبيب
          SliverAppBar(
            expandedHeight: 300.h,
            pinned: true,
            backgroundColor: cs.surface,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: cs.onSurface),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit_outlined, color: cs.primary),
                tooltip: "تعديل",
                onPressed: () {
                  // Get.toNamed(AppRoutes.editDoctor, arguments: doctor);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: cs.error),
                tooltip: "حذف",
                onPressed: () {
                  _showDeleteDialog(context, doctor);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'doctor_${doctor.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // صورة الخلفية
                    Image.network(
                      // doctor.image ?? 'assets/images/doctor_placeholder.png',
                      'https://th.bing.com/th/id/R.b379902c62bb9c7333c2bbf704d8104c?rik=EALI63%2bLUEhkeA&riu=http%3a%2f%2fwww.texila.us%2fblog%2fwp-content%2fuploads%2f2015%2f09%2fDoctor-Background.jpg&ehk=xT7BPf004Jh0P1KDbK%2f2xsvItxYhv%2bFqwSrNT6Qamvg%3d&risl=&pid=ImgRaw&r=0',

                      fit: BoxFit.cover,
                    ),
                    // تدرج شفاف
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            cs.surface.withOpacity(0.8),
                            cs.surface,
                          ],
                        ),
                      ),
                    ),
                    // معلومات الطبيب في الأسفل
                    Positioned(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                doctor.name,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: cs.onSurface,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: doctor.isActive
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8.r,
                                      height: 8.r,
                                      decoration: BoxDecoration(
                                        color: doctor.isActive
                                            ? Colors.green
                                            : Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    6.horizontalSpace,
                                    Text(
                                      doctor.isActive ? 'نشط' : 'غير نشط',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: doctor.isActive
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          4.verticalSpace,
                          Text(
                            doctor.specialty,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: cs.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            doctor.hospital,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. معلومات الطبيب التفصيلية
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // بطاقة المعلومات الأساسية
                _InfoCard(
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.verified_user_outlined,
                        label: "رقم الترخيص",
                        value: doctor.license,
                      ),
                      12.verticalSpace,
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        label: "رقم الهاتف",
                        value: doctor.phone,
                        isPhone: true,
                      ),
                      12.verticalSpace,
                      _InfoRow(
                        icon: Icons.email_outlined,
                        label: "البريد الإلكتروني",
                        value: doctor.email,
                        isEmail: true,
                      ),
                      12.verticalSpace,
                      _InfoRow(
                        icon: Icons.workspace_premium_outlined,
                        label: "سنوات الخبرة",
                        value: "${doctor.experience} سنوات",
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,

                // بطاقة المؤهلات العلمية
                if (doctor.qualifications != null &&
                    doctor.qualifications!.isNotEmpty) ...[
                  _InfoCard(
                    title: "المؤهلات العلمية",
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: doctor.qualifications!
                          .map((qualification) => Chip(
                        label: Text(qualification),
                        backgroundColor: cs.primary.withOpacity(0.1),
                        labelStyle: theme.textTheme.bodySmall?.copyWith(
                          color: cs.primary,
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                  20.verticalSpace,
                ],

                // بطاقة أيام العمل
                if (doctor.workingDays != null &&
                    doctor.workingDays!.isNotEmpty) ...[
                  _InfoCard(
                    title: "أيام العمل",
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.calendar_today_outlined,
                          label: "الأيام",
                          value: doctor.workingDays!.join("، "),
                        ),
                        if (doctor.workingHours != null) ...[
                          12.verticalSpace,
                          _InfoRow(
                            icon: Icons.access_time_outlined,
                            label: "ساعات العمل",
                            value: doctor.workingHours!,
                          ),
                        ],
                      ],
                    ),
                  ),
                  20.verticalSpace,
                ],

                // بطاقة نبذة عن الطبيب
                _InfoCard(
                  title: "نبذة عن الطبيب",
                  child: Text(
                    doctor.about,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                ),
                32.verticalSpace,

                // أزرار الإجراءات
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showDeleteDialog(context, doctor);
                        },
                        icon: Icon(Icons.delete_outline, color: cs.error),
                        label: Text(
                          "حذف",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: cs.error,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: cs.error),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Get.toNamed(AppRoutes.editDoctor, arguments: doctor);
                        },
                        icon: Icon(Icons.edit_outlined, color: cs.onPrimary),
                        label: Text(
                          "تعديل",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: cs.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.primary,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                24.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, DoctorModel doctor) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    Get.dialog(
      AlertDialog(
        title: Text(
          "تأكيد الحذف",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: cs.error,
          ),
        ),
        content: Text(
          "هل أنت متأكد أنك تريد حذف ${doctor.name}؟ لا يمكن التراجع عن هذا الإجراء.",
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "إلغاء",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteDoctor(doctor.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: cs.error,
            ),
            child: Text(
              "حذف",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String? title;
  final Widget child;

  const _InfoCard({
    this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.primary,
              ),
            ),
            12.verticalSpace,
          ],
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isPhone;
  final bool isEmail;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isPhone = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: cs.primary, size: 20.sp),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              4.verticalSpace,
              if (isPhone)
                InkWell(
                  onTap: () {
                  },
                  child: Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              else if (isEmail)
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              else
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}