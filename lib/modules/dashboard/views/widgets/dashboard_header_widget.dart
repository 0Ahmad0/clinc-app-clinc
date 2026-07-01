import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/core/widgets/app_padding_widget.dart';
import '../../../../app/routes/app_routes.dart';
import '../../models/dashboard_model.dart';

class DashboardHeaderWidget extends StatelessWidget {
  const DashboardHeaderWidget({super.key, required this.clinic});

  final DashboardClinic clinic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final statusColor = clinic.isOpen ? Colors.green : colors.error;
    final hasHours = clinic.opensAt != null && clinic.closesAt != null;

    return AppPaddingWidget(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.settings),
            child: CircleAvatar(
              radius: 28.r,
              backgroundColor: colors.primary,
              child: Text(
                clinic.name.characters.first,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clinic.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                5.verticalSpace,
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8.w,
                  children: [
                    Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      tr(
                        clinic.isOpen
                            ? 'dashboard.clinic.open'
                            : 'dashboard.clinic.closed',
                      ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (hasHours)
                      Text(
                        '${clinic.opensAt} - ${clinic.closesAt}',
                        style: theme.textTheme.bodySmall,
                      ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.notifications),
            icon: Icon(Icons.notifications_none_rounded, color: colors.primary),
          ),
        ],
      ),
    );
  }
}
