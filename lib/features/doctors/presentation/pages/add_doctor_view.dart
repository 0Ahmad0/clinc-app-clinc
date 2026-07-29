import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../../core/media/media_service.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/input/email_input.dart';
import '../../../../shared/widgets/media_source_sheet.dart';
import '../cubit/add_doctor_cubit.dart';
import '../widgets/add_doctor_basic_section.dart';
import '../widgets/add_doctor_header.dart';
import '../widgets/add_doctor_professional_section.dart';
import '../widgets/add_doctor_qualifications_section.dart';
import '../widgets/add_doctor_save_bar.dart';
import '../widgets/add_doctor_schedule_section.dart';

class AddDoctorView extends StatefulWidget {
  const AddDoctorView({super.key});

  @override
  State<AddDoctorView> createState() => _AddDoctorViewState();
}

class _AddDoctorViewState extends State<AddDoctorView> {
  late final TextEditingController _nameArController;
  late final TextEditingController _nameEnController;
  late final TextEditingController _feeController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _licenseController;
  late final TextEditingController _experienceController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final doctor = context.read<AddDoctorCubit>().state.initialDoctor;
    _nameArController = TextEditingController(text: doctor?.nameAr ?? '');
    _nameEnController = TextEditingController(text: doctor?.nameEn ?? '');
    _feeController = TextEditingController(
      text: doctor?.consultationFee.toString() ?? '',
    );
    _phoneController = TextEditingController(text: doctor?.phone ?? '');
    _emailController = TextEditingController(
      text: normalizeEmailInput(doctor?.email ?? ''),
    );
    _licenseController = TextEditingController(
      text: doctor?.licenseNumber ?? '',
    );
    _experienceController = TextEditingController(
      text: doctor?.experienceYears.toString() ?? '',
    );
    _bioController = TextEditingController(text: doctor?.bio ?? '');
  }

  @override
  void dispose() {
    _nameArController.dispose();
    _nameEnController.dispose();
    _feeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _licenseController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocListener<AddDoctorCubit, AddDoctorState>(
    listenWhen: (previous, current) =>
        previous.saved != current.saved || previous.failure != current.failure,
    listener: (context, state) {
      if (state.saved) {
        context.pop(state.savedDoctor);
      }
      final failure = state.failure;
      if (failure != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(NetworkExceptions.getErrorMessage(failure))),
        );
      }
    },
    child: Scaffold(
      backgroundColor: context.colors.bg,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsetsDirectional.only(
              bottom: AppSizes.homeBottomClearance,
            ),
            children: [
              AddDoctorHeader(
                onPickImage: _pickImage,
                onRemoveImage: () =>
                    context.read<AddDoctorCubit>().removeImage(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.screen,
                  AppSpacing.md + 2,
                  AppSpacing.screen,
                  0,
                ),
                child: Column(
                  children: [
                    AddDoctorBasicSection(
                      nameArController: _nameArController,
                      nameEnController: _nameEnController,
                      feeController: _feeController,
                      phoneController: _phoneController,
                      emailController: _emailController,
                    ),
                    AppGaps.h16,
                    AddDoctorProfessionalSection(
                      licenseController: _licenseController,
                      experienceController: _experienceController,
                      bioController: _bioController,
                    ),
                    AppGaps.h16,
                    AddDoctorQualificationsSection(onPickPdf: _pickPdf),
                    AppGaps.h16,
                    const AddDoctorScheduleSection(),
                  ],
                ),
              ),
            ],
          ),
          PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 0,
            child: AddDoctorSaveBar(onSave: _save),
          ),
        ],
      ),
    ),
  );

  void _save() {
    context.read<AddDoctorCubit>().save(
      nameAr: _nameArController.text,
      nameEn: _nameEnController.text,
      phone: _phoneController.text,
      email: normalizeEmailInput(_emailController.text),
      licenseNumber: _licenseController.text,
      experienceYears: _experienceController.text,
      consultationFee: _feeController.text,
      bio: _bioController.text,
    );
  }

  Future<void> _pickImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const MediaSourceSheet(),
    );
    if (source == null) return;
    final path = await sl<MediaService>().pickImage(source);
    if (path == null || !mounted) return;
    context.read<AddDoctorCubit>().setImage(path);
  }

  Future<void> _pickPdf() async {
    final file = await sl<MediaService>().pickPdf();
    if (file == null || !mounted) return;
    context.read<AddDoctorCubit>().addQualificationFile(
      path: file.path,
      name: file.name,
    );
  }
}
