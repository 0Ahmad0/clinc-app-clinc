import 'package:clinc_app_clinc/app/core/widgets/app_padding_widget.dart';
import 'package:clinc_app_clinc/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final String clinicName;
  const DashboardHeaderWidget({super.key, required this.clinicName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AppPaddingWidget(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: GestureDetector(
        onTap: ()=> Get.toNamed(AppRoutes.settings),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: cs.primary,
              child: Text(
                clinicName.characters.first,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Text(
                clinicName,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
            ),
            IconButton(
              onPressed: ()=> Get.toNamed(AppRoutes.notifications),
              icon: Icon(Icons.notifications_none_rounded, color: cs.primary),
            ),
          ],
        ),
      ),
    );
  }
}