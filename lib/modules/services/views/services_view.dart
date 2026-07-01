import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/services_controller.dart';
import '../models/clinic_service_model.dart';

class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('services_page.title'),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          if (controller.allowedTabs.length > 1)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 10.h),
              child: Obx(
                () => SegmentedButton<ClinicServiceTab>(
                  segments: controller.allowedTabs
                      .map(
                        (tab) => ButtonSegment(
                          value: tab,
                          icon: Icon(
                            tab == ClinicServiceTab.lab
                                ? Icons.biotech_outlined
                                : Icons.medical_services_outlined,
                          ),
                          label: Text(_tabLabel(tab)),
                        ),
                      )
                      .toList(),
                  selected: {controller.selectedTab.value},
                  onSelectionChanged: (selection) =>
                      controller.selectTab(selection.first),
                ),
              ),
            ),
          Expanded(
            child: Obx(() {
              final tab = controller.selectedTab.value;
              final sections = controller.sectionsFor(tab);
              final loadingMore = controller.isLoadingMore.value;
              return controller.buildSections(
                tab,
                RefreshIndicator(
                  onRefresh: controller.onRefresh,
                  child: ListView.builder(
                    controller: controller.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 90.h),
                    itemCount: sections.length + (loadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == sections.length) {
                        return Padding(
                          padding: EdgeInsets.all(20.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return _ServiceSectionCard(
                        section: sections[index],
                        tab: tab,
                        onOpen: () =>
                            _openSection(context, tab, sections[index]),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _tabLabel(ClinicServiceTab tab) {
    return tr(
      tab == ClinicServiceTab.lab
          ? 'services_page.tabs.labs'
          : 'services_page.tabs.specialties',
    );
  }

  Future<void> _openSection(
    BuildContext context,
    ClinicServiceTab tab,
    ClinicServiceSection section,
  ) async {
    if (!section.isAdded) {
      await controller.addSection(section);
      return;
    }
    if (tab == ClinicServiceTab.lab) {
      await _showTestsSheet(context, section.id);
    }
  }

  Future<void> _showTestsSheet(BuildContext context, String sectionId) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: FractionallySizedBox(
          heightFactor: .78,
          child: Obx(() {
            final section = controller.labSections.firstWhere(
              (item) => item.id == sectionId,
            );
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    context.locale.languageCode == 'ar'
                        ? section.nameAr
                        : section.nameEn,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                    itemCount: section.tests.length,
                    separatorBuilder: (_, _) => 8.verticalSpace,
                    itemBuilder: (context, index) {
                      final test = section.tests[index];
                      final isLoading = controller.loadingTestIds.contains(
                        test.id,
                      );
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.science_outlined),
                          title: Text(test.name),
                          subtitle: Text(
                            test.isEnabled
                                ? '${test.price} ${tr('services_page.currency')}'
                                : tr('services_page.messages.not_enabled'),
                          ),
                          onTap: test.isEnabled && !isLoading
                              ? () => _requestPrice(context, section, test)
                              : null,
                          trailing: isLoading
                              ? SizedBox(
                                  width: 22.r,
                                  height: 22.r,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Switch.adaptive(
                                  value: test.isEnabled,
                                  onChanged: (enabled) async {
                                    if (enabled) {
                                      await _requestPrice(
                                        context,
                                        section,
                                        test,
                                      );
                                    } else {
                                      await controller.updateLabTest(
                                        section: section,
                                        test: test,
                                        isEnabled: false,
                                        price: 0,
                                      );
                                    }
                                  },
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<void> _requestPrice(
    BuildContext context,
    ClinicServiceSection section,
    LabTestOption test,
  ) async {
    final priceController = TextEditingController(
      text: test.price > 0 ? test.price.toString() : '',
    );
    final price = await showDialog<num>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr('services_page.price_dialog.title')),
        content: TextField(
          controller: priceController,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: tr('services_page.price_dialog.label'),
            suffixText: tr('services_page.currency'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr('services_page.cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(
              context,
              num.tryParse(priceController.text.trim()),
            ),
            child: Text(tr('services_page.save')),
          ),
        ],
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 300));
    priceController.dispose();
    if (price == null) return;
    await controller.updateLabTest(
      section: section,
      test: test,
      isEnabled: true,
      price: price,
    );
  }
}

class _ServiceSectionCard extends GetView<ServicesController> {
  const _ServiceSectionCard({
    required this.section,
    required this.tab,
    required this.onOpen,
  });

  final ClinicServiceSection section;
  final ClinicServiceTab tab;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = context.locale.languageCode == 'ar';
    final name = isArabic ? section.nameAr : section.nameEn;
    final canAdd = tab == ClinicServiceTab.lab || section.hasDoctor;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                child: Icon(
                  tab == ClinicServiceTab.lab
                      ? Icons.biotech_outlined
                      : Icons.medical_services_outlined,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      _subtitle(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: section.hasDoctor
                            ? theme.colorScheme.onSurfaceVariant
                            : theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                final loading = controller.loadingSectionIds.contains(
                  section.id,
                );
                if (loading) {
                  return SizedBox(
                    width: 24.r,
                    height: 24.r,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  );
                }
                if (section.isAdded) {
                  return IconButton(
                    onPressed: onOpen,
                    icon: Icon(
                      tab == ClinicServiceTab.lab
                          ? Icons.arrow_forward_ios
                          : Icons.check_circle,
                      color: theme.colorScheme.primary,
                    ),
                  );
                }
                return FilledButton.tonal(
                  onPressed: canAdd ? onOpen : null,
                  child: Text(tr('services_page.add')),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle() {
    if (tab == ClinicServiceTab.medical && !section.hasDoctor) {
      return tr('services_page.messages.doctor_required');
    }
    if (!section.isAdded) return tr('services_page.messages.not_added');
    if (tab == ClinicServiceTab.lab) {
      return tr(
        'services_page.messages.enabled_tests',
        args: [section.enabledTestsCount.toString()],
      );
    }
    return tr('services_page.messages.specialty_added');
  }
}
