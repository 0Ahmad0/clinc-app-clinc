import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/remote/api_response.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../domain/clinic_ads_repository.dart';
import 'create_ad_state.dart';

/// Holds the ad draft. Ads are submitted to the admin review queue.
class CreateAdCubit extends Cubit<CreateAdState> {
  CreateAdCubit(this._repository) : super(const CreateAdState());

  final ClinicAdsRepository _repository;

  void setTitleAr(String title) => emit(state.copyWith(titleAr: title));

  void setTitleEn(String title) => emit(state.copyWith(titleEn: title));

  void setDescriptionAr(String description) =>
      emit(state.copyWith(descriptionAr: description));

  void setDescriptionEn(String description) =>
      emit(state.copyWith(descriptionEn: description));

  void setCover(String path) => emit(state.copyWith(coverPath: path));

  Future<void> submit() async {
    if (!state.canSubmit || state.coverPath == null) return;
    emit(state.copyWith(isSubmitting: true, errorMessage: ''));
    final result = await _repository.createAd(
      titleAr: state.titleAr.trim(),
      titleEn: state.titleEn.trim(),
      descriptionAr: state.descriptionAr.trim(),
      descriptionEn: state.descriptionEn.trim(),
      coverPath: state.coverPath!,
    );
    result.when(
      success: (_) => emit(
        state.copyWith(isSubmitting: false, submitted: true, errorMessage: ''),
      ),
      failure: (exception) => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: NetworkExceptions.getErrorMessage(exception),
        ),
      ),
    );
  }

  /// Clears the draft so another ad can be composed.
  void reset() => emit(const CreateAdState());
}
