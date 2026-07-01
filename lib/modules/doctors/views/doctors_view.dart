import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../generated/locale_keys.g.dart';
import '../controllers/doctors_controller.dart';
import 'widgets/doctor_card.dart';

class DoctorsView extends GetView<DoctorsController> {
  const DoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'doctors_add_fab',
        onPressed: controller.goToAddDoctor,
        icon: const Icon(Icons.add),
        label: Text(tr(LocaleKeys.doctors_page_add_button)),
      ),
      body: RefreshIndicator(
        onRefresh: controller.loadDoctors,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              expandedHeight: 110.h,
              floating: true,
              pinned: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                title: Text(
                  tr(LocaleKeys.doctors_page_title),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 10.h),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: controller.runSearch,
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.doctors_page_search_hint),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.searchController.clear();
                        controller.runSearch('');
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 46.h,
                child: Obx(
                  () => ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: 8.w),
                        child: ChoiceChip(
                          label: Text(tr('doctors_page.filters.all')),
                          selected:
                              controller.selectedSpecializationId.value == null,
                          onSelected: (_) =>
                              controller.selectSpecialization(null),
                        ),
                      ),
                      ...controller.specializations.map(
                        (specialization) => Padding(
                          padding: EdgeInsetsDirectional.only(end: 8.w),
                          child: ChoiceChip(
                            label: Text(
                              context.locale.languageCode == 'ar'
                                  ? specialization.nameAr
                                  : specialization.nameEn,
                            ),
                            selected:
                                controller.selectedSpecializationId.value ==
                                specialization.id,
                            onSelected: (_) => controller.selectSpecialization(
                              specialization.id,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value && controller.doctors.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (controller.errorMessage.value.isNotEmpty &&
                  controller.doctors.isEmpty) {
                return SliverFillRemaining(
                  child: _DoctorsError(
                    message: controller.errorMessage.value,
                    onRetry: controller.loadDoctors,
                  ),
                );
              }
              if (controller.doctors.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_search_outlined,
                            size: 72.sp,
                            color: theme.colorScheme.outline,
                          ),
                          16.verticalSpace,
                          Text(
                            tr(LocaleKeys.doctors_page_no_doctors),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
                sliver: SliverList.builder(
                  itemCount: controller.doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = controller.doctors[index];
                    return DoctorCard(
                      doctor: doctor,
                      onTap: () => controller.goToDoctorDetails(doctor),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _DoctorsError extends StatelessWidget {
  const _DoctorsError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            12.verticalSpace,
            Text(message, textAlign: TextAlign.center),
            12.verticalSpace,
            FilledButton(
              onPressed: onRetry,
              child: Text(tr('doctors_page.retry')),
            ),
          ],
        ),
      ),
    );
  }
}
