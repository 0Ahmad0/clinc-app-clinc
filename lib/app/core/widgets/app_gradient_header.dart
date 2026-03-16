import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../design/app_gradients.dart';

class AppGradientHeader extends StatelessWidget {
  final LinearGradient gradient;
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final Widget? trailing;
  final Widget? leading;
  final Widget? badge;
  final double bottomRadius;
  final double iconSize;
  final double iconCircleSize;
  final double bottomPadding;

  const AppGradientHeader({
    super.key,
    this.gradient = AppGradients.teal,
    required this.icon,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    this.trailing,
    this.leading,
    this.badge,
    this.bottomRadius = 36,
    this.iconSize = 40,
    this.iconCircleSize = 80,
    this.bottomPadding = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bottomRadius.r),
          bottomRight: Radius.circular(bottomRadius.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Main content column
            Padding(
              padding: EdgeInsets.only(
                bottom: bottomPadding.h,
                top: (leading != null || trailing != null) ? 52.h : 0,
              ),
              child: Column(
                children: [
                  20.verticalSpace,
                  // Icon circle + optional badge overlay
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: iconCircleSize.r,
                        height: iconCircleSize.r,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: iconSize.r, color: Colors.white),
                      ),
                      if (badge != null)
                        Positioned(bottom: -2, right: -2, child: badge!),
                    ],
                  ),
                  16.verticalSpace,
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (subtitle != null) ...[
                    8.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Text(
                        subtitle!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.78),
                          fontSize: 13.sp,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                  if (subtitleWidget != null) ...[
                    8.verticalSpace,
                    subtitleWidget!,
                  ],
                ],
              ),
            ),
            // Leading (top-start)
            if (leading != null)
              Positioned(
                top: 8.h,
                left: 12.w,
                child: leading!,
              ),
            // Trailing (top-end)
            if (trailing != null)
              Positioned(
                top: 8.h,
                right: 12.w,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}

/// A standard white back button to use as [leading] in AppGradientHeader
class AppHeaderBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const AppHeaderBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 18.sp,
        ),
      ),
    );
  }
}
