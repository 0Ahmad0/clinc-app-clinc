import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/data/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onEdit;
  final VoidCallback onEditCover;
  final bool hasPendingUpdate;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onEdit,
    required this.onEditCover,
    this.hasPendingUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(18.r),
                  image: _imageProvider(profile.cover) == null
                      ? null
                      : DecorationImage(
                          image: _imageProvider(profile.cover)!,
                          fit: BoxFit.cover,
                        ),
                ),
                child: profile.cover == null
                    ? Icon(
                        Icons.image_outlined,
                        color: cs.onPrimaryContainer,
                        size: 34.sp,
                      )
                    : null,
              ),
              PositionedDirectional(
                end: 8.w,
                bottom: 8.h,
                child: IconButton.filled(
                  onPressed: onEditCover,
                  icon: const Icon(Icons.edit_outlined),
                ),
              ),
            ],
          ),
          12.verticalSpace,
          // Avatar and Edit Button
          Stack(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundColor: cs.primaryContainer,
                backgroundImage: _imageProvider(profile.avatar),
                child: profile.avatar == null
                    ? Text(
                        profile.name.isNotEmpty ? profile.name[0] : '?',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(50.r),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: cs.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: cs.shadow.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      color: cs.onPrimary,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          if (hasPendingUpdate) ...[
            Chip(
              avatar: const Icon(Icons.hourglass_top_outlined, size: 18),
              label: Text('settings.profile_update_pending'.tr()),
            ),
            10.verticalSpace,
          ],

          // Name and Clinic
          Text(
            profile.clinicName,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          8.verticalSpace,

          // Email and Phone
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email_outlined,
                size: 16.sp,
                color: cs.onSurfaceVariant,
              ),
              6.horizontalSpace,
              Text(
                profile.email,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              16.horizontalSpace,
              Icon(
                Icons.phone_outlined,
                size: 16.sp,
                color: cs.onSurfaceVariant,
              ),
              6.horizontalSpace,
              Text(
                profile.phone,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ImageProvider? _imageProvider(String? path) {
    if (path == null || path.isEmpty) return null;
    return path.startsWith('http')
        ? NetworkImage(path)
        : FileImage(File(path)) as ImageProvider;
  }
}
