import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';

class ForgotPasswordNavRow extends StatelessWidget {
  final VoidCallback onBackToLogin;
  const ForgotPasswordNavRow({super.key, required this.onBackToLogin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackToLogin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_back_ios_rounded,
            size: 13.r,
            color: Colors.grey.shade600,
          ),
          6.horizontalSpace,
          Text(
            tr(LocaleKeys.forgot_password_buttons_back_to_login),
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
