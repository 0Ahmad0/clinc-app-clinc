import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/widgets/app_form_section_label.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/complete_profile_controller.dart';
import 'cp_schedule_day_row.dart';

class CPScheduleCard extends GetView<CompleteProfileController> {
  const CPScheduleCard({super.key});

  static const _purple = Color(0xFF673AB7);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFormSectionLabel(
            label: tr(LocaleKeys.complete_profile_sections_schedule),
            icon: Icons.schedule_rounded,
            color: _purple,
          ),
          16.verticalSpace,
          Obx(() => Column(
            children: List.generate(controller.weekSchedule.length, (i) {
              final day = controller.weekSchedule[i];
              return CPScheduleDayRow(
                day: day,
                accentColor: _purple,
                onToggle: (val) => controller.toggleDayOff(i, !val),
                onStartTimeTap: () => controller.pickTime(context, i, true),
                onEndTimeTap: () => controller.pickTime(context, i, false),
                showDivider: i != controller.weekSchedule.length - 1,
              );
            }),
          )),
        ],
      ),
    );
  }
}
