import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/colors/status_colors.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../controllers/appointment_details_controller.dart';
import 'widgets/appointment_actions_card.dart';
import 'widgets/appointment_hero_header.dart';
import 'widgets/appointment_info_card.dart';
import 'widgets/appointment_lab_result_card.dart';
import 'widgets/appointment_patient_card.dart';
import 'widgets/appointment_rejection_card.dart';

class AppointmentDetailsView extends GetView<AppointmentDetailsController> {
  const AppointmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(() {
        final a           = controller.appointment.value;
        final statusColor = AppStatusColors.forStatus(a.status);

        return CustomScrollView(
           
          slivers: [
            AppointmentHeroHeader(appointment: a, statusColor: statusColor),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  AppointmentPatientCard(appointment: a),
                  16.verticalSpace,
                  AppointmentInfoCard(appointment: a),
                  16.verticalSpace,
                  if (a.status == AppointmentStatus.rejected) ...[
                    AppointmentRejectionCard(appointment: a),
                    16.verticalSpace,
                  ],
                  if (a.type == AppointmentType.labTest) ...[
                    AppointmentLabResultCard(appointment: a),
                    16.verticalSpace,
                  ],
                  const AppointmentActionsCard(),
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }
}
