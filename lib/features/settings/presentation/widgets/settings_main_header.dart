import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/extensions/image_extension.dart';
import '../../domain/settings_section.dart';
import '../cubit/settings_cubit.dart';

/// Gradient header for the main settings screen: title, clinic logo with an
/// edit badge (opens the profile) and the clinic name + email.
class SettingsMainHeader extends StatelessWidget {
  const SettingsMainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final clinic = context.select((SettingsCubit cubit) => cubit.state.clinic);
    final clinicName = clinic?.name?.trim().isNotEmpty == true
        ? clinic!.name!
        : l10n.settingsClinicName;
    final clinicEmail = clinic?.email?.trim().isNotEmpty == true
        ? clinic!.email!
        : l10n.settingsClinicEmail;
    final clinicLogo = clinic?.logo?.trim();
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: colors.headerGradient,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.homeHeader),
        ),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: -AppSizes.homeHeaderCircleTop,
            start: -AppSizes.homeHeaderCircleStart,
            child: Container(
              width: AppSizes.homeHeaderCircleSmall,
              height: AppSizes.homeHeaderCircleSmall,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.onBrand.withValues(alpha: 0.12),
                  width: 1.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              MediaQuery.paddingOf(context).top + AppSpacing.md,
              AppSpacing.screen,
              AppSpacing.xl,
            ),
            child: Column(
              children: [
                Text(
                  l10n.settingsTitle,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: colors.onBrand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppGaps.h16,
                SizedBox(
                  width: AppSizes.settingsAvatar,
                  height: AppSizes.settingsAvatar,
                  child: Stack(
                    children: [
                      Container(
                        width: AppSizes.settingsAvatar,
                        height: AppSizes.settingsAvatar,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.onBrand.withValues(alpha: 0.16),
                          border: Border.all(
                            color: colors.onBrand.withValues(alpha: 0.35),
                            width: 2,
                          ),
                        ),
                        child: _SettingsClinicLogo(
                          imageUrl: clinicLogo?.isNotEmpty == true
                              ? clinicLogo!.withStorage()
                              : null,
                        ),
                      ),
                      PositionedDirectional(
                        bottom: 0,
                        end: 0,
                        child: GestureDetector(
                          onTap: () => context.read<SettingsCubit>().show(
                            SettingsSection.profile,
                          ),
                          child: Container(
                            width: AppSizes.settingsAvatarBadge,
                            height: AppSizes.settingsAvatarBadge,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.surface,
                              border: Border.all(
                                color: colors.primary600,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Iconsax.edit_2,
                              color: colors.primary600,
                              size: AppSizes.iconXs,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppGaps.h8,
                Text(
                  clinicName,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: colors.onBrand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  clinicEmail,
                  textDirection: TextDirection.ltr,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.onBrand.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsClinicLogo extends StatelessWidget {
  const _SettingsClinicLogo({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final fallback = _SettingsClinicLogoFallback(color: context.colors.onBrand);
    final url = imageUrl;
    if (url == null || url.isEmpty) return fallback;

    return CachedNetworkImage(
      imageUrl: url,
      width: AppSizes.settingsAvatar,
      height: AppSizes.settingsAvatar,
      fit: BoxFit.cover,
      placeholder: (_, __) => fallback,
      errorWidget: (_, __, ___) => fallback,
    );
  }
}

class _SettingsClinicLogoFallback extends StatelessWidget {
  const _SettingsClinicLogoFallback({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/app_logo.svg',
        width: AppSizes.settingsLogo,
        height: AppSizes.settingsLogo,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
