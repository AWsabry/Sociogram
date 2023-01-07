import 'package:flutter/material.dart';
import 'package:getting_contacts_app/components/custom_surfix_icon.dart';
import 'package:getting_contacts_app/components/form_error.dart';

import 'package:provider/provider.dart';
import '../../../providers/users.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // String email;
  // String password;
  bool remember = false;
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
    UserProvider authProvider = Provider.of<UserProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(10)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                try {
                  if (await authProvider.signIn()) {
                    // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  }
                } catch (e) {
                  addError(error: kInvalidError);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    UserProvider authProvider = Provider.of<UserProvider>(context);
    return TextFormField(
      obscureText: true,
      controller: authProvider.password,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kPassNullError);
      //   } else if (value.length >= 8) {
      //     removeError(error: kShortPassError);
      //   }
      //   password.text = value;
      // },
      // validator: (value) {
      //   if (value.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if (value.length < 8) {
      //     addError(error: kShortPassError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    UserProvider authProvider = Provider.of<UserProvider>(context);
    return TextFormField(
      controller: authProvider.email,
      keyboardType: TextInputType.emailAddress,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kEmailNullError);
      //   } else if (emailValidatorRegExp.hasMatch(value)) {
      //     removeError(error: kInvalidEmailError);
      //   }
      //   email.text = value;
      // },
      // validator: (value) {
      //   if (value.isEmpty) {
      //     addError(error: kEmailNullError);
      //     return "";
      //   } else if (!emailValidatorRegExp.hasMatch(value)) {
      //     addError(error: kInvalidEmailError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
