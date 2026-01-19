import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // تأكد من المكتبة
import '../../../app/core/widgets/app_app_bar_widget.dart';
import '../../../app/core/widgets/app_padding_widget.dart';
import '../../../app/core/widgets/app_scaffold_widget.dart';
import '../controllers/register_controller.dart';
import 'widgets/register_actions_widget.dart';
import 'widgets/register_form_widget.dart';
import 'widgets/register_header_widget.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: AppPaddingWidget(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RegisterHeaderWidget(),
              32.verticalSpace,
              const RegisterFormWidget(),
              24.verticalSpace,
              const RegisterActionsWidget(),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
