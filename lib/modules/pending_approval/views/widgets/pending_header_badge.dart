import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const _kAmber = Color(0xFFF59E0B);

/// Amber hourglass badge overlaid on the header icon circle.
class PendingHeaderBadge extends StatelessWidget {
  const PendingHeaderBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.r,
      height: 22.r,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: _kAmber, width: 1.5),
      ),
      child: Icon(Icons.hourglass_empty_rounded, size: 12.r, color: _kAmber),
    );
  }
}
