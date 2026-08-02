import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_ad_state.dart';

/// Holds the ad draft. Ads are never published directly — submitting queues
/// them for admin review, which is all [submit] models until an endpoint
/// exists.
class CreateAdCubit extends Cubit<CreateAdState> {
  CreateAdCubit() : super(const CreateAdState());

  void setTitle(String title) => emit(state.copyWith(title: title));

  void setDescription(String description) =>
      emit(state.copyWith(description: description));

  void setCover(String path) => emit(state.copyWith(coverPath: path));

  void submit() {
    if (state.canSubmit) emit(state.copyWith(submitted: true));
  }

  /// Clears the draft so another ad can be composed.
  void reset() => emit(const CreateAdState());
}
