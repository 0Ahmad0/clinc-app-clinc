import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const _kBlue = Color(0xFF2563EB);

/// Dashed-border "Add" card shown at the end of each services grid.
class ServiceAddCard extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ServiceAddCard({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: _kBlue.withValues(alpha: 0.3),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52.r,
              height: 52.r,
              decoration: BoxDecoration(
                color: _kBlue.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add_rounded, color: _kBlue, size: 28.sp),
            ),
            14.verticalSpace,
            Text(
              label,
              style: TextStyle(color: _kBlue, fontWeight: FontWeight.w700, fontSize: 13.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
