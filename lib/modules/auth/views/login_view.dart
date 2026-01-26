import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/core/widgets/app_padding_widget.dart';
import '../../../app/core/widgets/app_scaffold_widget.dart';
import '../controllers/login_controller.dart';
import 'widgets/login_actions_widget.dart';
import 'widgets/login_form_widget.dart';
import 'widgets/login_header_widget.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoginHeaderWidget(),
                40.verticalSpace, // مسافة أكبر قليلاً لفصل الهيدر
                const LoginFormWidget(),
                24.verticalSpace,
                const LoginActionsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
