import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/models/appointment_model.dart';
import 'package:hackathon_app/providers/auth_provider.dart';

class AppointmentDataSource {
  final FirebaseFirestore _firestore;
  AppointmentDataSource(this._firestore);
  Future<void> requestAppointment(Appointment appointment) async {
    //add to AppointmentRequest/random docname
    await _firestore.collection('AppointmentRequest').add(appointment.toMap());
  }
}

final AppointmentDataSourceProvider = Provider<AppointmentDataSource>((ref) => AppointmentDataSource(ref.read(firebaseFirestoreProvider)));

final requestAppointmentProvider = FutureProvider.family<void, Appointment>((ref, appointment) async {
  final dataSource = ref.read(AppointmentDataSourceProvider);
  await dataSource.requestAppointment(appointment);
});