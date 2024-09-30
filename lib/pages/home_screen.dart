import 'package:flutter/material.dart';
import 'package:hackathon_app/pages/search_for_doctors.dart';
import 'package:hackathon_app/pages/views/appointments_view.dart';
import 'package:hackathon_app/pages/views/home_screen_view.dart';
import 'package:hackathon_app/pages/views/profile_view.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchForDoctors()));
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
      floatingActionButton: selectedPage == 1 ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ) : null,
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