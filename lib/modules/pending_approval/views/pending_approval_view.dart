import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/core/widgets/app_app_bar_widget.dart';
import '../../../app/core/widgets/app_padding_widget.dart';
import '../../../app/core/widgets/app_scaffold_widget.dart';
import '../controllers/pending_approval_controller.dart';
import 'widgets/pending_actions_widget.dart';
import 'widgets/pending_illustration_widget.dart';
import 'widgets/pending_info_widget.dart';

class PendingApprovalView extends GetView<PendingApprovalController> {
  const PendingApprovalView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppAppBarWidget(
        title: '',
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PendingIllustrationWidget(),
              40.verticalSpace,
              const PendingInfoWidget(),
              48.verticalSpace,
              const PendingActionsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
