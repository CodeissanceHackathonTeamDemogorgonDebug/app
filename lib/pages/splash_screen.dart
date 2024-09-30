import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/pages/home_screen.dart';
import 'package:hackathon_app/pages/login_page.dart';
import 'package:hackathon_app/providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider);
    user.when(
      unauthenticated: (message) {
        print(message);
        Future.microtask(() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Loginpage(),
            ),
          );
        });
      },
      authenticated: (user) {
        Future.microtask(() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        });
      },
      initial: () {
        print('initial');
        // Future.microtask(() {
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (context) => const Loginpage(),
        //     ),
        //   );
        // });
      }, loading: () {  },
    );

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
