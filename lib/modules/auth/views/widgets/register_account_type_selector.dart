import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../app/data/account_type.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/register_controller.dart';

class RegisterAccountTypeSelector extends GetView<RegisterController> {
  const RegisterAccountTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(LocaleKeys.register_fields_account_type),
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        12.verticalSpace,
        Obx(() {
          final selected = controller.selectedAccountType.value;

          return Column(
            children: [
              _TypeTile(
                title: tr(LocaleKeys.register_account_type_clinic),
                subtitle: 'Services: Medical',
                icon: Icons.local_hospital_outlined,
                selected: selected == AccountType.clinic,
                onTap: () => controller.selectAccountType(AccountType.clinic),
              ),
              10.verticalSpace,
              _TypeTile(
                title: tr(LocaleKeys.register_account_type_clinic_with_lab),
                subtitle: 'Services: Medical + Lab',
                icon: Icons.apartment_outlined,
                selected: selected == AccountType.clinicWithLab,
                onTap: () => controller.selectAccountType(AccountType.clinicWithLab),
              ),
              10.verticalSpace,
              _TypeTile(
                title: tr(LocaleKeys.register_account_type_lab),
                subtitle: 'Services: Lab Only',
                icon: Icons.science_outlined,
                selected: selected == AccountType.lab,
                onTap: () => controller.selectAccountType(AccountType.lab),
              ),
            ],
          );
        }),
      ],
    );
  }
}

class _TypeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TypeTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: selected ? cs.primary.withOpacity(0.12) : cs.surfaceVariant,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(icon, color: selected ? cs.primary : cs.onSurfaceVariant),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  4.verticalSpace,
                  Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle, color: cs.primary),
          ],
        ),
      ),
    );
  }
}