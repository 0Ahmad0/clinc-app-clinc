import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/account_type.dart';
import '../../domain/report_period.dart';
import '../../domain/report_type.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this.accountType)
    : availableTypes = reportTypesFor(accountType),
      super(ReportsState(type: reportTypesFor(accountType).first));

  final AccountType accountType;

  /// Report types this facility may view — role-scoped, computed once.
  final List<ReportType> availableTypes;

  void selectPeriod(ReportPeriod period) => emit(state.copyWith(period: period));

  void selectType(ReportType type) => emit(state.copyWith(type: type));
}
