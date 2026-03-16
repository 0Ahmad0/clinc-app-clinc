import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/services_controller.dart';
import 'service_mini_stat.dart';

const _kGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF1E1B4B), Color(0xFF1E3A8A), Color(0xFF2563EB)],
);

/// Gradient header: icon + title + active count + stats pills.
class ServicesHeader extends GetView<ServicesController> {
  const ServicesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(gradient: _kGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          child: Obx(() {
            final activeLabs  = controller.activeLabCategories.length;
            final activeSpecs = controller.activeSpecialties.length;
            final totalLabs   = controller.availableLabCategories.length;
            final totalSpecs  = controller.availableSpecialties.length;
            return Row(
              children: [
                _HeaderIcon(),
                14.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إدارة الخدمات',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        '${activeLabs + activeSpecs} خدمة نشطة',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    ServiceMiniStat(count: totalLabs,  label: 'تحاليل'),
                    8.horizontalSpace,
                    ServiceMiniStat(count: totalSpecs, label: 'تخصصات'),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// ── Private ───────────────────────────────────────────────────────────────────

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(Icons.medical_services_rounded, color: Colors.white, size: 26.sp),
    );
  }
}
