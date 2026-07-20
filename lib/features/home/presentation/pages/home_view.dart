import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../widgets/home_appointments_section.dart';
import '../widgets/home_stats_section.dart';
import '../widgets/home_top_section.dart';

/// Main dashboard layout matching the supplied 390 × 844 reference.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bg,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(
              bottom: AppSizes.homeBottomClearance,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeTopSection(),
                HomeStatsSection(),
                HomeAppointmentsSection(),
              ],
            ),
          ),
          const Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: AppBottomNavigation(activeRoute: AppRoutes.home),
          ),
        ],
      ),
    );
  }
}
