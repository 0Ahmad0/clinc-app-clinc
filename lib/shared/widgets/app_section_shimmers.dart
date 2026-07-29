import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';
import 'app_shimmer_placeholder.dart';

class FiltersShimmer extends StatelessWidget {
  const FiltersShimmer({super.key, this.count = 5});

  final int count;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.screen,
      AppSpacing.sm,
      AppSpacing.screen,
      AppSpacing.xxs,
    ),
    child: Row(
      children: [
        for (var index = 0; index < count; index++) ...[
          if (index > 0) const SizedBox(width: AppSpacing.xs),
          AppShimmerPlaceholder(
            width: index == 0 ? 76 : 108,
            height: 38,
            borderRadius: AppRadius.pill,
          ),
        ],
      ],
    ),
  );
}

class CardsGridShimmer extends StatelessWidget {
  const CardsGridShimmer({
    super.key,
    this.itemCount = 4,
    this.bottomPadding = AppSizes.homeBottomClearance,
  });

  final int itemCount;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: EdgeInsetsDirectional.fromSTEB(
      AppSpacing.screen,
      AppSpacing.md,
      AppSpacing.screen,
      bottomPadding,
    ),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: itemCount,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisExtent: AppSizes.servicesCardMinHeight,
      crossAxisSpacing: AppSpacing.sm,
      mainAxisSpacing: AppSpacing.sm,
    ),
    itemBuilder: (_, __) => const AppShimmerPlaceholder(
      height: AppSizes.servicesCardMinHeight,
      borderRadius: AppRadius.card,
    ),
  );
}

class ListShimmer extends StatelessWidget {
  const ListShimmer({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 108,
    this.bottomPadding = AppSizes.homeBottomClearance,
  });

  final int itemCount;
  final double itemHeight;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: EdgeInsetsDirectional.fromSTEB(
      AppSpacing.screen,
      AppSpacing.sm,
      AppSpacing.screen,
      bottomPadding,
    ),
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: itemCount,
    separatorBuilder: (_, __) => AppGaps.h12,
    itemBuilder: (_, __) =>
        AppShimmerPlaceholder(height: itemHeight, borderRadius: AppRadius.card),
  );
}

class HomeDashboardShimmer extends StatelessWidget {
  const HomeDashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.screen,
      AppSpacing.lg,
      AppSpacing.screen,
      AppSizes.homeBottomClearance,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppShimmerPlaceholder(height: 162, borderRadius: AppRadius.card),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: const [
            Expanded(
              child: AppShimmerPlaceholder(
                height: 116,
                borderRadius: AppRadius.card,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppShimmerPlaceholder(
                height: 116,
                borderRadius: AppRadius.card,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        const AppShimmerPlaceholder(height: 96, borderRadius: AppRadius.card),
        const SizedBox(height: AppSpacing.xl),
        for (var index = 0; index < 4; index++) ...[
          if (index > 0) const SizedBox(height: AppSpacing.sm),
          const AppShimmerPlaceholder(height: 76, borderRadius: AppRadius.card),
        ],
      ],
    ),
  );
}
