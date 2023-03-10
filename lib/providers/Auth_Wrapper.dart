import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getting_contacts_app/screens/home/home.dart';
import 'package:provider/provider.dart';
import '../screens/splash/splash_screen.dart';

class AuthenticationWrapper extends StatefulWidget {
  static String routeName = "/AuthWrapper";

  const AuthenticationWrapper({
    Key? key,
  }) : super(key: key);
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomeScreen();
    }
    return SplashScreen();
  }
}
