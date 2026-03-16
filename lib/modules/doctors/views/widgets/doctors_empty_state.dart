import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsEmptyState extends StatelessWidget {
  const DoctorsEmptyState({super.key});

  static const _color = Color(0xFF3949AB);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SearchIcon(),
          20.verticalSpace,
          Text(
            'لا يوجد أطباء',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          10.verticalSpace,
          Text(
            'حاول تغيير كلمة البحث أو الفلتر',
            style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}

class _SearchIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.r, height: 90.r,
      decoration: const BoxDecoration(
        color: Color(0x1A3949AB),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_search_rounded,
        size: 44.sp,
        color: const Color(0xFF3949AB).withValues(alpha: 0.5),
      ),
    );
  }
}
