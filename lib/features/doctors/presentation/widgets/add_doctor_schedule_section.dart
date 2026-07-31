import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/weekday.dart';
import '../cubit/add_doctor_cubit.dart';
import 'add_doctor_schedule_row.dart';
import '../../../../shared/widgets/app_section_card.dart';

/// Weekly schedule card: one toggleable row per weekday.
class AddDoctorScheduleSection extends StatelessWidget {
  const AddDoctorScheduleSection({super.key});

  Future<void> _pickTime(
    BuildContext context,
    AddDoctorCubit cubit,
    Weekday day, {
    required bool isStart,
  }) async {
    final current = cubit.state.hoursOf(day);
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? current.start : current.end,
    );
    if (picked == null) return;
    isStart ? cubit.setStart(day, picked) : cubit.setEnd(day, picked);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddDoctorCubit>();
    return AppSectionCard(
      icon: Iconsax.clock,
      tint: context.colors.successFg,
      title: context.l10n.addDoctorScheduleSection,
      child: BlocBuilder<AddDoctorCubit, AddDoctorState>(
        builder: (context, state) => Column(
          children: [
            for (final day in Weekday.values) ...[
              AddDoctorScheduleRow(
                day: day,
                active: state.isActive(day),
                hours: state.hoursOf(day),
                endErrorText:
                    state.showScheduleValidation && state.hasInvalidHours(day)
                    ? _timeRangeErrorText(context)
                    : null,
                onToggle: () => cubit.toggleDay(day),
                onPickStart: () =>
                    _pickTime(context, cubit, day, isStart: true),
                onPickEnd: () => _pickTime(context, cubit, day, isStart: false),
              ),
              if (day != Weekday.values.last) AppGaps.h12,
            ],
          ],
        ),
      ),
    );
  }

  String _timeRangeErrorText(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'ar') {
      return 'وقت الانتهاء يجب أن يكون بعد وقت البدء';
    }
    return 'End time must be after start time';
  }
}
