part of 'reports_cubit.dart';

@freezed
abstract class ReportsState with _$ReportsState {
  const factory ReportsState({
    @Default(ReportPeriod.week) ReportPeriod period,
    required ReportType type,
    ClinicReportSummaryModel? summary,
    ClinicGeneratedReportModel? exportedReport,
    NetworkExceptions? failure,
    @Default(false) bool isSummaryLoading,
    @Default(false) bool isExportingPdf,
    @Default(false) bool isExportingXlsx,
    required PaginationState<ClinicGeneratedReportModel> pagination,
  }) = _ReportsState;
}
