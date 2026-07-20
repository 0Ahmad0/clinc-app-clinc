import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../widgets/add_doctor_basic_section.dart';
import '../widgets/add_doctor_header.dart';
import '../widgets/add_doctor_professional_section.dart';
import '../widgets/add_doctor_qualifications_section.dart';
import '../widgets/add_doctor_save_bar.dart';
import '../widgets/add_doctor_schedule_section.dart';

class AddDoctorView extends StatelessWidget {
  const AddDoctorView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.bg,
    body: Stack(
      children: [
        ListView(
          padding: const EdgeInsetsDirectional.only(
            bottom: AppSizes.homeBottomClearance,
          ),
          children: const [
            AddDoctorHeader(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                AppSpacing.screen,
                AppSpacing.md + 2,
                AppSpacing.screen,
                0,
              ),
              child: Column(
                children: [
                  AddDoctorBasicSection(),
                  AppGaps.h16,
                  AddDoctorProfessionalSection(),
                  AppGaps.h16,
                  AddDoctorQualificationsSection(),
                  AppGaps.h16,
                  AddDoctorScheduleSection(),
                ],
              ),
            ),
          ],
        ),
        const PositionedDirectional(
          start: 0,
          end: 0,
          bottom: 0,
          child: AddDoctorSaveBar(),
        ),
      ],
    ),
  );
}
