import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// The auth input: white surface, hairline border, a blue leading icon and a
/// muted placeholder. Password fields get an eye toggle. Styling comes entirely
/// from theme tokens so light and dark both read correctly.
class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.inputFormatters,
  });

  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscured = widget.obscure;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    OutlineInputBorder border(Color color, [double width = 1.5]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: BorderSide(color: color, width: width),
        );

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: colors.ink,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: colors.muted,
        ),
        filled: true,
        fillColor: colors.surface,
        prefixIcon: Icon(widget.icon, size: 20, color: colors.primary500),
        suffixIcon: widget.obscure
            ? IconButton(
                onPressed: () => setState(() => _obscured = !_obscured),
                icon: Icon(
                  _obscured ? Iconsax.eye_slash : Iconsax.eye,
                  size: 19,
                  color: colors.muted,
                ),
              )
            : null,
        constraints: const BoxConstraints(minHeight: 54),
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        enabledBorder: border(colors.line),
        border: border(colors.line),
        focusedBorder: border(colors.primary500),
      ),
    );
  }
}
