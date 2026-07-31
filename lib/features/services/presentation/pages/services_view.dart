import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../cubit/services_cubit.dart';
import '../widgets/services_catalog_grid.dart';
import '../widgets/services_detail_list.dart';
import '../widgets/services_header.dart';
import '../widgets/services_tab_switcher.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServicesCubit>();

    return Scaffold(
      backgroundColor: context.colors.bg,
      body: BlocListener<ServicesCubit, ServicesState>(
        listenWhen: (previous, current) => previous.failure != current.failure,
        listener: (context, state) {
          final failure = state.failure;
          if (failure == null) return;
          AppToast.show(
            context,
            title: context.l10n.toastFailure,
            message: NetworkExceptions.getErrorMessage(failure),
            type: AppFeedbackType.danger,
          );
        },
        child: BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            final detail = state.detail;
            return Stack(
              children: [
                Column(
                  children: [
                    ServicesHeader(
                      detail: detail,
                      detailCount:
                          state.availableLabTests.total ??
                          state.availableLabTests.items.length,
                      labTotal: state.visibleLabSections.length,
                      specTotal: state.activeSpecializations.length,
                      activeCount: state.activeCount,
                      kind: state.kind,
                      availableKinds: cubit.availableKinds,
                      onBack: cubit.closeDetail,
                    ),
                    Expanded(
                      child: detail != null
                          ? ServicesDetailList(section: detail)
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
      ),
    );
  }
}
