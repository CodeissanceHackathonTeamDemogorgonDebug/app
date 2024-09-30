import 'package:flutter/material.dart';
import 'package:hackathon_app/pages/widgets/doctor_card.dart';

class SearchForDoctors extends StatelessWidget {
  const SearchForDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for doctors'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Search for doctors', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Search for doctors',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const Divider(),
              // const SizedBox(height: 20),
              DoctorCard(),
              DoctorCard(),
              DoctorCard(),
              DoctorCard(),
              DoctorCard(),
              DoctorCard(),
            ],
          ),
        ),
      ),
    );
  }
}
