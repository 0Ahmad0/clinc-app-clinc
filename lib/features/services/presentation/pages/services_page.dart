import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../auth/domain/account_type.dart';
import '../cubit/services_cubit.dart';
import 'services_view.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key, this.accountType = AccountType.both});

  // ponytail: defaults to `both` (all tabs) until a signed-in session store
  // exposes the real account type — then route it in here.
  final AccountType accountType;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<ServicesCubit>(param1: accountType),
    child: const ServicesView(),
  );
}
