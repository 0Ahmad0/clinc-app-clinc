import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../auth/domain/account_type.dart';
import '../cubit/reports_cubit.dart';
import 'reports_view.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key, this.accountType = AccountType.both});

  // ponytail: defaults to `both` (all report types) until a signed-in session
  // store exposes the real account type — then route it in here.
  final AccountType accountType;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<ReportsCubit>(param1: accountType),
    child: const ReportsView(),
  );
}
