import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../core/media/media_service.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_gradient_header.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../shared/widgets/media_source_sheet.dart';
import '../cubit/create_ad_cubit.dart';
import '../cubit/create_ad_state.dart';
import '../widgets/ad_cover_picker.dart';

/// Longest ad title / description the form accepts.
const _titleMaxLength = 60;
const _descriptionMaxLength = 220;

/// Route entry point for composing an ad.
class CreateAdPage extends StatelessWidget {
  const CreateAdPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<CreateAdCubit>(),
    child: const _CreateAdView(),
  );
}

/// The compose form, swapped for a confirmation once the ad is queued.
class _CreateAdView extends StatefulWidget {
  const _CreateAdView();

  @override
  State<_CreateAdView> createState() => _CreateAdViewState();
}

class _CreateAdViewState extends State<_CreateAdView> {
  final _titleAr = TextEditingController();
  final _titleEn = TextEditingController();
  final _descriptionAr = TextEditingController();
  final _descriptionEn = TextEditingController();

  @override
  void dispose() {
    _titleAr.dispose();
    _titleEn.dispose();
    _descriptionAr.dispose();
    _descriptionEn.dispose();
    super.dispose();
  }

  Future<void> _pickCover() async {
    final cubit = context.read<CreateAdCubit>();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const MediaSourceSheet(),
    );
    if (source == null) return;
    final path = await sl<MediaService>().pickImage(source);
    if (path != null) cubit.setCover(path);
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<CreateAdCubit>().submit();
  }

  void _composeAnother() {
    _titleAr.clear();
    _titleEn.clear();
    _descriptionAr.clear();
    _descriptionEn.clear();
    context.read<CreateAdCubit>().reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bg,
      body: BlocConsumer<CreateAdCubit, CreateAdState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage &&
            current.errorMessage.isNotEmpty,
        listener: (context, state) {
          AppToast.show(
            context,
            title: context.l10n.adsSubmitFailedTitle,
            message: state.errorMessage,
            type: AppFeedbackType.danger,
          );
        },
        builder: (context, state) {
          return state.submitted
              ? _SubmittedView(onComposeAnother: _composeAnother)
              : _ComposeView(
                  state: state,
                  titleArController: _titleAr,
                  titleEnController: _titleEn,
                  descriptionArController: _descriptionAr,
                  descriptionEnController: _descriptionEn,
                  onPickCover: _pickCover,
                  onSubmit: _submit,
                );
        },
      ),
    );
  }
}

/// Header, scrollable form and the pinned submit bar.
class _ComposeView extends StatelessWidget {
  const _ComposeView({
    required this.state,
    required this.titleArController,
    required this.titleEnController,
    required this.descriptionArController,
    required this.descriptionEnController,
    required this.onPickCover,
    required this.onSubmit,
  });

  final CreateAdState state;
  final TextEditingController titleArController;
  final TextEditingController titleEnController;
  final TextEditingController descriptionArController;
  final TextEditingController descriptionEnController;
  final VoidCallback onPickCover;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final cubit = context.read<CreateAdCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppGradientHeader(
          title: l10n.adsCreateTitle,
          subtitle: l10n.adsCreateSubtitle,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              AppSpacing.lg,
              AppSpacing.screen,
              AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _FieldLabel(l10n.adsCoverLabel),
                AppGaps.h8,
                AdCoverPicker(coverPath: state.coverPath, onTap: onPickCover),
                AppGaps.h8,
                Text(
                  l10n.adsCoverHint,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.muted,
                  ),
                ),
                AppGaps.h24,
                _FieldLabel(l10n.adsTitleArLabel),
                AppGaps.h8,
                _AdField(
                  controller: titleArController,
                  hint: l10n.adsTitleArHint,
                  maxLength: _titleMaxLength,
                  textDirection: TextDirection.rtl,
                  onChanged: cubit.setTitleAr,
                ),
                _Counter(count: state.titleAr.length, max: _titleMaxLength),
                AppGaps.h16,
                _FieldLabel(l10n.adsTitleEnLabel),
                AppGaps.h8,
                _AdField(
                  controller: titleEnController,
                  hint: l10n.adsTitleEnHint,
                  maxLength: _titleMaxLength,
                  textDirection: TextDirection.ltr,
                  onChanged: cubit.setTitleEn,
                ),
                _Counter(count: state.titleEn.length, max: _titleMaxLength),
                AppGaps.h16,
                _FieldLabel(l10n.adsDescriptionArLabel),
                AppGaps.h8,
                _AdField(
                  controller: descriptionArController,
                  hint: l10n.adsDescriptionArHint,
                  maxLength: _descriptionMaxLength,
                  maxLines: 5,
                  textDirection: TextDirection.rtl,
                  textInputAction: TextInputAction.newline,
                  onChanged: cubit.setDescriptionAr,
                ),
                _Counter(
                  count: state.descriptionAr.length,
                  max: _descriptionMaxLength,
                ),
                AppGaps.h16,
                _FieldLabel(l10n.adsDescriptionEnLabel),
                AppGaps.h8,
                _AdField(
                  controller: descriptionEnController,
                  hint: l10n.adsDescriptionEnHint,
                  maxLength: _descriptionMaxLength,
                  maxLines: 5,
                  textDirection: TextDirection.ltr,
                  textInputAction: TextInputAction.newline,
                  onChanged: cubit.setDescriptionEn,
                ),
                _Counter(
                  count: state.descriptionEn.length,
                  max: _descriptionMaxLength,
                ),
                AppGaps.h16,
                _ReviewNote(text: l10n.adsReviewNote),
              ],
            ),
          ),
        ),
        _SubmitBar(
          enabled: state.canSubmit,
          isLoading: state.isSubmitting,
          label: l10n.adsSubmitCta,
          onSubmit: onSubmit,
        ),
      ],
    );
  }
}

