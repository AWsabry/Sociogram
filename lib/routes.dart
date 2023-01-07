import 'package:flutter/material.dart';
import 'package:getting_contacts_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:getting_contacts_app/screens/sign_in/sign_in_screen.dart';
import 'package:getting_contacts_app/screens/splash/splash_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';
import './providers/Auth_Wrapper.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  AuthenticationWrapper.routeName: (context) => AuthenticationWrapper(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  // LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
};
