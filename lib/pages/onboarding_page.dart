import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/main.dart';
import 'package:hackathon_app/models/patient_model.dart';
import 'package:hackathon_app/pages/home_screen.dart';
import 'package:hackathon_app/providers/patient_providers.dart';

class OnboardingPage extends ConsumerWidget {
   OnboardingPage({super.key});
  //text editing controllers
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emergencyContactController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  String gender = '';
  String bloodGroup = '';
  bool isSmoker = false;

  void submitForm(WidgetRef ref, BuildContext context) {
    //submit form
    Patient patient = Patient(
      uid: FirebaseAuth.instance.currentUser!.uid,
      name: FirebaseAuth.instance.currentUser!.displayName!,
      age: int.parse(ageController.text),
      userType: 'Patient',
    isSmoker: isSmoker,
    bloodGroup: bloodGroup,
      gender: gender,
      phoneNumber: int.parse(phoneNumberController.text),
      email: FirebaseAuth.instance.currentUser!.email!,
      allergies: allergiesController.text.split(','),
      medications: medicationsController.text.split(','),
      emergencyContact: int.parse(emergencyContactController.text),
      height: double.parse(heightController.text),
      weight: double.parse(weightController.text),
      fcmToken: fcmToken,
    );
    ref.read(addPatientProvider(patient));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to CareMate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //form to collect all fields of patient model
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
                controller: phoneNumberController,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter your age',
                  border: OutlineInputBorder(),
                ),
                controller: ageController,
              ),
              const SizedBox(height: 10),
              //dropdown for gender
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  hintText: 'Select your gender',
                  border: OutlineInputBorder(),
                ),
                  items: const [
                    DropdownMenuItem(value: 'Male', child: Text('Male')),
                    DropdownMenuItem(value: 'Female', child: Text('Female')),
                ],
                onChanged: (String? value) {
                  print(value);
                  gender = value!;
                },
              ),
              const SizedBox(height: 10),
              //dropdown for blood group
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Blood Group',
                  hintText: 'Select your blood group',
                  border: OutlineInputBorder(),
                ),
                  items: const [
                    DropdownMenuItem(child: Text('A+'), value: 'A+'),
                    DropdownMenuItem(child: Text('A-'), value: 'A-'),
                    DropdownMenuItem(child: Text('B+'), value: 'B+'),
                    DropdownMenuItem(child: Text('B-'), value: 'B-'),
                    DropdownMenuItem(child: Text('AB+'), value: 'AB+'),
                    DropdownMenuItem(child: Text('AB-'), value: 'AB-'),
                    DropdownMenuItem(child: Text('O+'), value: 'O+'),
                    DropdownMenuItem(child: Text('O-'), value: 'O-'),
            ],
                onChanged: (String? value) {
                  print(value);
                  bloodGroup = value!;
                },
              ),
              const SizedBox(height: 10),
              //checkbox for smoker
              Row(
                children: [
                  const Text('Are you a smoker?'),
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      print(value);
                      isSmoker = value!;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //textfield for height
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Height',
                  hintText: 'Enter your height',
                  border: OutlineInputBorder(),
                ),
                controller: heightController,
              ),
              const SizedBox(height: 10),
              //textfield for weight
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  hintText: 'Enter your weight',
                  border: OutlineInputBorder(),
                ),
                controller: weightController,
              ),
              const SizedBox(height: 10),
              //textfield for emergency contact
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact',
                  hintText: 'Enter your emergency contact',
                  border: OutlineInputBorder(),
                ),
                controller: emergencyContactController,
              ),
              const SizedBox(height: 10),
              //button to submit form
              ElevatedButton(
                onPressed: () {
                  //submit form
                  submitForm(ref, context);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      )
    );
  }
}
