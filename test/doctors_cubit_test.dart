import 'package:clinic_app/features/doctors/domain/doctor_specialty.dart';
import 'package:clinic_app/features/doctors/domain/doctor_summary.dart';
import 'package:clinic_app/features/doctors/presentation/cubit/doctors_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('doctors filter, search, and availability are functional', () {
    final cubit = DoctorsCubit();
    const doctors = [
      DoctorSummary(
        id: 0,
        name: 'Doctor One',
        initials: 'DO',
        specialty: DoctorSpecialty.cardiology,
        specialtyName: 'Cardiology',
        experienceYears: 12,
        fee: 150,
      ),
      DoctorSummary(
        id: 1,
        name: 'Doctor Two',
        initials: 'DT',
        specialty: DoctorSpecialty.dermatology,
        specialtyName: 'Dermatology',
        experienceYears: 7,
        fee: 200,
      ),
    ];

    cubit.selectSpecialty(DoctorSpecialty.cardiology);
    expect(cubit.visibleDoctors(doctors), [doctors.first]);

    cubit.selectSpecialty(DoctorSpecialty.all);
    cubit.search('derma');
    expect(cubit.visibleDoctors(doctors), [doctors.last]);

    cubit.toggleAvailability(0);
    expect(cubit.state.availability.first, isFalse);
    cubit.close();
  });
}
