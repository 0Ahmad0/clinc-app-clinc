import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_button.dart';
import '../../../app/core/widgets/app_gradient_header.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/register_controller.dart';
import 'widgets/register_account_type_card.dart';
import 'widgets/register_form_card.dart';
import 'widgets/register_nav_row.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          AppGradientHeader(
            gradient: AppGradients.indigo,
            icon: Icons.app_registration_rounded,
            iconCircleSize: 72,
            iconSize: 36,
            title: tr(LocaleKeys.register_title),
            subtitle: tr(LocaleKeys.register_subtitle),
            leading: const AppHeaderBackButton(),
          ),
          Expanded(
            child: SingleChildScrollView(
               
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  24.verticalSpace,
                  RegisterAccountTypeCard(controller: controller),
                  16.verticalSpace,
                  RegisterFormCard(controller: controller),
                  20.verticalSpace,
                  Obx(() => AppGradientButton(
                    label: tr(LocaleKeys.register_buttons_submit),
                    isLoading: controller.isLoading.value,
                    onTap: controller.register,
                    gradient: AppGradients.indigo,
                    shadowColor: AppGradients.indigoShadow,
                  )),
                  20.verticalSpace,
                  const RegisterNavRow(),
                  28.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
