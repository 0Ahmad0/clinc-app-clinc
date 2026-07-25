import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_url.dart';
import '../../domain/report_breakdown.dart';
import '../../domain/report_period.dart';
import '../../domain/report_type.dart';

part 'clinic_report_model.freezed.dart';
part 'clinic_report_model.g.dart';

@freezed
abstract class ClinicReportSummaryModel with _$ClinicReportSummaryModel {
  const factory ClinicReportSummaryModel({
    String? period,
    String? type,
    ClinicReportTotalsModel? totals,
    @Default([]) List<ClinicReportChartModel> chart,
  }) = _ClinicReportSummaryModel;

  factory ClinicReportSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicReportSummaryModelFromJson(json);
}

@freezed
abstract class ClinicReportTotalsModel with _$ClinicReportTotalsModel {
  const factory ClinicReportTotalsModel({
    @Default(0) int completed,
    @Default(0) int pending,
    @Default(0) int rejected,
    @Default(0) num revenue,
    @Default(0) int doctors,
    @Default(0) int appointments,
  }) = _ClinicReportTotalsModel;

  factory ClinicReportTotalsModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicReportTotalsModelFromJson(json);
}

@freezed
abstract class ClinicReportChartModel with _$ClinicReportChartModel {
  const factory ClinicReportChartModel({
    String? label,
    @Default(0) int completed,
    @Default(0) int pending,
    @Default(0) int rejected,
    @Default(0) num revenue,
  }) = _ClinicReportChartModel;

  factory ClinicReportChartModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicReportChartModelFromJson(json);
}

@freezed
abstract class ClinicGeneratedReportModel with _$ClinicGeneratedReportModel {
  const factory ClinicGeneratedReportModel({
    @JsonKey(name: 'report_id') int? reportId,
    String? type,
    String? period,
    String? format,
    String? status,
    @JsonKey(name: 'file_url') String? fileUrl,
    @JsonKey(name: 'generated_at') String? generatedAt,
  }) = _ClinicGeneratedReportModel;

  factory ClinicGeneratedReportModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicGeneratedReportModelFromJson(json);
}

extension ClinicReportSummaryModelX on ClinicReportSummaryModel {
  ReportBreakdown get breakdown => totals?.breakdown ?? ReportBreakdown.zero;

  List<(String, ReportBreakdown)> get chartBars => chart
      .map((item) => (item.label ?? '-', item.breakdown))
      .toList(growable: false);
}

extension ClinicReportTotalsModelX on ClinicReportTotalsModel {
  ReportBreakdown get breakdown =>
      ReportBreakdown(done: completed, pending: pending, cancelled: rejected);
}

extension ClinicReportChartModelX on ClinicReportChartModel {
  ReportBreakdown get breakdown =>
      ReportBreakdown(done: completed, pending: pending, cancelled: rejected);
}

extension ClinicGeneratedReportModelX on ClinicGeneratedReportModel {
  ReportPeriod get periodValue => switch (period) {
    'month' => ReportPeriod.month,
    _ => ReportPeriod.week,
  };

  ReportType get typeValue => reportTypeFromBackend(type);

  String get formattedGeneratedAt {
    final raw = generatedAt?.trim();
    if (raw == null || raw.isEmpty) return '-';
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    final formatted = DateFormat('yyyy-MM-dd h:mm a').format(parsed);
    return formatted.replaceAll('AM', 'am').replaceAll('PM', 'pm');
  }

  Uri? get downloadableUri {
    final raw = fileUrl?.trim();
    if (raw == null || raw.isEmpty) return null;
    final uri = Uri.tryParse(raw);
    if (uri == null) return null;

    if (uri.host.toLowerCase() != 'localhost') return uri;

    final base = Uri.tryParse(baseServSlashLess);
    if (base == null) return uri;
    return uri.replace(
      scheme: base.scheme.isEmpty ? uri.scheme : base.scheme,
      host: base.host.isEmpty ? uri.host : base.host,
      port: base.hasPort ? base.port : uri.port,
    );
  }
}
