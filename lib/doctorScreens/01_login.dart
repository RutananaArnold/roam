import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_care_app/doctorScreens/02_register.dart';
import 'package:flutter_health_care_app/doctorScreens/index.dart';
import 'package:flutter_health_care_app/widgets/RoundedInputField.dart';
import 'package:flutter_health_care_app/widgets/RoundedPasswordField.dart';
import 'package:flutter_health_care_app/widgets/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  bool _shConfirmPass = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70.0),
            Text(
              "Doctor Login",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.8,
                  color: Colors.white),
            ),
            
            headerSection(),
            inputSection(),
            loginButton(),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: InkWell(
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) => Register(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //UI Components
  headerSection() {
    return Container(
      height: 300.0,
      child: Center(
        child: Icon(
          Icons.location_on_outlined,
          color: Colors.white,
          size: 150.0,
        ),
      ),
    );
  }

  inputSection() {
    return Column(
      children: [
        RoundedInputField(
          hintText: "Email Address",
          icon: Icons.mail_outline,
          field: emailController,
          fcolor: Colors.white70,
          onChanged: (value) {},
        ),
        RoundedPasswordField(
          passwordhint: 'Password',
          field: passwordController,
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
  loginButton() {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(kappSecondary),
            ),
          )
        : ElevatedButton(
            child: Text("SIGN IN"),
            onPressed: () async {
              if (emailController.text == ' ' || passwordController.text == ' ') {
                Flushbar(
                  message: "Empty field/s found!",
                  icon: Icon(Icons.info_outline, size: 25.0, color: Colors.red),
                  duration: Duration(seconds: 3),
                  leftBarIndicatorColor: Colors.red,
                )..show(context);
              } else {
                setState(() {
                  _isLoading = true;
                });
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                var x =
                    sharedPreferences.setString("email", emailController.text);
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Index(),
                    ),
                    (Route<dynamic> route) => true);
                print(x);
              }
            },
          );
  }
}
