// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicReportSummaryModel _$ClinicReportSummaryModelFromJson(
  Map<String, dynamic> json,
) => _ClinicReportSummaryModel(
  period: json['period'] as String?,
  type: json['type'] as String?,
  totals: json['totals'] == null
      ? null
      : ClinicReportTotalsModel.fromJson(
          json['totals'] as Map<String, dynamic>,
        ),
  chart:
      (json['chart'] as List<dynamic>?)
          ?.map(
            (e) => ClinicReportChartModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$ClinicReportSummaryModelToJson(
  _ClinicReportSummaryModel instance,
) => <String, dynamic>{
  'period': instance.period,
  'type': instance.type,
  'totals': instance.totals,
  'chart': instance.chart,
};

_ClinicReportTotalsModel _$ClinicReportTotalsModelFromJson(
  Map<String, dynamic> json,
) => _ClinicReportTotalsModel(
  completed: (json['completed'] as num?)?.toInt() ?? 0,
  pending: (json['pending'] as num?)?.toInt() ?? 0,
  rejected: (json['rejected'] as num?)?.toInt() ?? 0,
  revenue: json['revenue'] as num? ?? 0,
  doctors: (json['doctors'] as num?)?.toInt() ?? 0,
  appointments: (json['appointments'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ClinicReportTotalsModelToJson(
  _ClinicReportTotalsModel instance,
) => <String, dynamic>{
  'completed': instance.completed,
  'pending': instance.pending,
  'rejected': instance.rejected,
  'revenue': instance.revenue,
  'doctors': instance.doctors,
  'appointments': instance.appointments,
};

_ClinicReportChartModel _$ClinicReportChartModelFromJson(
  Map<String, dynamic> json,
) => _ClinicReportChartModel(
  label: json['label'] as String?,
  completed: (json['completed'] as num?)?.toInt() ?? 0,
  pending: (json['pending'] as num?)?.toInt() ?? 0,
  rejected: (json['rejected'] as num?)?.toInt() ?? 0,
  revenue: json['revenue'] as num? ?? 0,
);

Map<String, dynamic> _$ClinicReportChartModelToJson(
  _ClinicReportChartModel instance,
) => <String, dynamic>{
  'label': instance.label,
  'completed': instance.completed,
  'pending': instance.pending,
  'rejected': instance.rejected,
  'revenue': instance.revenue,
};

_ClinicGeneratedReportModel _$ClinicGeneratedReportModelFromJson(
  Map<String, dynamic> json,
) => _ClinicGeneratedReportModel(
  reportId: (json['report_id'] as num?)?.toInt(),
  type: json['type'] as String?,
  period: json['period'] as String?,
  format: json['format'] as String?,
  status: json['status'] as String?,
  fileUrl: json['file_url'] as String?,
  generatedAt: json['generated_at'] as String?,
);

Map<String, dynamic> _$ClinicGeneratedReportModelToJson(
  _ClinicGeneratedReportModel instance,
) => <String, dynamic>{
  'report_id': instance.reportId,
  'type': instance.type,
  'period': instance.period,
  'format': instance.format,
  'status': instance.status,
  'file_url': instance.fileUrl,
  'generated_at': instance.generatedAt,
};
