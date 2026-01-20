import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/services_controller.dart';
import 'widgets/service_card_widget.dart';
import 'widgets/specialty_card_widget.dart';

class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface, // Background color from theme
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                tr(LocaleKeys.services_module_title),
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              pinned: true,
              floating: true,
              backgroundColor: colorScheme.surface,
              elevation: 0,
              leading: const BackButton(),
              bottom: TabBar(
                controller: controller.tabController,
                labelColor: colorScheme.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: colorScheme.primary,
                indicatorWeight: 3,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                tabs: [
                  Tab(text: tr(LocaleKeys.services_module_tabs_services)),
                  Tab(text: tr(LocaleKeys.services_module_tabs_specialties)),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: controller.tabController,
          children: [
            // Tab 1: Services List
            _buildServicesList(context),
            // Tab 2: Specialties List
            _buildSpecialtiesList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesList(BuildContext context) {
    return Stack(
      children: [
        Obx(() => ListView.separated(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 80.h),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.services.length,
          separatorBuilder: (_, __) => 16.verticalSpace,
          itemBuilder: (context, index) {
            return ServiceCardWidget(service: controller.services[index]);
          },
        )),
        _buildFab(context, tr(LocaleKeys.services_module_buttons_add_service), controller.goToAddService),
      ],
    );
  }

  Widget _buildSpecialtiesList(BuildContext context) {
    return Stack(
      children: [
        Obx(() => ListView.separated(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 80.h),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.specialties.length,
          separatorBuilder: (_, __) => 16.verticalSpace,
          itemBuilder: (context, index) {
            return SpecialtyCardWidget(specialty: controller.specialties[index]);
          },
        )),
        _buildFab(context, tr(LocaleKeys.services_module_buttons_add_specialty), controller.goToAddSpecialty),
      ],
    );
  }

  Widget _buildFab(BuildContext context, String label, VoidCallback onTap) {
    return Positioned(
      bottom: 20.h,
      right: 20.w,
      left: 20.w, // لجعل الزر عريضاً
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 4,
        ),
      ),
    );
  }
}