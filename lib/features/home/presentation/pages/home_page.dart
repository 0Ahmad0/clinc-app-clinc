import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../cubit/home_cubit.dart';
import 'home_view.dart';

/// Route entry point for the clinic dashboard.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<HomeCubit>()..loadDashboard(),
    child: const HomeView(),
  );
}
