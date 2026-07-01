import 'package:clinc_app_clinc/modules/add_doctor/data/add_doctor_mock_data_source.dart';
import 'package:clinc_app_clinc/modules/add_doctor/models/add_doctor_model.dart';
import 'package:clinc_app_clinc/modules/doctors/data/doctors_mock_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'add, details, edit, and list refresh share the same doctor state',
    () async {
      final addDataSource = AddDoctorMockDataSource();
      final doctorsDataSource = DoctorsMockDataSource();
      const initialRequest = AddDoctorRequest(
        nameAr: 'د. اختبار',
        nameEn: 'Dr. Test',
        specializationId: 1,
        consultationFee: 100,
        licenseNumber: 'TEST-001',
        experienceYears: 3,
        biography: 'Initial biography',
        phone: '+963900000000',
        email: 'doctor@example.com',
        isAvailable: true,
        schedule: [
          DoctorScheduleRequest(
            day: 'saturday',
            isActive: true,
            from: '09:00',
            to: '17:00',
          ),
        ],
      );

      final added = await addDataSource.addDoctor(initialRequest);
      final id = added.result!.doctorId;
      final details = await doctorsDataSource.getDoctor(id);

      expect(details.result?.licenseNumber, 'TEST-001');
      expect(details.result?.biography, 'Initial biography');

      const updatedRequest = AddDoctorRequest(
        nameAr: 'د. اختبار محدث',
        nameEn: 'Dr. Test Updated',
        specializationId: 7,
        consultationFee: 150,
        licenseNumber: 'TEST-001',
        experienceYears: 4,
        biography: 'Updated biography',
        phone: '+963911111111',
        email: 'updated@example.com',
        isAvailable: false,
        schedule: [DoctorScheduleRequest(day: 'saturday', isActive: false)],
      );
      await addDataSource.updateDoctor(id, updatedRequest);

      final refreshed = await doctorsDataSource.getDoctors();
      final updated = refreshed.data!.doctors.firstWhere(
        (doctor) => doctor.doctorId == id,
      );
      final updatedDetails = await doctorsDataSource.getDoctor(id);

      expect(updated.nameEn, 'Dr. Test Updated');
      expect(updated.consultationFee, 150);
      expect(updated.isAvailable, isFalse);
      expect(updatedDetails.result?.biography, 'Updated biography');
      expect(updatedDetails.result?.specialization.id, 7);
    },
  );
}
