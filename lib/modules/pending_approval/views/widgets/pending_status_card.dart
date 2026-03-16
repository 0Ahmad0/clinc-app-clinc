import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/locale_keys.g.dart';

const _kAmber = Color(0xFFF59E0B);

/// White card showing the current request status + description text.
class PendingStatusCard extends StatelessWidget {
  const PendingStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          Row(
            children: [
              _StatusIcon(),
              12.horizontalSpace,
              const Expanded(child: _StatusLabel()),
            ],
          ),
          16.verticalSpace,
          const _DescriptionBox(),
        ],
      ),
    );
  }
}

// ── Private ───────────────────────────────────────────────────────────────────

class _StatusIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.r,
      height: 42.r,
      decoration: BoxDecoration(
        color: _kAmber.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(Icons.info_rounded, color: _kAmber, size: 22.r),
    );
  }
}

class _StatusLabel extends StatelessWidget {
  const _StatusLabel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'حالة الطلب',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14.sp,
            color: Colors.grey.shade800,
          ),
        ),
        4.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: _kAmber.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            'قيد المراجعة',
            style: TextStyle(
              color: _kAmber,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _DescriptionBox extends StatelessWidget {
  const _DescriptionBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        tr(LocaleKeys.pending_approval_description),
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12.sp,
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
