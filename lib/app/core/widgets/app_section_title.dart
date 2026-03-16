import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable section-title row: teal accent bar + bold title + optional trailing link.
/// Wrap in SliverToBoxAdapter when used inside CustomScrollView.
class AppSectionTitle extends StatelessWidget {
  final String title;
  final String? trailingLabel;
  final VoidCallback? trailingAction;
  final EdgeInsets? padding;

  const AppSectionTitle({
    super.key,
    required this.title,
    this.trailingLabel,
    this.trailingAction,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = padding ?? EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h);

    return Padding(
      padding: p,
      child: Row(
        children: [
          const _TealAccentBar(),
          10.horizontalSpace,
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const Spacer(),
          if (trailingLabel != null)
            GestureDetector(
              onTap: trailingAction,
              child: Text(
                trailingLabel!,
                style: TextStyle(
                  color: const Color(0xFF009688),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TealAccentBar extends StatelessWidget {
  const _TealAccentBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.w,
      height: 18.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF009688), Color(0xFF004D40)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
