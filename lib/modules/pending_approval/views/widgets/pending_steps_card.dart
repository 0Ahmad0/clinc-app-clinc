import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Module-level colour constants
const _kTeal  = Color(0xFF009688);
const _kAmber = Color(0xFFF59E0B);
const _kGrey  = Color(0xFFBDBDBD); // = Colors.grey.shade400

// ── Step data model (UI-layer only) ──────────────────────────────────────────

class _StepData {
  final IconData icon;
  final Color color;
  final String label;
  final bool done;
  final bool active;
  const _StepData({
    required this.icon,
    required this.color,
    required this.label,
    required this.done,
    this.active = false,
  });
}

const _kSteps = <_StepData>[
  _StepData(icon: Icons.check_circle_rounded, color: _kTeal,  label: 'تسجيل الحساب',        done: true),
  _StepData(icon: Icons.pending_rounded,      color: _kAmber, label: 'مراجعة الطلب',         done: false, active: true),
  _StepData(icon: Icons.verified_rounded,     color: _kGrey,  label: 'التفعيل والانطلاق',   done: false),
];

/// White card showing 3-step activation progress tracker.
class PendingStepsCard extends StatelessWidget {
  const PendingStepsCard({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مراحل التفعيل',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14.sp,
              color: Colors.grey.shade800,
            ),
          ),
          16.verticalSpace,
          ...List.generate(
            _kSteps.length,
            (i) => _StepRow(step: _kSteps[i], isLast: i == _kSteps.length - 1),
          ),
        ],
      ),
    );
  }
}

// ── Private ───────────────────────────────────────────────────────────────────

class _StepRow extends StatelessWidget {
  final _StepData step;
  final bool isLast;
  const _StepRow({required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: step.color.withValues(alpha: step.done || step.active ? 0.12 : 0.06),
                shape: BoxShape.circle,
                border: Border.all(
                  color: step.active ? step.color : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Icon(step.icon, color: step.color, size: 18.r),
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 28.h,
                margin: EdgeInsets.symmetric(vertical: 4.h),
                color: Colors.grey.shade200,
              ),
          ],
        ),
        12.horizontalSpace,
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            step.label,
            style: TextStyle(
              fontWeight: step.active ? FontWeight.w800 : FontWeight.w500,
              fontSize: 13.sp,
              color: step.done || step.active ? Colors.grey.shade800 : Colors.grey.shade400,
            ),
          ),
        ),
      ],
    );
  }
}
