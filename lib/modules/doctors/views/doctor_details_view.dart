import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    // استقبل بيانات الدكتور من arguments (أو من كنترولر)
    final Map<String, dynamic> doctor = Get.arguments ?? {
      'id': 1,
      'name': 'Dr. Ethan Carter',
      'specialty': 'Cardiology',
      'hospital': 'Radiant Hospital',
      'image': 'assets/images/doctor_placeholder.png',
      'isActive': true,
      'license': 'MOH-123456',
      'phone': '+963999000111',
      'email': 'ethan.carter@radiant.com',
      'experience': 10,
      'about': 'خبرة 10 سنوات في أمراض القلب، عضو الجمعية الطبية العالمية. متابع لأحدث الأبحاث الطبية في مجال القلب والأوعية الدموية.',
    };

    final isActive = doctor['isActive'] as bool;

    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        backgroundColor: cs.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onBackground),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: cs.primary),
            tooltip: "تعديل",
            onPressed: () {
              // Get.toNamed('/edit_doctor', arguments: doctor['id']);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: cs.error),
            tooltip: "حذف",
            onPressed: () {
              _showDeleteDialog(context, doctor['name']);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // صورة الدكتور + حالة
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Hero(
                  tag: 'doctor_${doctor['id']}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Image.asset(
                      doctor['image'],
                      width: 120.r,
                      height: 120.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    width: 18.r,
                    height: 18.r,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: cs.background, width: 3),
                    ),
                  ),
                ),
              ],
            ),
            18.verticalSpace,

            // اسم الدكتور والتخصص والمستشفى
            Text(
              doctor['name'],
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            8.verticalSpace,
            Text(
              doctor['specialty'],
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            4.verticalSpace,
            Text(
              doctor['hospital'],
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            16.verticalSpace,

            // معلومات إضافية (license, phone, email, experience)
            _InfoRow(
              icon: Icons.verified_user_outlined,
              label: "رقم الترخيص",
              value: doctor['license'],
            ),
            8.verticalSpace,
            _InfoRow(
              icon: Icons.phone_outlined,
              label: "رقم الهاتف",
              value: doctor['phone'],
            ),
            8.verticalSpace,
            _InfoRow(
              icon: Icons.email_outlined,
              label: "البريد الإلكتروني",
              value: doctor['email'],
            ),
            8.verticalSpace,
            _InfoRow(
              icon: Icons.workspace_premium_outlined,
              label: "سنوات الخبرة",
              value: "${doctor['experience']} سنوات",
            ),
            20.verticalSpace,

            // نبذة عن الطبيب
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "نبذة عن الطبيب",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: cs.primary,
                ),
              ),
            ),
            8.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Text(
                doctor['about'],
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
            ),
            32.verticalSpace,
            // أزرار التعديل والحذف (للموبايل UX)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showDeleteDialog(context, doctor['name']);
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text("حذف"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.error,
                      side: BorderSide(color: cs.error),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Get.toNamed('/edit_doctor', arguments: doctor['id']);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("تعديل"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String doctorName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("تأكيد الحذف"),
        content: Text("هل أنت متأكد أنك تريد حذف $doctorName؟ لا يمكن التراجع."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // TODO: حذف الدكتور من القائمة/الكنترولر
              Get.back();
              Get.snackbar("تم الحذف", "تم حذف الطبيب بنجاح");
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("حذف"),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, color: cs.primary, size: 20.sp),
        10.horizontalSpace,
        Text(
          "$label: ",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: cs.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}