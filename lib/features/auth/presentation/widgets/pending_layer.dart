import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/auth_layer.dart';
import '../cubit/auth_cubit.dart';
import 'auth_pulse_badge.dart';
import 'pending_steps.dart';

/// The final signup layer shown while the facility request is reviewed.
class PendingLayer extends StatelessWidget {
  const PendingLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.lg,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight - AppSpacing.xxl,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: AuthPulseBadge(
                    icon: Iconsax.clock,
                    shapeSize: AppSizes.authPendingShape,
                    haloSize: AppSizes.authPendingBadge,
                    ringSize: AppSizes.authPendingRing,
                    iconSize: AppSizes.authPendingIcon,
                    circle: true,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  l10n.authPendingTitle,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: AppSpacing.lg,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.authPendingDesc,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: colors.gray,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const PendingSteps(),
                const Spacer(),
                const SizedBox(height: AppSpacing.lg),
                OutlinedButton(
                  onPressed: () =>
                      context.read<AuthCubit>().show(AuthLayer.login),
                  child: Text(l10n.authBackToLogin),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
