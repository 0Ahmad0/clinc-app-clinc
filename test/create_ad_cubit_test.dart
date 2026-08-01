import 'package:clinic_app/features/ads/presentation/cubit/create_ad_cubit.dart';
import 'package:clinic_app/features/ads/presentation/cubit/create_ad_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an ad needs a title and a description before it can be submitted', () {
    final cubit = CreateAdCubit();

    cubit.setTitle('   ');
    cubit.setDescription('offer details');
    cubit.submit();
    expect(cubit.state.submitted, isFalse);

    cubit.setTitle('20% off');
    cubit.submit();
    expect(cubit.state.submitted, isTrue);

    cubit.reset();
    expect(cubit.state, const CreateAdState());
    cubit.close();
  });
}
