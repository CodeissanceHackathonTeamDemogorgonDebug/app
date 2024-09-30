import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/models/appointment_model.dart';
import 'package:hackathon_app/pages/widgets/appointment_card.dart';
import 'package:hackathon_app/providers/appointment_provider.dart';

class AppointmentsView extends ConsumerWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Appointment> appointments = ref.watch(appointmentsProvider).value ?? [];
    print(appointments);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // const Text(
            //   'Appointments',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Upcoming appointments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            if (appointments.isEmpty)
              const Text('No appointments yet')
            else
              Column(
                children: appointments.map((appointment) => AppointmentCard(appointment: appointment)).toList(),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.access_time),
              label: const Text('Book an appointment'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
