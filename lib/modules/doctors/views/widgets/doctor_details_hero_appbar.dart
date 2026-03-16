import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/data/doctor_model.dart';
import '../../controllers/doctors_controller.dart';

class DoctorDetailsHeroAppBar extends GetView<DoctorsController> {
  final DoctorModel doctor;
  final Color specColor;
  final String initials;

  const DoctorDetailsHeroAppBar({
    super.key,
    required this.doctor,
    required this.specColor,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 260.h,
      pinned: true,
      backgroundColor: specColor,
      elevation: 0,
      leading: _CircleIconButton(
        icon: Icons.arrow_back_ios_new_rounded,
        onPressed: Get.back,
      ),
      actions: [
        _CircleIconButton(
          icon: Icons.edit_rounded,
          onPressed: () => Get.toNamed(AppRoutes.addDoctor, arguments: doctor),
        ),
        _CircleIconButton(
          icon: Icons.delete_rounded,
          bgColor: Colors.red.withValues(alpha: 0.3),
          onPressed: () => controller.showDeleteConfirm(doctor),
        ),
        8.horizontalSpace,
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _HeroBackground(
          doctor: doctor,
          specColor: specColor,
          initials: initials,
          theme: theme,
        ),
      ),
    );
  }
}

// ─── Circle Icon Button ───────────────────────────────────────────────────────

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? bgColor;
  const _CircleIconButton({required this.icon, required this.onPressed, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.white, size: 18),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

// ─── Hero Background ──────────────────────────────────────────────────────────

class _HeroBackground extends StatelessWidget {
  final DoctorModel doctor;
  final Color specColor;
  final String initials;
  final ThemeData theme;
  const _HeroBackground({required this.doctor, required this.specColor, required this.initials, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [specColor, specColor.withValues(alpha: 0.7)],
        ),
      ),
      child: Stack(
        children: [
          _DecorCircle(top: -40, right: -40, size: 180),
          _DecorCircle(bottom: -30, left: -30, size: 140),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  60.verticalSpace,
                  _AvatarCircle(initials: initials, theme: theme),
                  12.verticalSpace,
                  Text(
                    doctor.nameAr,
                    style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                  6.verticalSpace,
                  _SpecialtyPill(specialty: doctor.specialty, theme: theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorCircle extends StatelessWidget {
  final double? top, right, bottom, left, size;
  const _DecorCircle({this.top, this.right, this.bottom, this.left, this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, right: right, bottom: bottom, left: left,
      child: Container(
        width: size?.r, height: size?.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  final String initials;
  final ThemeData theme;
  const _AvatarCircle({required this.initials, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.r, height: 80.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.25),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 3),
      ),
      child: Center(
        child: Text(
          initials,
          style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class _SpecialtyPill extends StatelessWidget {
  final String specialty;
  final ThemeData theme;
  const _SpecialtyPill({required this.specialty, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
      ),
      child: Text(
        specialty,
        style: theme.textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}
