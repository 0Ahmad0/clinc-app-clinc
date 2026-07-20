import 'package:equatable/equatable.dart';

import '../../domain/report_period.dart';
import '../../domain/report_type.dart';

class ReportsState extends Equatable {
  const ReportsState({this.period = ReportPeriod.week, required this.type});

  final ReportPeriod period;
  final ReportType type;

  ReportsState copyWith({ReportPeriod? period, ReportType? type}) =>
      ReportsState(period: period ?? this.period, type: type ?? this.type);

  @override
  List<Object> get props => [period, type];
}
