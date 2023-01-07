import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getting_contacts_app/screens/home/home.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    this.selectedMenu,
  }) : super(key: key);

  final MenuState? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.home),
                    color: MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    onPressed: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
                  ),
                  IconButton(
                      icon: Icon(Icons.search),
                      color: MenuState.search == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.account_circle),
                      color: MenuState.profile == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.info_outline),
                      color: MenuState.about == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                      onPressed: () {}),
                ],
              )),
        ),
      ],
    );
  }
}
