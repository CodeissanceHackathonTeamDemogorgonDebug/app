import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/models/appointment_model.dart';
import 'package:hackathon_app/providers/doctor_search_provider.dart';

class AppointmentCard extends ConsumerWidget {
  final Appointment appointment;
  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctor = ref.watch(getDoctorByUidProvider(appointment.doctoruid)).value ?? Doctor(
      uid: '',
      name: '',
      address: '',
      experienceYears: '',
    );
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                doctor.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
               Text(doctor.address),
              const SizedBox(height: 10),
              Text(appointment.date.toIso8601String()),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
