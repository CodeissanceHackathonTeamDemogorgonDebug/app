import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/pages/widgets/doctor_card.dart';
import 'package:hackathon_app/providers/doctor_search_provider.dart';

class SearchForDoctors extends ConsumerStatefulWidget {
   SearchForDoctors({super.key});

  @override
  ConsumerState<SearchForDoctors> createState() => _SearchForDoctorsState();
}

class _SearchForDoctorsState extends ConsumerState<SearchForDoctors> {
  List<Doctor> searchItems = [];

  void search(String query, WidgetRef ref) {
    ref.watch(doctorSearchProvider(query)).when(
      data: (doctors) {
        print(doctors);
        searchItems = doctors;
      },
      loading: () {
      },
      error: (error, stack) {
        print(error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(searchItems);
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
              // Text('Search for doctors', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              //search filters
              //dropdown to sort by experience, rating, specialty
              const DropdownMenu(
                label: Text('Sort by'),
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 'experience', label: 'Experience'),
                  DropdownMenuEntry(value: 'rating', label: 'Rating'),
                  DropdownMenuEntry(value: 'specialty', label:'Specialty'),
                  DropdownMenuEntry(value: 'price', label:'Price'),
                ]
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Doctor name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    search(value, ref);
                  });
                },
              ),
              const Divider(),
              // const SizedBox(height: 20),
              //search results
              ListView.builder(
                shrinkWrap: true,
                itemCount: searchItems.length,
                itemBuilder: (context, index) {
                  return DoctorCard(doctor: searchItems[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
