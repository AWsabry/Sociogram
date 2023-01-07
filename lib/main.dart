import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:getting_contacts_app/providers/Auth_Wrapper.dart';
import 'package:getting_contacts_app/providers/app.dart';
import 'package:getting_contacts_app/providers/users.dart';
import 'package:getting_contacts_app/routes.dart';
import 'package:getting_contacts_app/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserProvider>(
          create: (_) => UserProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<UserProvider>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider.value(value: AppProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sociogram',
        theme: theme(),
        // home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        home: const AuthenticationWrapper(),
        routes: routes,
      ),
    );
  }
}
