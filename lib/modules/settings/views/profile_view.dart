import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/settings_controller.dart';
import '../../../app/data/profile_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final SettingsController _ctrl;
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _clinicCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _licenseCtrl;
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.find<SettingsController>();
    final p = _ctrl.profile.value;
    _nameCtrl = TextEditingController(text: p.name);
    _emailCtrl = TextEditingController(text: p.email);
    _phoneCtrl = TextEditingController(text: p.phone);
    _clinicCtrl = TextEditingController(text: p.clinicName);
    _addressCtrl = TextEditingController(text: p.clinicAddress ?? '');
    _licenseCtrl = TextEditingController(text: p.licenseNumber ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _clinicCtrl.dispose();
    _addressCtrl.dispose();
    _licenseCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 800));
    final existing = _ctrl.profile.value;
    _ctrl.updateProfile(
      ProfileModel(
        id: existing.id,
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        clinicName: _clinicCtrl.text.trim(),
        clinicAddress: _addressCtrl.text.trim(),
        licenseNumber: _licenseCtrl.text.trim(),
        avatar: existing.avatar,
      ),
    );
    setState(() => _saving = false);
    Get.back();
    Get.snackbar(
      'تم الحفظ',
      'تم تحديث بيانات ملفك الشخصي بنجاح',
      backgroundColor: const Color(0xFF673AB7),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(16.r),
      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160.h,
            backgroundColor: const Color(0xFF4527A0),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            ),
            title: Text(
              'الملف الشخصي',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              TextButton(
                onPressed: _saving ? null : _save,
                child: Text(
                  'حفظ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              10.horizontalSpace,
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF311B92), const Color(0xFF1A0050)]
                        : [const Color(0xFF673AB7), const Color(0xFF311B92)],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      60.verticalSpace,
                      Obx(() {
                        final name = _ctrl.profile.value.name;
                        return Container(
                          width: 64.r,
                          height: 64.r,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF9C27B0), Color(0xFF673AB7)],
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4),
                              width: 2.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              name.isNotEmpty ? name[0] : 'م',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        );
                      }),
                      10.verticalSpace,
                      Text(
                        'اضغط حفظ لتطبيق التغييرات',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (_saving)
                  LinearProgressIndicator(
                    color: const Color(0xFF673AB7),
                    backgroundColor: const Color(0xFF673AB7).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                if (_saving) 16.verticalSpace,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionHeader(title: 'المعلومات الشخصية', icon: Icons.person_rounded, color: const Color(0xFF673AB7)),
                      12.verticalSpace,
                      _FormField(
                        controller: _nameCtrl,
                        label: 'الاسم الكامل',
                        icon: Icons.badge_rounded,
                        color: const Color(0xFF673AB7),
                        validator: (v) => v == null || v.isEmpty ? 'الاسم مطلوب' : null,
                      ),
                      14.verticalSpace,
                      _FormField(
                        controller: _emailCtrl,
                        label: 'البريد الإلكتروني',
                        icon: Icons.email_rounded,
                        color: const Color(0xFF2563EB),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => v == null || !v.contains('@') ? 'بريد إلكتروني غير صحيح' : null,
                      ),
                      14.verticalSpace,
                      _FormField(
                        controller: _phoneCtrl,
                        label: 'رقم الهاتف',
                        icon: Icons.phone_rounded,
                        color: const Color(0xFF009688),
                        keyboardType: TextInputType.phone,
                      ),
                      24.verticalSpace,
                      _SectionHeader(title: 'معلومات العيادة', icon: Icons.local_hospital_rounded, color: const Color(0xFF009688)),
                      12.verticalSpace,
                      _FormField(
                        controller: _clinicCtrl,
                        label: 'اسم العيادة',
                        icon: Icons.business_rounded,
                        color: const Color(0xFF009688),
                        validator: (v) => v == null || v.isEmpty ? 'اسم العيادة مطلوب' : null,
                      ),
                      14.verticalSpace,
                      _FormField(
                        controller: _addressCtrl,
                        label: 'عنوان العيادة',
                        icon: Icons.location_on_rounded,
                        color: const Color(0xFFEF4444),
                        maxLines: 2,
                      ),
                      14.verticalSpace,
                      _FormField(
                        controller: _licenseCtrl,
                        label: 'رقم الترخيص',
                        icon: Icons.verified_rounded,
                        color: const Color(0xFFF59E0B),
                      ),
                      30.verticalSpace,
                      _SaveButton(saving: _saving, onTap: _save),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _SectionHeader({required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 18.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        10.horizontalSpace,
        Icon(icon, color: color, size: 18.sp),
        8.horizontalSpace,
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color color;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.color,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color.withValues(alpha: 0.7), fontSize: 13.sp),
        prefixIcon: Icon(icon, color: color, size: 20.sp),
        filled: true,
        fillColor: color.withValues(alpha: 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: color.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: color.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: color, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: cs.error),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool saving;
  final VoidCallback onTap;

  const _SaveButton({required this.saving, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: saving ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: saving
              ? null
              : const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFF4527A0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: saving ? Colors.grey.shade300 : null,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: saving
              ? []
              : [
                  BoxShadow(
                    color: const Color(0xFF673AB7).withValues(alpha: 0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (saving)
              SizedBox(
                width: 18.r,
                height: 18.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.grey.shade600,
                ),
              )
            else
              const Icon(Icons.save_rounded, color: Colors.white, size: 20),
            10.horizontalSpace,
            Text(
              saving ? 'جاري الحفظ...' : 'حفظ التغييرات',
              style: TextStyle(
                color: saving ? Colors.grey.shade600 : Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
