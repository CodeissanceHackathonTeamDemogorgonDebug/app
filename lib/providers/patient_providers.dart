import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/models/patient_model.dart';

class FirestoreDataSource {
  final FirebaseFirestore _firestore;

  FirestoreDataSource(this._firestore);

  Future<void> addPatient(Patient patient) async {
    await _firestore.collection('Patients').doc(patient.uid).set(patient.toJson());
  }

  Future<Patient?> getPatient(String uid) async {
    final doc = await _firestore.collection('Patients').doc(uid).get();
    if (doc.exists) {
      return Patient.fromJson(doc.data()!);
    }
    return null;
  }
}

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firestoreDataSourceProvider = Provider<FirestoreDataSource>(
      (ref) => FirestoreDataSource(ref.read(firebaseFirestoreProvider)),
);

final addPatientProvider = FutureProvider.family<void, Patient>((ref, patient) async {
  final dataSource = ref.read(firestoreDataSourceProvider);
  await dataSource.addPatient(patient);
});

final patientProvider = FutureProvider.family<Patient?, String>((ref, uid) async {
  final dataSource = ref.read(firestoreDataSourceProvider);
  return await dataSource.getPatient(uid);
});
