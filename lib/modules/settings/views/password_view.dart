import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() => _saving = false);
    Get.back();
    Get.snackbar(
      'تم التغيير',
      'تم تغيير كلمة المرور بنجاح',
      backgroundColor: const Color(0xFF4527A0),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(16.r),
      icon: const Icon(Icons.lock_rounded, color: Colors.white),
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
         
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150.h,
            backgroundColor: const Color(0xFF1E3A8A),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            ),
            title: Text(
              'تغيير كلمة المرور',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF1E3A8A), const Color(0xFF0F172A)]
                        : [const Color(0xFF2563EB), const Color(0xFF1E3A8A)],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      55.verticalSpace,
                      Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.lock_rounded,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        'أمان حسابك أولويتنا',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 40.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (_saving)
                  LinearProgressIndicator(
                    color: const Color(0xFF2563EB),
                    backgroundColor: const Color(0xFF2563EB).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                if (_saving) 16.verticalSpace,
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: const Color(0xFF2563EB),
                        size: 20.sp,
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Text(
                          'يجب أن تكون كلمة المرور الجديدة 8 أحرف على الأقل وتحتوي على أرقام وحروف',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF2563EB).withValues(alpha: 0.8),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                24.verticalSpace,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _PasswordField(
                        controller: _currentCtrl,
                        label: 'كلمة المرور الحالية',
                        hint: 'أدخل كلمة مرورك الحالية',
                        show: _showCurrent,
                        onToggle: () => setState(() => _showCurrent = !_showCurrent),
                        color: const Color(0xFF64748B),
                        validator: (v) => v == null || v.isEmpty ? 'يرجى إدخال كلمة المرور الحالية' : null,
                      ),
                      20.verticalSpace,
                      _PasswordField(
                        controller: _newCtrl,
                        label: 'كلمة المرور الجديدة',
                        hint: '8 أحرف على الأقل',
                        show: _showNew,
                        onToggle: () => setState(() => _showNew = !_showNew),
                        color: const Color(0xFF2563EB),
                        validator: (v) {
                          if (v == null || v.length < 8) return 'يجب أن تكون 8 أحرف على الأقل';
                          return null;
                        },
                      ),
                      20.verticalSpace,
                      _PasswordField(
                        controller: _confirmCtrl,
                        label: 'تأكيد كلمة المرور',
                        hint: 'أعد كتابة كلمة المرور الجديدة',
                        show: _showConfirm,
                        onToggle: () => setState(() => _showConfirm = !_showConfirm),
                        color: const Color(0xFF673AB7),
                        validator: (v) {
                          if (v != _newCtrl.text) return 'كلمتا المرور غير متطابقتين';
                          return null;
                        },
                      ),
                      32.verticalSpace,
                      _StrengthIndicator(password: _newCtrl.text),
                      30.verticalSpace,
                      _ChangeButton(saving: _saving, onTap: _save),
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

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool show;
  final VoidCallback onToggle;
  final Color color;
  final String? Function(String?)? validator;

  const _PasswordField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.show,
    required this.onToggle,
    required this.color,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      obscureText: !show,
      validator: validator,
      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: color.withValues(alpha: 0.7), fontSize: 13.sp),
        prefixIcon: Icon(Icons.lock_outline_rounded, color: color, size: 20.sp),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            show ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: color.withValues(alpha: 0.5),
            size: 20.sp,
          ),
        ),
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
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }
}

class _StrengthIndicator extends StatelessWidget {
  final String password;

  const _StrengthIndicator({required this.password});

  int get _strength {
    if (password.isEmpty) return 0;
    int s = 0;
    if (password.length >= 8) s++;
    if (password.contains(RegExp(r'[A-Z]'))) s++;
    if (password.contains(RegExp(r'[0-9]'))) s++;
    if (password.contains(RegExp(r'[!@#\$&*~]'))) s++;
    return s;
  }

  Color get _color {
    switch (_strength) {
      case 0:
      case 1:
        return const Color(0xFFEF4444);
      case 2:
        return const Color(0xFFF59E0B);
      case 3:
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF10B981);
    }
  }

  String get _label {
    switch (_strength) {
      case 0:
        return 'أدخل كلمة مرور';
      case 1:
        return 'ضعيفة جداً';
      case 2:
        return 'متوسطة';
      case 3:
        return 'جيدة';
      default:
        return 'قوية جداً';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'قوة كلمة المرور:',
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            6.horizontalSpace,
            Text(
              _label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: _color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Row(
          children: List.generate(4, (i) {
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(left: i < 3 ? 4.w : 0),
                height: 6.h,
                decoration: BoxDecoration(
                  color: i < _strength
                      ? _color
                      : cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _ChangeButton extends StatelessWidget {
  final bool saving;
  final VoidCallback onTap;

  const _ChangeButton({required this.saving, required this.onTap});

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
                  colors: [Color(0xFF2563EB), Color(0xFF1E3A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: saving ? Colors.grey.shade300 : null,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: saving
              ? []
              : [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.35),
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
              const Icon(Icons.lock_reset_rounded, color: Colors.white, size: 20),
            10.horizontalSpace,
            Text(
              saving ? 'جاري التغيير...' : 'تغيير كلمة المرور',
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
