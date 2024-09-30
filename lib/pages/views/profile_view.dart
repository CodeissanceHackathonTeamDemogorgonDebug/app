import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/6020722?v=4',
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'John Doe',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('AutofillHints.addressCity'),
        const SizedBox(height: 10),
    ],
    );
  }
}
