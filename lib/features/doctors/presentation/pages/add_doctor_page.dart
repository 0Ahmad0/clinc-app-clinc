import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../cubit/add_doctor_cubit.dart';
import 'add_doctor_view.dart';

class AddDoctorPage extends StatelessWidget {
  const AddDoctorPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<AddDoctorCubit>(),
    child: const AddDoctorView(),
  );
}
