// Provider to search doctors based on name, specialties, or address
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';

final doctorSearchProvider = FutureProvider.family<List<Doctor>, String>((ref, searchTerm) async {
  final firestore = ref.watch(firebaseFirestoreProvider);

  // Convert the search term to lowercase to ensure a case-insensitive search
  final term = searchTerm;

  // Query Firestore to find doctors based on name, specialties, or address
  final querySnapshot = await firestore.collection('Caretakers')
      .where('name', isGreaterThanOrEqualTo: term)
      .get();
  print(querySnapshot.docs.length);

  // Map the results to a list of Doctor models
  final doctors = querySnapshot.docs.map((doc) => Doctor.fromMap(doc.data())).toList();
  print(doctors);

  final querySnapshot2 = await firestore.collection('Caretakers')
      .where('specialties', isGreaterThanOrEqualTo: term) // You can add an array of keywords to each doctor document for optimized search
      .get();
  //append to doctors
  doctors.addAll(querySnapshot2.docs.map((doc) => Doctor.fromMap(doc.data())).toList());

  final querySnapshot3 = await firestore.collection('Caretakers')
      .where('address', isGreaterThanOrEqualTo: term) // You can add an array of keywords to each doctor document for optimized search
      .get();
  //append to doctors
  doctors.addAll(querySnapshot3.docs.map((doc) => Doctor.fromMap(doc.data())).toList());
  print(doctors.length);
  return doctors;
});

final getDoctorByUidProvider = FutureProvider.family<Doctor, String>((ref, uid) async {
  final firestore = ref.watch(firebaseFirestoreProvider);

  final querySnapshot = await firestore.collection('Caretakers')
      .where('uid', isEqualTo: uid)
      .get();

  final doctor = querySnapshot.docs.map((doc) => Doctor.fromMap(doc.data())).first;
  return doctor;
});

// Doctor model
class Doctor {
  final String uid;
  final String name;
  // final List<dynamic>? specialties;
  final String address;
  final String? profilePic;
  final String experienceYears;

  Doctor({
    required this.uid,
    required this.name,
    // this.specialties,
    required this.address,
    this.profilePic,
    required this.experienceYears,
  });

  // Method to create a Doctor instance from a Firestore document
  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      // specialties: map['specialties'] ?? '',
      address: map['address'] ?? '',
      profilePic: map['profilePic'],
      experienceYears: map['experienceYears'] ?? 0,
    );
  }
}