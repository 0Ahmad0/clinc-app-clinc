import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/design/app_gradients.dart';
import '../../../../app/core/widgets/app_gradient_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/doctors_controller.dart';

class AddDoctorButton extends GetView<DoctorsController> {
  const AddDoctorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientButton(
      label: tr(LocaleKeys.doctors_page_add_button),
      gradient: AppGradients.indigo,
      shadowColor: AppGradients.indigoShadow,
      prefixIcon: Icon(Icons.add_rounded, color: Colors.white, size: 22.sp),
      onTap: controller.goToAddDoctor,
    );
  }
}
