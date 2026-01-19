import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/core/widgets/app_svg_widget.dart';
import '../../../../generated/locale_keys.g.dart';


class ForgotPasswordHeaderWidget extends StatelessWidget {
  const ForgotPasswordHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // يفضل استخدام صورة Vector تعبر عن نسيان كلمة السر
        AppSvgWidget(
          path: 'assets/icons/forgot_password.svg',
          height: 150.h,
          width: 150.w,
        ),
        32.verticalSpace,
        Text(
          tr(LocaleKeys.forgot_password_title),
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        12.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            tr(LocaleKeys.forgot_password_subtitle),
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: Colors.grey[600],
              height: 1.5, // لزيادة المسافة بين الأسطر للقراءة المريحة
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}