import 'package:clinc_app_clinc/app/data/report_model.dart';
import 'package:clinc_app_clinc/modules/reports/data/reports_mock_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reports mock supports yearly generation download and share', () async {
    final dataSource = ReportsMockDataSource();

    final generated = await dataSource.generateReport(
      type: ReportType.clinic,
      range: ReportRange.year,
      format: ReportFormat.pdf,
    );

    expect(generated.status, 'success');
    expect(generated.result?.range, ReportRange.year);
    expect(generated.result?.fileUrl, startsWith('mock://reports/'));

    final report = generated.result!;
    final download = await dataSource.downloadReport(report);
    expect(download.status, 'success');
    expect(download.result?['local_path'], contains(report.id));

    final share = await dataSource.shareReport(report);
    expect(share.status, 'success');
    expect(share.result?['share_url'], 'mock://share/reports/${report.id}');
  });
}
