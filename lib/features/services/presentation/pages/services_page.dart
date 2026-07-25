import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/services/storage_service.dart';
import '../../../auth/domain/account_type.dart';
import '../cubit/services_cubit.dart';
import 'services_view.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key, this.accountType});

  final AccountType? accountType;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        sl<ServicesCubit>(
            param1: accountType ?? _accountTypeFromCachedClinic(),
          )
          ..loadInitial(),
    child: const ServicesView(),
  );

  AccountType _accountTypeFromCachedClinic() {
    final rawType = StorageService.instance.getCachedClinic()?['type']
        ?.toString()
        .trim()
        .toLowerCase();
    return switch (rawType) {
      'clinic' => AccountType.clinic,
      'lab' => AccountType.lab,
      'both' => AccountType.both,
      _ => AccountType.both,
    };
  }
}
