import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/models/patient_model.dart';
import 'package:hackathon_app/pages/search_for_doctors.dart';
import 'package:hackathon_app/pages/views/appointments_view.dart';
import 'package:hackathon_app/pages/views/home_screen_view.dart';
import 'package:hackathon_app/pages/views/profile_view.dart';
import 'package:hackathon_app/providers/patient_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
   const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(getAppBarTitle(selectedPage)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  SearchForDoctors()));
            },
          ),
        ],
      ),
      body: SizedBox(
          width: double.infinity,
          child: getPage(selectedPage)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Appointments'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        //emergency contact button
        child: Icon(Icons.add_call),
        onPressed: () {
          showDialog(context: context, builder: (context) {
            final TextEditingController t1 = TextEditingController();
            return AlertDialog(
              title: Text('Log an emergency'),
              actions: [
                //optional field to explain what is wrong
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Explain what is wrong',
                    border: OutlineInputBorder(),
                  ),
                  controller: t1,
                ),
                TextButton(
                  onPressed: () {
                    ref.read(patientProvider(FirebaseAuth.instance.currentUser!.uid)).whenData((value) {
                      FirebaseFirestore.instance.collection('emergency').add({
                        'time': DateTime.now(),
                        'uid': value!.uid,
                        'contact': value!.emergencyContact ?? '',
                        'message': t1.text
                      });
                      Navigator.of(context).pop();
                    });

                  },
                  child: Text('Submit'),
                ),
              ],
            );
          });
        }
      )
    );
  }
}

String getAppBarTitle(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Appointments';
    case 2:
      return 'Profile';
    default:
      return 'CareMate';
  }
}

Widget getPage(int index) {
  switch (index) {
    case 0:
      return const HomeScreenView();
    case 1:
      return const AppointmentsView();
    case 2:
      return const ProfileView();
    default:
      return const HomeScreenView();
  }
}