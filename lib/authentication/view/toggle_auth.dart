import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimo/authentication/view/login_screen.dart';

import 'package:mimo/features/home/view/home_screen.dart';

class ToggleAuth extends StatelessWidget {
  const ToggleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return user == null ? LoginScreen() : const HomeScreen();
  }
}
