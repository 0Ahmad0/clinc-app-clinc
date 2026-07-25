import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../data/models/clinic_doctor_model.dart';
import '../cubit/add_doctor_cubit.dart';
import 'add_doctor_view.dart';

class AddDoctorPage extends StatelessWidget {
  const AddDoctorPage({super.key, this.initialDoctor});

  final ClinicDoctorModel? initialDoctor;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        sl<AddDoctorCubit>(param1: initialDoctor)..loadSpecializations(),
    child: const AddDoctorView(),
  );
}
