import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAuthField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextInputAction inputAction;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final Color accentColor;
  final bool enabled;
  final int maxLines;
  final Widget? suffixWidget;

  const AppAuthField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.inputAction = TextInputAction.next,
    this.validator,
    this.onSubmitted,
    this.keyboardType,
    this.accentColor = const Color(0xFF009688),
    this.enabled = true,
    this.maxLines = 1,
    this.suffixWidget,
  });

  @override
  State<AppAuthField> createState() => _AppAuthFieldState();
}

class _AppAuthFieldState extends State<AppAuthField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      textInputAction: widget.inputAction,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13.sp),
        prefixIcon: Icon(widget.icon, color: widget.accentColor, size: 20.sp),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () => setState(() => _obscure = !_obscure),
                child: Icon(
                  _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey.shade400,
                  size: 20.sp,
                ),
              )
            : widget.suffixWidget,
        filled: true,
        fillColor: const Color(0xFFF8FFFE),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: widget.accentColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: Colors.red.shade400),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }
}
