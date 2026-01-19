import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';

class WelcomeText extends StatelessWidget {
  final ThemeData theme;

  const WelcomeText({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      tr(LocaleKeys.splash_welcome),
      style: theme.textTheme.displayLarge?.copyWith(color: theme.primaryColor),
    );
  }
}
