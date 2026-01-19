import 'package:clinc_app_clinc/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../general_dialog.dart';

class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralAppDialog(
      title: 'هل تريد بالفعل تسجيل الخروج ؟',
      generalColor: AppColors.error,
      okOnTap: () => null,
      icon: Iconsax.logout,
    );
  }
}
