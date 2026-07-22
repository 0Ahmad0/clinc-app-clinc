import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../cubit/doctors_cubit.dart';
import '../widgets/add_doctor_button.dart';
import '../widgets/doctors_filter_chips.dart';
import '../widgets/doctors_header.dart';
import '../widgets/doctors_list.dart';
import '../widgets/doctors_search_field.dart';

class DoctorsView extends StatelessWidget {
  const DoctorsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.bg,
    body: Stack(
      children: [
        CustomScrollView(
          controller: context.read<DoctorsCubit>().scrollController,
          slivers: [
            // Floating header: hides as you read down the list and snaps back
            // the moment you scroll up.
            SliverAppBar(
              primary: false,
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              toolbarHeight:
                  MediaQuery.paddingOf(context).top +
                  AppSizes.doctorsHeaderContent +
                  AppSizes.doctorsHeaderContent,
              flexibleSpace: const DoctorsHeader(),
            ),
            const SliverToBoxAdapter(child: DoctorsSearchField()),
            const SliverToBoxAdapter(child: DoctorsFilterChips()),
            const DoctorsList(),
          ],
        ),
        const PositionedDirectional(
          start: AppSpacing.screen,
          bottom: AppSizes.doctorsFabBottom,
          child: AddDoctorButton(),
        ),
        const Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: AppBottomNavigation(activeRoute: AppRoutes.doctors),
        ),
      ],
    ),
  );
}
