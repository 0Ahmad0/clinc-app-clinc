import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../design/app_gradients.dart';

enum AppButtonVariant { filled, outlined, text }

class AppGradientButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onTap;
  final LinearGradient gradient;
  final Color shadowColor;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? prefixIcon;

  const AppGradientButton({
    super.key,
    required this.label,
    this.isLoading = false,
    this.onTap,
    this.gradient = AppGradients.teal,
    this.shadowColor = AppGradients.tealShadow,
    this.width,
    this.height = 52,
    this.borderRadius = 14,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width ?? double.infinity,
        height: height.h,
        decoration: BoxDecoration(
          gradient: isLoading ? null : gradient,
          color: isLoading ? Colors.grey.shade300 : null,
          borderRadius: BorderRadius.circular(borderRadius.r),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 16,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefixIcon != null) ...[
                      prefixIcon!,
                      8.horizontalSpace,
                    ],
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class AppOutlineGradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color borderColor;
  final Color textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? prefixIcon;

  const AppOutlineGradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.borderColor = const Color(0xFF009688),
    this.textColor = const Color(0xFF009688),
    this.width,
    this.height = 52,
    this.borderRadius = 14,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                8.horizontalSpace,
              ],
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
