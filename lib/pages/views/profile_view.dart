import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/models/patient_model.dart';
import 'package:hackathon_app/pages/login_page.dart';
import 'package:hackathon_app/providers/auth_provider.dart';
import 'package:hackathon_app/providers/patient_providers.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(patientProvider(FirebaseAuth.instance.currentUser!.uid)).when(
      data: (patient) {
        if (patient == null) {
          return const Center(child: Text('No patient data available'));
        }
        return _buildProfileView(context, patient, ref);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildProfileView(BuildContext context, Patient patient, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: patient.profilePic != null
                  ? NetworkImage(patient.profilePic!)
                  : const NetworkImage('https://via.placeholder.com/150'),
            ),
            const SizedBox(height: 16),
            // User Information
            Text(
              patient.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            _buildCard(child: Text(
              'Age: ${patient.age}',
              style: const TextStyle(fontSize: 16),
            )),
            _buildCard(child: Text(
              'Gender: ${patient.gender}',
              style: const TextStyle(fontSize: 16),
            )),
            _buildCard(child: Text(
              'Phone: ${patient.phoneNumber}',
              style: const TextStyle(fontSize: 16),
            )),
            _buildCard(child: Text(
              'Email: ${patient.email}',
              style: const TextStyle(fontSize: 16),
            )),
            if (patient.bloodGroup != null) _buildCard(child: Text(
              'Blood Group: ${patient.bloodGroup}',
              style: const TextStyle(fontSize: 16),
            )),
            _buildCard(child: Text(
              'Height: ${patient.height.toStringAsFixed(2)} cm',
              style: const TextStyle(fontSize: 16),
            )),
            _buildCard(child: Text(
              'Weight: ${patient.weight.toStringAsFixed(2)} kg',
              style: const TextStyle(fontSize: 16),
            )),
            _buildCard(child: Text(
              'Smoker: ${patient.isSmoker ? "Yes" : "No"}',
              style: const TextStyle(fontSize: 16),
            )),
            // Emergency Contact
            if (patient.emergencyContact != null) _buildCard(child: Text(
              'Emergency Contact: ${patient.emergencyContact}',
              style: const TextStyle(fontSize: 16),
            )),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //log9out button
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Loginpage()));
                  },
                  child: const Text('Logout'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: child,
        ),
      ),
    );
  }
}