import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_header.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/pending_actions_card.dart';
import 'widgets/pending_header_badge.dart';
import 'widgets/pending_logout_btn.dart';
import 'widgets/pending_status_card.dart';
import 'widgets/pending_steps_card.dart';

/// Root shell — pure layout, zero logic.
class PendingApprovalView extends StatelessWidget {
  const PendingApprovalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: AppGradientHeader(
              gradient: AppGradients.amber,
              icon: Icons.access_time_rounded,
              iconCircleSize: 90,
              iconSize: 50,
              bottomRadius: 40,
              title: tr(LocaleKeys.pending_approval_title),
              subtitle: tr(LocaleKeys.pending_approval_subtitle),
              trailing: const PendingLogoutBtn(),
              badge: const PendingHeaderBadge(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                28.verticalSpace,
                const PendingStatusCard(),
                20.verticalSpace,
                const PendingStepsCard(),
                20.verticalSpace,
                const PendingActionsCard(),
                32.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
