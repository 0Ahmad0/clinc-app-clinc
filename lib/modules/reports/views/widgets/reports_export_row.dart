import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/reports_controller.dart';

class ReportsExportRow extends GetView<ReportsController> {
  const ReportsExportRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Row(
          children: [
            Expanded(
              child: Obx(() {
                final loading = controller.isLoading.value;
                return _ExportButton(
                  label: 'تصدير PDF',
                  icon: Icons.picture_as_pdf_rounded,
                  gradientColors: const [Color(0xFF004D40), Color(0xFF009688)],
                  shadowColor: const Color(0xFF009688),
                  isLoading: loading,
                  onTap: loading ? null : controller.generatePdfReport,
                );
              }),
            ),
            12.horizontalSpace,
            Expanded(
              child: Obx(() {
                final loading = controller.isCsvLoading.value;
                return _ExportButton(
                  label: 'تصدير CSV',
                  icon: Icons.table_chart_rounded,
                  gradientColors: const [Color(0xFF1A237E), Color(0xFF3949AB)],
                  shadowColor: const Color(0xFF3949AB),
                  isLoading: loading,
                  onTap: loading ? null : controller.exportCsvReport,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> gradientColors;
  final Color shadowColor;
  final bool isLoading;
  final VoidCallback? onTap;

  const _ExportButton({
    required this.label,
    required this.icon,
    required this.gradientColors,
    required this.shadowColor,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 16.r,
                    height: 16.r,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                else
                  Icon(icon, color: Colors.white, size: 18.sp),
                8.horizontalSpace,
                Text(
                  isLoading ? 'جاري...' : label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
