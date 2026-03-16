import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/appointments_controller.dart';
import 'widgets/appointment_card_widget.dart';
import 'widgets/appointments_empty_state.dart';
import 'widgets/appointments_filter_tabs.dart';
import 'widgets/appointments_header.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          const SliverToBoxAdapter(child: AppointmentsHeader()),
          const SliverPersistentHeader(
            pinned: true,
            delegate: AppointmentTabBarDelegate(),
          ),
        ],
        body: Obx(() {
          final list = controller.filtered;
          if (list.isEmpty) {
            return AppointmentsEmptyState(filter: controller.filter.value);
          }
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (_, __) => 14.verticalSpace,
            itemBuilder: (_, i) => AppointmentCardWidget(item: list[i]),
          );
        }),
      ),
    );
  }
}
