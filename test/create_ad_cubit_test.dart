import 'package:clinic_app/core/data/base_model.dart';
import 'package:clinic_app/core/data/remote/api_response.dart';
import 'package:clinic_app/features/ads/domain/clinic_ads_repository.dart';
import 'package:clinic_app/features/ads/presentation/cubit/create_ad_cubit.dart';
import 'package:clinic_app/features/ads/presentation/cubit/create_ad_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an ad needs localized fields and cover before submit', () async {
    final repository = _FakeClinicAdsRepository();
    final cubit = CreateAdCubit(repository);

    cubit.setTitleAr('   ');
    cubit.setTitleEn('20% off');
    cubit.setDescriptionAr('تفاصيل العرض');
    cubit.setDescriptionEn('offer details');
    await cubit.submit();
    expect(cubit.state.submitted, isFalse);
    expect(repository.createCalls, 0);

    cubit.setTitleAr('خصم ٢٠٪');
    cubit.setCover('/tmp/ad-cover.png');
    await cubit.submit();
    expect(cubit.state.submitted, isTrue);
    expect(repository.createCalls, 1);

    cubit.reset();
    expect(cubit.state, const CreateAdState());
    cubit.close();
  });
}

class _FakeClinicAdsRepository implements ClinicAdsRepository {
  int createCalls = 0;

  @override
  Future<ApiResponse<BaseModel<Map<String, dynamic>>>> createAd({
    required String titleAr,
    required String titleEn,
    required String descriptionAr,
    required String descriptionEn,
    required String coverPath,
  }) async {
    createCalls++;
    return ApiResponse.success(BaseModel(result: {'status': 'pending'}));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
