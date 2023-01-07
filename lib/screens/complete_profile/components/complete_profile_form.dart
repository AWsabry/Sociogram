import 'package:flutter/material.dart';
import 'package:getting_contacts_app/components/custom_surfix_icon.dart';
import 'package:getting_contacts_app/components/default_button.dart';
import 'package:getting_contacts_app/components/form_error.dart';
import 'package:getting_contacts_app/screens/home/home.dart';

import 'package:provider/provider.dart';
import '../../../providers/users.dart';

import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  final TextEditingController? email;
  final TextEditingController? password;
  final String? uid;

  CompleteProfileForm({
    Key? key,
    this.uid,
    this.email,
    this.password,
  }) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
              text: "Done",
              press: () async {
                await authProvider.signUp();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              }),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    final authProvider = Provider.of<UserProvider>(context);
    return TextFormField(
      controller: authProvider.city,
      decoration: InputDecoration(
        labelText: "City Name",
        hintText: "Enter your City Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    final authProvider = Provider.of<UserProvider>(context);
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: authProvider.phoneNumber,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your Phone Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    final authProvider = Provider.of<UserProvider>(context);
    return TextFormField(
      controller: authProvider.lastName,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your Last Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,

        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    final authProvider = Provider.of<UserProvider>(context);
    return TextFormField(
      controller: authProvider.firstName,
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your First Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
