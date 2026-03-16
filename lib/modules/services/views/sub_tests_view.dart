import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../models/main_lab_category_model.dart';
import 'widgets/sub_test_app_bar.dart';
import 'widgets/sub_test_item.dart';

/// Detail screen listing all sub-tests for a selected lab category.
class SubTestsView extends StatelessWidget {
  final MainLabCategoryModel category;

  const SubTestsView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [SubTestAppBar(category: category)],
        body: ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
          itemCount: category.subTests.length,
          separatorBuilder: (_, __) => 12.verticalSpace,
          itemBuilder: (_, i) => SubTestItem(
            test: category.subTests[i],
            accentColor: category.color,
          ),
        ),
      ),
    );
  }
}
