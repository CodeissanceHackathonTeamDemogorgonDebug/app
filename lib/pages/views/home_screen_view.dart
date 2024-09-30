import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/providers/patient_providers.dart';
import 'package:hackathon_app/providers/steps_provider.dart';

class HomeScreenView extends ConsumerWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome to CareMate',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your medications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Text('Aspirin', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Text('Paracetamol', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Text('RadAway', style: TextStyle(fontSize: 16)),
              ],
            ),
            //card to show total steps
            SizedBox(
              child: ref.watch(stepCountProvider).when(data: (data){
                setSteps(data.steps);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text('Total steps taken today', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 20),
                        Text(data.steps.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        LinearProgressIndicator(
                          value: data.steps / 20000,
                        ),
                        const SizedBox(height: 10,),
                        Text('Target: 20000')
                      ],
                    ),
                  ),
                );
              }, error: (error, stack){
                return Text(error.toString());
              }, loading: (){
                return const LinearProgressIndicator();
              }),
            ),

            SizedBox(
              width: double.infinity,
              child: ref.watch(pedestrianStatusProvider).when(data: (data){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text('Status', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 20),
                        Text(data.status.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              }, error: (error, stack){
                return Text(error.toString());
              }, loading: (){
                return const LinearProgressIndicator();
              }),
            ),
            //card with heart rate
            const SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Heart Rate', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 20),
                      Text('80', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            //card with blood pressure
            const SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Blood Pressure', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 20),
                      Text('120/80', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            //spo2
            const SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('SpO2', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 20),
                      Text('98', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
