import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/data/account_type.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/register_controller.dart';
import 'register_type_tile.dart';

class RegisterAccountTypeCard extends StatelessWidget {
  final RegisterController controller;
  const RegisterAccountTypeCard({super.key, required this.controller});

  static const _indigo = Color(0xFF3949AB);
  static const _blue = Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(18.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: _indigo.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.category_rounded, color: _indigo, size: 18.r),
              ),
              10.horizontalSpace,
              Text(
                'نوع الحساب',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.sp,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          14.verticalSpace,
          Obx(() => Row(
            children: [
              Expanded(
                child: RegisterTypeTile(
                  title: tr(LocaleKeys.register_account_type_clinic),
                  subtitle: 'عيادة طبية',
                  icon: Icons.local_hospital_rounded,
                  selected: controller.selectedAccountType.value == AccountType.clinic,
                  color: _indigo,
                  onTap: () => controller.selectAccountType(AccountType.clinic),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: RegisterTypeTile(
                  title: tr(LocaleKeys.register_account_type_lab),
                  subtitle: 'مختبر طبي',
                  icon: Icons.science_rounded,
                  selected: controller.selectedAccountType.value == AccountType.lab,
                  color: _blue,
                  onTap: () => controller.selectAccountType(AccountType.lab),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
