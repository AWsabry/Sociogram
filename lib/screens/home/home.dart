import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:getting_contacts_app/components/coustom_bottom_nav_bar.dart';
import 'package:getting_contacts_app/enums.dart';
import 'package:getting_contacts_app/screens/home/components/search_field.dart';
import 'package:getting_contacts_app/screens/splash/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String routeName = "/home";
  List<Contact>? contacts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }

  void uploadingContacts() async {
    User user = FirebaseAuth.instance.currentUser!;

    for (var i = 0; i < contacts!.length; i++) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .collection("Contacts")
          .doc(contacts![i].name.first + " " + contacts![i].name.last)
          .set({
        'FirstName': contacts![i].name.first,
        'LastName': contacts![i].name.last,
        'PhoneNumber': contacts![i].phones.first.number,
        'onApp': false
      });
    }
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      print(contacts);
      uploadingContacts();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SplashScreen(),
                        ),
                      );
                    },
                    child: Text("Logout"))
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Sociology",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: (contacts) == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contacts!.length,
              itemBuilder: (BuildContext context, int index) {
                Uint8List? image = contacts![index].photo;
                String num = (contacts![index].phones.isNotEmpty)
                    ? (contacts![index].phones.first.number)
                    : "--";
                return ListTile(
                    leading: (contacts![index].photo == null)
                        ? const CircleAvatar(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.black,
                          )
                        : CircleAvatar(backgroundImage: MemoryImage(image!)),
                    title: Text(
                        "${contacts![index].name.first} ${contacts![index].name.last}"),
                    subtitle: Text(num),
                    onTap: () {});
              },
            ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
