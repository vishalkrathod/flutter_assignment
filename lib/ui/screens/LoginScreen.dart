/*
 * **************************************************************************************
 *  * Copyright (c) 2023. Vishal Rathod
 *  *
 *  * All rights reserved. This work, including but not limited to all source code, images,
 *  * graphics, icons, and text, is the property of Vishal Rathod, a mobile app developer,
 *  * and is protected by copyright laws and international treaties.
 *  *
 *  * Unauthorized reproduction or distribution of this work, or any portion thereof,
 *  * may result in severe civil and criminal penalties and will be prosecuted
 *  * to the maximum extent possible under the law.
 *  *
 *  * For inquiries regarding licensing, usage, or any other questions, please contact:
 *  *
 *  * Vishal Rathod
 *  * Mobile App Developer
 *  *
 *  * This copyright notice applies to all projects, applications, and codebases developed
 *  * by Vishal Rathod using Android Studio or any other development tools. Any use of this
 *  * work, including but not limited to copying, modifying, or distributing it without
 *  * explicit written consent from Vishal Rathod, is strictly prohibited.
 *  **************************************************************************************
 *
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/generated/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  int _state = 0;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _login() {
    // Implement your login logic here, e.g., check if the username and password are correct.
    // For simplicity, we'll just navigate to the MainScreen if both fields are non-empty.

    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      context.pushReplacement("/main_screen");
    } else {
      // Show an error message or handle authentication failure.
      // You can display a Snackbar or AlertDialog to inform the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
          toolbarHeight: 0.0,
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: (MediaQuery.of(context).size.height * 0.25),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SvgPicture.asset(
                      Assets.assetsImagesLogoDark,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Form(
                  key: _formKey,
                  child: _buildEmailSignUpForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailSignUpForm(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                TextSpan(
                  text: "Login",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                ),
              ])),
        ),
        Container(
          decoration: BoxDecoration(
            // color: Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(36.0)),
          ),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          // color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: new TextFormField(
              controller: _usernameController,
              autofocus: false,
              keyboardType: TextInputType.name,
              inputFormatters: [],
              cursorColor: Theme.of(context).primaryColor,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter the username";
                }
                return null;
              },
              style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColor),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  isDense: true,
                  hintText: "Username",
                  filled: true,
                  // fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(36.0)),
          ),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: new TextFormField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              autofocus: false,
              keyboardType: TextInputType.name,
              inputFormatters: [],
              cursorColor: Theme.of(context).primaryColor,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter the password";
                }
                return null;
              },
              style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColor),
              decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        size: 24,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  isDense: true,
                  hintText: "Password",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ),
        SizedBox(
          height: 0.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: () {}, child: Text("Forgot Password?")),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _state = 1;
                });

                Future.delayed(
                  Duration(seconds: 3),
                  () {
                    setState(() {
                      _state = 2;
                      _login();
                    });
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: Size(300, 60),
            ),
            child: setUpButtonChild(),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: RichText(
              text: TextSpan(text: 'Don\'t have an account? ', style: TextStyle(color: Colors.black, fontSize: 16), children: <TextSpan>[
                TextSpan(
                    text: 'Register here',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Sign Up");
                        // navigate to desired screen
                      })
              ]),
            ),
          )
        ])
      ],
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Login",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (_state == 1) {
      return SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ));
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }
}