/// Confirmation shown once the ad is queued for review.
class _SubmittedView extends StatelessWidget {
  const _SubmittedView({required this.onComposeAnother});

  final VoidCallback onComposeAnother;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSizes.adSuccessBadge,
              height: AppSizes.adSuccessBadge,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: colors.heroBadgeGradient,
                borderRadius: BorderRadius.circular(AppRadius.art - 12),
              ),
              child: Icon(
                Iconsax.tick_circle,
                size: AppSizes.iconLg + AppSpacing.md,
                color: colors.onBrand,
              ),
            ),
            AppGaps.h24,
            Text(
              l10n.adsSubmittedTitle,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(color: colors.ink),
            ),
            AppGaps.h8,
            Text(
              l10n.adsSubmittedDesc,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.gray,
                height: 1.8,
              ),
            ),
            AppGaps.h24,
            AppButton(
              label: l10n.adsComposeAnother,
              icon: Iconsax.add_circle,
              onPressed: onComposeAnother,
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom bar holding the submit CTA above the home indicator.
class _SubmitBar extends StatelessWidget {
  const _SubmitBar({
    required this.enabled,
    required this.isLoading,
    required this.label,
    required this.onSubmit,
  });

  final bool enabled;
  final bool isLoading;
  final String label;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.sm + 2,
        AppSpacing.screen,
        MediaQuery.paddingOf(context).bottom + AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.line)),
      ),
      child: AppButton(
        label: label,
        icon: Iconsax.send_2,
        isLoading: isLoading,
        onPressed: enabled ? onSubmit : null,
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: context.textTheme.bodyMedium?.copyWith(
      color: context.colors.ink,
      fontWeight: FontWeight.w700,
    ),
  );
}

/// Remaining-characters hint under a field.
class _Counter extends StatelessWidget {
  const _Counter({required this.count, required this.max});

  final int count;
  final int max;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(top: AppSpacing.xxs),
    child: Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        context.l10n.adsCharCounter(count, max),
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colors.muted,
        ),
      ),
    ),
  );
}

/// Text input used by the ad form — the counter lives outside the field, so the
/// built-in one is suppressed.
class _AdField extends StatelessWidget {
  const _AdField({
    required this.controller,
    required this.hint,
    required this.maxLength,
    required this.onChanged,
    this.maxLines = 1,
    this.textDirection,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final TextDirection? textDirection;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.field),
      borderSide: BorderSide(color: color, width: 1.5),
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines,
      textDirection: textDirection,
      textInputAction: textInputAction,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: colors.ink,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: context.textTheme.bodyMedium?.copyWith(color: colors.muted),
        counterText: '',
        filled: true,
        fillColor: colors.surface,
        constraints: const BoxConstraints(minHeight: AppSizes.hitTarget + 8),
        contentPadding: const EdgeInsetsDirectional.all(AppSpacing.md),
        enabledBorder: border(colors.line),
        border: border(colors.line),
        focusedBorder: border(colors.primary500),
      ),
    );
  }
}

/// Tinted note explaining the admin review step.
class _ReviewNote extends StatelessWidget {
  const _ReviewNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.primary500.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadius.field - 2),
        border: Border.all(color: colors.primary500.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.clock, size: AppSizes.iconSm, color: colors.primary600),
          AppGaps.w8,
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.slate,
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
