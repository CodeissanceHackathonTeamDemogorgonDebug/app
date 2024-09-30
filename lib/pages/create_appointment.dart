import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/models/appointment_model.dart';
import 'package:hackathon_app/providers/appointment_provider.dart';
import 'package:hackathon_app/providers/doctor_search_provider.dart';

class CreateAppointment extends ConsumerWidget {
  final Doctor doctor;
   CreateAppointment({super.key, required this.doctor});
  final TextEditingController _reasonController = TextEditingController();
  DateTime date = DateTime.now();
  String appType = '';
  void selectedDate(DateTime date1) {
    print(date);
    date = date1;
  }

  void submitForm(WidgetRef ref){
    Appointment ap1 = Appointment(patientuid: FirebaseAuth.instance.currentUser!.uid, doctoruid: doctor.uid, date: date, isAccepted: false, appointmentType: appType);
    ref.read(requestAppointmentProvider(ap1));
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an appointment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Book an appointment', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 400,
                child: DatePicker(
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                  minDate: DateTime.now(),
                  maxDate: DateTime.now().add(const Duration(days: 30)),
                  onDateSelected: selectedDate,
                  disabledDayPredicate: (date) {
                    return date.weekday == 6 || date.weekday == 7;
                  },
                ),
              ),
              Text('Appointment type', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(child: Text('In person'), value: 'InPerson'),
                  DropdownMenuItem(child: Text('Online Consultation'), value: 'Online'),
                ],
                onChanged: (value) {
                  appType = value!;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              Text('Reason for appointment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                controller: _reasonController,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      submitForm(ref);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Book appointment'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
