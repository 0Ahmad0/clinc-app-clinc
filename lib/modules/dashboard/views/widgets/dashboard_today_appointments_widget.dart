import 'package:clinc_app_clinc/app/extension/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardTodayAppointmentsWidget extends StatelessWidget {
  const DashboardTodayAppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // بيانات وهمية
    final appointments = [
      {
        'name': 'Liam Harper',
        'service': 'ECG',
        'time': '10:00 AM',
        'status': 'upcoming',
      },
      {
        'name': 'Liam Harper',
        'service': 'ECG',
        'time': '10:00 AM',
        'status': 'upcoming',
      },
      {
        'name': 'Liam Harper',
        'service': 'ECG',
        'time': '10:00 AM',
        'status': 'upcoming',
      },
      {
        'name': 'Liam Harper',
        'service': 'ECG',
        'time': '10:00 AM',
        'status': 'upcoming',
      },
      {
        'name': 'Olivia Bennett',
        'service': 'Blood Test',
        'time': '11:30 AM',
        'status': 'cancelled',
      },
      {
        'name': 'Noah Thompson',
        'service': 'Consultation',
        'time': '01:00 PM',
        'status': 'completed',
      },
    ];

    return SliverList.separated(
      itemCount: appointments.length,
      separatorBuilder: (_, __) => 12.verticalSpace,
      itemBuilder: (context, i) {
        final item = appointments[i];
        return _AppointmentCard(
          name: item['name']!,
          service: item['service']!,
          time: item['time']!,
          status: item['status']!,
        );
      },
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String name;
  final String service;
  final String time;
  final String status;

  const _AppointmentCard({
    required this.name,
    required this.service,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color statusColor;
    String statusText;
    switch (status) {
      case 'upcoming':
        statusColor = Colors.amber;
        statusText = "قادم";
        break;
      case 'cancelled':
        statusColor = Colors.redAccent;
        statusText = "ملغي";
        break;
      case 'completed':
        statusColor = Colors.green;
        statusText = "مكتمل";
        break;
      default:
        statusColor = Colors.grey;
        statusText = status;
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(14.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(
              name.characters.first,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.verticalSpace,
                Text(
                  service,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time.trNumbers(),
                style: theme.textTheme.bodySmall?.copyWith(),
              ),
              8.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  statusText,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
