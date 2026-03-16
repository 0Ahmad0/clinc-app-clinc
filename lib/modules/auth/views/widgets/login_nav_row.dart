import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';

class LoginNavRow extends StatelessWidget {
  final VoidCallback onRegisterTap;
  const LoginNavRow({super.key, required this.onRegisterTap});

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr(LocaleKeys.login_buttons_register_text),
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
        ),
        6.horizontalSpace,
        GestureDetector(
          onTap: onRegisterTap,
          child: Text(
            tr(LocaleKeys.login_buttons_register_action),
            style: TextStyle(
              color: _teal,
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
