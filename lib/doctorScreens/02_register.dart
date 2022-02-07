import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_care_app/doctorScreens/01_login.dart';
import 'package:flutter_health_care_app/widgets/RoundedInputField.dart';
import 'package:flutter_health_care_app/widgets/RoundedPasswordField.dart';
import 'package:flutter_health_care_app/widgets/TabLabel.dart';
import 'package:flutter_health_care_app/widgets/palette.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final TextEditingController passConfController = new TextEditingController();

  bool _isLoading = false;
  bool _shPassword = true;
  bool _shConfirmPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Text(
                  "Doctor Registration",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.8,
                      color: Colors.white),
                ),
                SizedBox(height: 5.0),
                TabLabel(
                  label: 'Registration Form',
                  color: kappSecondary,
                ),
                SizedBox(height: 10.0),
                SizedBox(height: 10.0),
                sectionB(),
                SizedBox(height: 10.0),
                sectionC(),
                SizedBox(height: 10.0),
                registerButton(),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: InkWell(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Login(),
                      ),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //UI Components

  sectionB() {
    return Column(
      children: [
        RoundedInputField(
          hintText: "Email Address",
          field: emailController,
          fcolor: Colors.white70,
          icon: Icons.mail_outline,
          onChanged: (value) {},
        ),
      ],
    );
  }

  sectionC() {
    return Column(
      children: [
        RoundedPasswordField(
          passwordhint: 'Password',
          field: passController,
          fcolor: Colors.white70,
          hideText: _shPassword,
          showHide: () {
            setState(() {
              _shPassword = !_shPassword;
            });
          },
        ),
        RoundedPasswordField(
          passwordhint: 'Confirm Password',
          field: passConfController,
          fcolor: Colors.white70,
          hideText: _shConfirmPass,
          showHide: () {
            setState(() {
              _shConfirmPass = !_shConfirmPass;
            });
          },
        ),
      ],
    );
  }

  //LogicTrigger
  registerButton() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(kappSecondary),
        ),
      );
    } else {
      return ElevatedButton(
        child: Text("SIGNUP"),
        onPressed: () {
          if (emailController.text == '' ||
              passController.text == '' ||
              passConfController.text == '') {
            Flushbar(
              message: "Empty field/s found!",
              icon: Icon(Icons.info_outline, size: 25.0, color: Colors.red),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.red,
            )..show(context);
          } else {
            //phoneno check + email check missing
            if (passController.text != passConfController.text) {
              Flushbar(
                message: "Passwords do not match",
                icon: Icon(Icons.info_outline, size: 25.0, color: Colors.red),
                duration: Duration(seconds: 3),
                leftBarIndicatorColor: Colors.red,
              )..show(context);
            } else {
              setState(() {
                _isLoading = true;
              });
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Login(),
                  ),
                  (Route<dynamic> route) => false);
            }
          }
        },
      );
    }
  }
}
