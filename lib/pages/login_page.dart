import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/pages/home_screen.dart';
import 'package:hackathon_app/pages/onboarding_page.dart';
import 'package:hackathon_app/providers/auth_provider.dart';
import 'package:hackathon_app/providers/patient_providers.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Loginpage extends ConsumerWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
                Buttons.googleDark,
              onPressed: () async {
                // Trigger the sign-in process and await its completion
                await ref.read(authNotifierProvider.notifier).continueWithGoogle();

                // Access the current authentication state to determine the outcome
                final authState = ref.read(authNotifierProvider);
                authState.maybeWhen(
                  authenticated: (user) {
                    // Navigate to home page if successfully authenticated
                    if (!ref.watch(patientProvider(user.uid)).hasValue) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OnboardingPage(),
                        ),
                      );
                    }
                    else{
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  orElse: () {
                    // Optionally handle other states or show an error message
                  },
                );
              },)
          ],
        ),
      ),
    );
  }
}
