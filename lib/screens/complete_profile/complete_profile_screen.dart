import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/users.dart';

import '../../loading.dart';
import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  final TextEditingController? email;
  final TextEditingController? password;
  final String? uid;

  CompleteProfileScreen({
    this.uid,
    this.email,
    this.password,
  });
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: authProvider.status == Status.Authenticating
            ? Loading()
            : Body(email: email, password: password));
  }
}
