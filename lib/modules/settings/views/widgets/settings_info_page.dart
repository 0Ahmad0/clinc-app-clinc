import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsInfoPage extends StatelessWidget {
  const SettingsInfoPage({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          CircleAvatar(
            radius: 36.r,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Icon(icon, size: 34.sp),
          ),
          24.verticalSpace,
          ...children,
        ],
      ),
    );
  }
}
