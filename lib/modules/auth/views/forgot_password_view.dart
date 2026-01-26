import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/core/widgets/app_app_bar_widget.dart';
import '../../../app/core/widgets/app_padding_widget.dart';
import '../../../app/core/widgets/app_scaffold_widget.dart';
import '../controllers/forgot_password_controller.dart';
import 'widgets/forgot_password_actions_widget.dart';
import 'widgets/forgot_password_form_widget.dart';
import 'widgets/forgot_password_header_widget.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: Center(
        // Center مهم هنا لجمالية الشاشات البسيطة
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ForgotPasswordHeaderWidget(),
              40.verticalSpace,
              const ForgotPasswordFormWidget(),
              32.verticalSpace,
              const ForgotPasswordActionsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
