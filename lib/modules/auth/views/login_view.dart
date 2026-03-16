import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_header.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/login_controller.dart';
import 'widgets/login_form_card.dart';
import 'widgets/login_nav_row.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          AppGradientHeader(
            gradient: AppGradients.teal,
            icon: Icons.local_hospital_rounded,
            title: tr(LocaleKeys.login_title),
            subtitle: tr(LocaleKeys.login_subtitle),
          ),
          Expanded(
            child: SingleChildScrollView(
               
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  28.verticalSpace,
                  LoginFormCard(controller: controller),
                  24.verticalSpace,
                  LoginNavRow(onRegisterTap: controller.toRegister),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
