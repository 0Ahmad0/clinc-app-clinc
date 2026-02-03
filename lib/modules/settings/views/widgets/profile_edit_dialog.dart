import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../app/data/profile_model.dart';

class ProfileEditDialog extends StatefulWidget {
  final ProfileModel profile;
  final Function(ProfileModel) onSave;

  const ProfileEditDialog({
    super.key,
    required this.profile,
    required this.onSave,
  });

  @override
  State<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController clinicNameController;
  late TextEditingController clinicAddressController;
  late TextEditingController licenseController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    emailController = TextEditingController(text: widget.profile.email);
    phoneController = TextEditingController(text: widget.profile.phone);
    clinicNameController = TextEditingController(text: widget.profile.clinicName);
    clinicAddressController = TextEditingController(text: widget.profile.clinicAddress);
    licenseController = TextEditingController(text: widget.profile.licenseNumber ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    clinicNameController.dispose();
    clinicAddressController.dispose();
    licenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AlertDialog(
      title: Text(
        tr(LocaleKeys.settings_edit_profile),
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: tr(LocaleKeys.settings_profile_name),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(LocaleKeys.settings_validation_required);
                  }
                  return null;
                },
              ),
              12.verticalSpace,

              // Email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: tr(LocaleKeys.settings_profile_email),
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(LocaleKeys.settings_validation_required);
                  }
                  if (!GetUtils.isEmail(value)) {
                    return tr(LocaleKeys.settings_validation_invalid_email);
                  }
                  return null;
                },
              ),
              12.verticalSpace,

              // Phone
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: tr(LocaleKeys.settings_profile_phone),
                  prefixIcon: const Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(LocaleKeys.settings_validation_required);
                  }
                  return null;
                },
              ),
              12.verticalSpace,

              // Clinic Name
              TextFormField(
                controller: clinicNameController,
                decoration: InputDecoration(
                  labelText: tr(LocaleKeys.settings_profile_clinic_name),
                  prefixIcon: const Icon(Icons.local_hospital_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(LocaleKeys.settings_validation_required);
                  }
                  return null;
                },
              ),
              12.verticalSpace,

              // Clinic Address
              TextFormField(
                controller: clinicAddressController,
                decoration: InputDecoration(
                  labelText: tr(LocaleKeys.settings_profile_clinic_address),
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(LocaleKeys.settings_validation_required);
                  }
                  return null;
                },
              ),
              12.verticalSpace,

              // License Number
              TextFormField(
                controller: licenseController,
                decoration: InputDecoration(
                  labelText: tr(LocaleKeys.settings_profile_license),
                  prefixIcon: const Icon(Icons.badge_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            tr(LocaleKeys.settings_cancel),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final updatedProfile = ProfileModel(
                id: widget.profile.id,
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
                avatar: widget.profile.avatar,
                clinicName: clinicNameController.text,
                clinicAddress: clinicAddressController.text,
                licenseNumber: licenseController.text.isEmpty
                    ? null
                    : licenseController.text,
              );
              widget.onSave(updatedProfile);
              Get.back();
            }
          },
          child: Text(
            tr(LocaleKeys.settings_save),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}