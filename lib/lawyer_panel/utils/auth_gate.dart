import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../user_panel/view/intro-view/intro_view1.dart';
import '../dashboard/dashboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Dashboard();
          } else {
            return const IntroView1();
          }
        },
      ),
    );
  }
}
