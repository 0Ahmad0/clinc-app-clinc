import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/widgets/app_svg_widget.dart';

class PendingIllustrationWidget extends StatelessWidget {
  const PendingIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.r),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: AppSvgWidget(
        path: 'assets/icons/processing.svg', // صورة ساعة أو ملف قيد المراجعة
        height: 150.h,
        width: 150.w,
      ),
    );
  }
}