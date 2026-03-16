import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/services_controller.dart';
import 'widgets/services_header.dart';
import 'widgets/services_labs_grid.dart';
import 'widgets/services_specialties_grid.dart';
import 'widgets/services_tab_bar.dart';

/// Root shell — pure layout, zero logic.
class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          const SliverToBoxAdapter(child: ServicesHeader()),
        ],
        body: Column(
          children: [
            const ServicesTabBar(),
            Expanded(
              child: Obx(() => IndexedStack(
                index: controller.currentTab.value,
                children: const [
                  ServicesLabsGrid(),
                  ServicesSpecialtiesGrid(),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
