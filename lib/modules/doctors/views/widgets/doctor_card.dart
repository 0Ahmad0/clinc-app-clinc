import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/data/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onTap;
  final VoidCallback onToggleStatus;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Hero(
      tag: 'doctor_${doctor.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
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
            child: Row(
              children: [
                // صورة الطبيب
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        // doctor.image ??
                            'https://th.bing.com/th/id/R.b379902c62bb9c7333c2bbf704d8104c?rik=EALI63%2bLUEhkeA&riu=http%3a%2f%2fwww.texila.us%2fblog%2fwp-content%2fuploads%2f2015%2f09%2fDoctor-Background.jpg&ehk=xT7BPf004Jh0P1KDbK%2f2xsvItxYhv%2bFqwSrNT6Qamvg%3d&risl=&pid=ImgRaw&r=0',
                        width: 60.r,
                        height: 60.r,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        width: 12.r,
                        height: 12.r,
                        decoration: BoxDecoration(
                          color: doctor.isActive ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: cs.surface, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                16.horizontalSpace,

                // معلومات الطبيب
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      4.verticalSpace,
                      Text(
                        doctor.specialty,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      4.verticalSpace,
                      Text(
                        doctor.hospital,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                12.horizontalSpace,

                // زر تبديل الحالة
                IconButton(
                  onPressed: onToggleStatus,
                  icon: Icon(
                    doctor.isActive
                        ? Icons.toggle_on_outlined
                        : Icons.toggle_off_outlined,
                    color: doctor.isActive ? cs.primary : cs.outline,
                    size: 30.sp,
                  ),
                  tooltip: doctor.isActive ? "تعطيل" : "تفعيل",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}