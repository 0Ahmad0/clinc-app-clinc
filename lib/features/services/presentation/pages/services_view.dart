import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../cubit/services_cubit.dart';
import '../cubit/services_state.dart';
import '../services_catalog.dart';
import '../widgets/services_catalog_grid.dart';
import '../widgets/services_detail_list.dart';
import '../widgets/services_header.dart';
import '../widgets/services_tab_switcher.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = localizedLabTests(context.l10n);
    final labTotal = catalog.values.fold<int>(
      0,
      (sum, list) => sum + list.length,
    );
    final cubit = context.read<ServicesCubit>();

    return Scaffold(
      backgroundColor: context.colors.bg,
      body: BlocBuilder<ServicesCubit, ServicesState>(
        builder: (context, state) {
          final detail = state.detail;
          return Stack(
            children: [
              Column(
                children: [
                  ServicesHeader(
                    detail: detail,
                    detailCount: detail == null ? 0 : catalog[detail]!.length,
                    labTotal: labTotal,
                    specTotal: kClinicSpecialties.length,
                    activeCount: state.activeCount,
                    onBack: cubit.closeDetail,
                  ),
                  Expanded(
                    child: detail != null
                        ? ServicesDetailList(
                            section: detail,
                            tests: catalog[detail]!,
                          )
                        : const SingleChildScrollView(
                            child: Column(
                              children: [
                                ServicesTabSwitcher(),
                                ServicesCatalogGrid(),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
              if (detail == null)
                const Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: AppBottomNavigation(activeRoute: AppRoutes.services),
                ),
            ],
          );
        },
      ),
    );
  }
}
