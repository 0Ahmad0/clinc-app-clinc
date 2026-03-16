import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/data/report_model.dart';
import '../../../../generated/locale_keys.g.dart';
import 'report_type_utils.dart';

class ReportDetailsHeroHeader extends StatelessWidget {
  final ReportModel report;
  const ReportDetailsHeroHeader({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final typeColor = report.type.typeColor(cs);

    return SliverAppBar(
      pinned: true,
      expandedHeight: 220.h,
      backgroundColor: typeColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      leading: IconButton(
        onPressed: Get.back,
        icon: Container(
          width: 34.r,
          height: 34.r,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 16),
        ),
      ),
      title: Text(
        tr(LocaleKeys.reports_details_title),
        style: theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Container(
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share_rounded, color: Colors.white, size: 16),
          ),
        ),
        12.horizontalSpace,
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Hero(
          tag: 'report_${report.id}',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [typeColor, typeColor.withValues(alpha: 0.75)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -30,
                  top: -20,
                  child: Container(
                    width: 130.r,
                    height: 130.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.07),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: -40,
                  bottom: -30,
                  child: Container(
                    width: 160.r,
                    height: 160.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        70.verticalSpace,
                        Container(
                          width: 64.r,
                          height: 64.r,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Icon(
                            report.type.typeIcon,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                        12.verticalSpace,
                        Text(
                          tr(report.type.key()),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        6.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Text(
                            '${report.total} ${tr(LocaleKeys.reports_cards_total)}',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
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
