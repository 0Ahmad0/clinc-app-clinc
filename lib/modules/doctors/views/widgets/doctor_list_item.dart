import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';

class DoctorListItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const DoctorListItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isActive = item['isActive'] as bool;

    // ألوان الحالة (يمكن وضعها في الثيم كـ Extension، لكن هنا للسرعة)
    final statusColor = isActive ? const Color(0xFF00C853) : const Color(0xFFD32F2F);
    final statusText = isActive
        ? tr(LocaleKeys.doctors_page_status_active)
        : tr(LocaleKeys.doctors_page_status_inactive);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface, // لون الكارت (أبيض عادة)
        borderRadius: BorderRadius.circular(16.r),
        // ظل خفيف جداً وأنعم من الصورة ليكون modern
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // 1. الأفاتار (إضافة جمالية عن الصورة الأصلية)
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    (item['name'] as String)[4], // الحرف الأول من الاسم بعد Dr.
                    style: TextStyle(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                16.horizontalSpace,

                // 2. المعلومات
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        item['specialty'],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant, // رمادي
                        ),
                      ),
                      8.verticalSpace,

                      // 3. الحالة (نقطة + نص)
                      Row(
                        children: [
                          Container(
                            width: 8.r,
                            height: 8.r,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          6.horizontalSpace,
                          Text(
                            statusText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 4. زر القائمة (3 نقاط)
                IconButton(
                  onPressed: () {
                    // فتح BottomSheet للتعديل أو الحذف
                  },
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}