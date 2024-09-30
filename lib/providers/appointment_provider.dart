import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<List<Appointment>> getAppointments() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await _firestore.collection('AppointmentRequest').where('patientuid', isEqualTo: user).get();
    return snapshot.docs.map((e) => Appointment.fromMap(e.data())).toList();
  }
}

final AppointmentDataSourceProvider = Provider<AppointmentDataSource>((ref) => AppointmentDataSource(ref.read(firebaseFirestoreProvider)));

final requestAppointmentProvider = FutureProvider.family<void, Appointment>((ref, appointment) async {
  final dataSource = ref.read(AppointmentDataSourceProvider);
  await dataSource.requestAppointment(appointment);
});

final appointmentsProvider = FutureProvider<List<Appointment>>((ref) async {
  final dataSource = ref.read(AppointmentDataSourceProvider);
  return dataSource.getAppointments();
});