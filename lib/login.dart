import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:icons_plus/icons_plus.dart';

import 'forgot_password.dart';
import 'login_api.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController emailLoginController = TextEditingController();
TextEditingController passwordLoginController = TextEditingController();

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loginApiCall() async {
      final response = await post(
          Uri.parse("https://sowlab.pw/assignment/user/login"),
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json'
          },
          body: jsonEncode({
            "email": emailLoginController.text,
            "password": passwordLoginController.text,
            "role": "farmer",
            "device_token": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
            "type": "email/facebook/google/apple",
            "social_id": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx"
          }));
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        resData['success']
            ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    '${resData['message']} \n\n Token is ${resData['token']}'),
                backgroundColor: Colors.green,
              ))
            : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(resData['message']),
                backgroundColor: Colors.red,
              ));
        print(resData['token']);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.statusCode}: ${resData['message']}'),
          ),
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          child: Form(
            key: _loginFormKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "FarmerEats",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 109),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Welcome back!",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text: "New here? ",
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.3))),
                          TextSpan(
                              text: "Create Account",
                              style: TextStyle(
                                  color: Color.fromRGBO(213, 113, 91, 1)))
                        ]),
                  ),
                ),
              ),
              SizedBox(height: 90),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  final emailRegExp =
                      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (emailRegExp.hasMatch(value!)) {
                    return null;
                  } else {
                    return "valid email required";
                  }
                },
                controller: emailLoginController,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 14, top: 13),
                    child: Text(
                      "@",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  hintText: 'Email Address',
                  hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3)),
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "password required";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                controller: passwordLoginController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3)),
                  prefixIcon: Icon(
                    IconData(0xeaa9, fontFamily: 'MaterialIcons'),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ForgetPassword()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, top: 15),
                      child: Text(
                        "Forgot?",
                        style: TextStyle(
                          color: Color.fromRGBO(213, 113, 91, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: 330,
                height: 52,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(213, 113, 91, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      print("Login");
                      if (!_loginFormKey.currentState!.validate() ||
                          emailLoginController.text.isEmpty ||
                          passwordLoginController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("email or password field is empty!"),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        loginApiCall();
                      }
                    },
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white))),
              ),
              SizedBox(height: 32),
              Text("or login with",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(38, 28, 18, 0.3))),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var user = await LoginApi.login();
                      if (user != null) {
                        print(user.displayName);
                        print(user.email);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Login successful with username : ${user.displayName} and email : ${user.email}'),
                          backgroundColor: Colors.green,
                        ));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(13, 12, 13, 12),
                      height: 52,
                      width: 96,
                      child: Logo(
                        Logos.google,
                        size: 30,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.08)),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(13, 12, 13, 12),
                    height: 52,
                    width: 96,
                    child: Logo(
                      Logos.apple,
                      size: 30,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Color.fromRGBO(0, 0, 0, 0.08)),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(13, 12, 13, 12),
                    height: 52,
                    width: 96,
                    child: Logo(
                      Logos.facebook_logo,
                      size: 30,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Color.fromRGBO(0, 0, 0, 0.08)),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ],
              )
            ]),
          ),
        )),
      ),
    );
  }
}
