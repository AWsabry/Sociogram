import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider {
  final FirebaseAuth _auth;
  UserProvider(
    this._auth,
  );

  final GoogleSignIn googleSignIn = GoogleSignIn();
  User get user => _auth.currentUser!;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Status _status = Status.Uninitialized;
  Status get status => _status;

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController job = TextEditingController();

  double totalCartPrice = 0;
  late String title;
  DateTime date = DateTime.now();

  Future<DocumentSnapshot> getData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      await _auth
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.email)
            .set({
          'firstName': firstName.text,
          'lastName': lastName.text,
          'email': email.text,
          'password': password.text,
          'uid': value.user!.uid,
          'phoneNumber': phoneNumber.text,
          'city': city.text,
          'job': job.text,
          'onApp': false,
          'createdAt': DateTime.now()
        });
      });

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    await _auth.signOut();
    _status = Status.Unauthenticated;
  }

  Future googleSignOut() async {
    await googleSignIn.signOut();
    _status = Status.Unauthenticated;
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;
    final User? currentUser = _auth.currentUser;
    assert(user!.uid == currentUser!.uid);
    print('signInWithGoogle succeeded: $user');
    print(user);
    return true;
  }

  Future googleAddData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(googleSignIn.currentUser!.id)
        .set({
      'firstName': firstName.text,
      'lastName': lastName.text,
      'email': googleSignIn.currentUser!.email,
      'password': 'Google Login',
      'city': city.text,
      'uid': googleSignIn.currentUser!.id,
      'phoneNumber': phoneNumber.text,
    });
  }
}
