import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardSliverAppBar extends StatelessWidget {
  const DashboardSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverAppBar(
      pinned: true, // يبقى ظاهراً عند السكرول
      floating: true, // يظهر فوراً عند السكرول للأعلى
      backgroundColor: colorScheme.background,
      elevation: 0,
      // نستخدم leadingWidth لتوسيع المساحة
      leadingWidth: 0,
      title: Row(
        children: [
          // اللوغو
          CircleAvatar(
            radius: 20.r,
            backgroundColor: colorScheme.primary,
            child: Text(
              "C",
              style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp
              ),
            ),
          ),
          12.horizontalSpace,
          // الاسم
          Text(
            "ClinicName",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none_rounded, color: colorScheme.onSurface),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.grid_view_rounded, color: colorScheme.onSurface),
        ),
        10.horizontalSpace,
      ],
    );
  }
}