import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // استقبال الـ ID (مثال)
    // final id = Get.arguments;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Dr. Ethan Carter"),
              background: Container(
                color: colorScheme.primaryContainer,
                child: Center(
                  child: Icon(Icons.person, size: 80.sp, color: colorScheme.onPrimaryContainer),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  "Specialty: Cardiology",
                  style: theme.textTheme.titleMedium,
                ),
                20.verticalSpace,
                Text(
                  "About Doctor...",
                  style: theme.textTheme.bodyLarge,
                ),
                // باقي التفاصيل...
              ]),
            ),
          )
        ],
      ),
    );
  }
}