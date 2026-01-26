import 'package:clinc_app_clinc/app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingIllustration extends StatelessWidget {
  final int index;

  const OnboardingIllustration({super.key, required this.index});

  String _assetFor(int i) {
    switch (i) {
      case 0:
        return AppAssets.onboardingAppointments;
      case 1:
        return AppAssets.onboardingTeam;
      case 2:
      default:
        return AppAssets.onboardingReports;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _assetFor(index),
      width: double.maxFinite,
      height: 200.h,
    );
  }
}
