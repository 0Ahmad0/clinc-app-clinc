import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/add_doctor_cubit.dart';

class AddDoctorHeader extends StatelessWidget {
  const AddDoctorHeader({
    super.key,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
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
              AppSpacing.lg,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: AppSizes.hitTarget,
                        height: AppSizes.hitTarget,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colors.onBrand.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(AppRadius.field),
                        ),
                        child: Icon(
                          rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
                          color: colors.onBrand,
                          size: AppSizes.iconMd,
                        ),
                      ),
                    ),
                    AppGaps.w12,
                    Text(
                      context.l10n.addDoctorTitle,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: colors.onBrand,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                AppGaps.h16,
                BlocBuilder<AddDoctorCubit, AddDoctorState>(
                  builder: (context, state) {
                    final imagePath =
                        state.imagePath ?? state.initialDoctor?.imageUrl;
                    return GestureDetector(
                      onTap: onPickImage,
                      child: SizedBox(
                        width: AppSizes.addDoctorAvatar,
                        height: AppSizes.addDoctorAvatar,
                        child: Stack(
                          children: [
                            Container(
                              width: AppSizes.addDoctorAvatar,
                              height: AppSizes.addDoctorAvatar,
                              clipBehavior: Clip.antiAlias,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.onBrand.withValues(alpha: 0.14),
                                border: Border.all(
                                  color: colors.onBrand.withValues(alpha: 0.4),
                                  width: 2,
                                ),
                              ),
                              child: imagePath == null
                                  ? Icon(
                                      Iconsax.user,
                                      color: colors.onBrand.withValues(
                                        alpha: 0.85,
                                      ),
                                      size: AppSizes.iconLg + AppSpacing.md,
                                    )
                                  : _DoctorImage(path: imagePath),
                            ),
                            PositionedDirectional(
                              bottom: 0,
                              end: 0,
                              child: Container(
                                width: AppSizes.addDoctorAvatarBadge,
                                height: AppSizes.addDoctorAvatarBadge,
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
                                  Iconsax.camera,
                                  color: colors.primary600,
                                  size: AppSizes.iconSm - 2,
                                ),
                              ),
                            ),
                            if (state.imagePath != null)
                              PositionedDirectional(
                                top: 0,
                                start: 0,
                                child: GestureDetector(
                                  onTap: onRemoveImage,
                                  child: Container(
                                    width: AppSizes.addDoctorAvatarBadge,
                                    height: AppSizes.addDoctorAvatarBadge,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors.dangerFg,
                                      border: Border.all(
                                        color: colors.surface,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Iconsax.close_circle,
                                      color: colors.onBrand,
                                      size: AppSizes.iconXs,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                AppGaps.h8,
                Text(
                  context.l10n.addDoctorSubtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.onBrand.withValues(alpha: 0.75),
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

class _DoctorImage extends StatelessWidget {
  const _DoctorImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http')) return Image.network(path, fit: BoxFit.cover);
    return Image.file(File(path), fit: BoxFit.cover);
  }
}
