import 'package:flutter/material.dart';
import 'package:flutter_application_1/signup_farminfo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';

import 'login.dart';

TextEditingController fullNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
final _registerFormKey = GlobalKey<FormState>();
Map<String, dynamic> formData = {};

Map<String, dynamic> collectFormData() {
  formData = {
    'full_name': fullNameController.text,
    'email': emailController.text,
    'phone': phoneController.text,
    'password': passwordController.text,
  };
  return formData;
}

bool isFormDataValid(Map<String, dynamic> data) {
  // Check if any required field is empty
  if (data.containsValue(null) || data.containsValue('')) {
    return false;
  } else {
    return true;
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _registerFormKey,
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "FarmerEats",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 32),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Signup 1 of 4",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.3)),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Welcome!",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      GoogleSignIn _googleSignIn = GoogleSignIn();
                      try {
                        await _googleSignIn.signOut();

                        var user = await _googleSignIn.signIn();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Login successful with username : ${user!.displayName} and email : ${user.email}'),
                          backgroundColor: Colors.green,
                        ));
                        print(user);
                      } catch (e) {
                        print(e);
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
              ),
              SizedBox(
                height: 32,
              ),
              Text("or signup with",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(38, 28, 18, 0.3))),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "fullname required";
                  } else {
                    return null;
                  }
                },
                controller: fullNameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.person),
                  hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3)),
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
                  final emailRegExp =
                      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (emailRegExp.hasMatch(value!)) {
                    return null;
                  } else {
                    return "valid email required";
                  }
                },
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "@",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3)),
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
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  final phoneRegExp = RegExp(r"^\+?\d{10}$");
                  if (phoneRegExp.hasMatch(value!)) {
                    return null;
                  } else {
                    return "10digit valid number required";
                  }
                },
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.phone_outlined),
                  prefixIconColor: Colors.black,
                  hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3)),
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
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    IconData(0xeaa9, fontFamily: 'MaterialIcons'),
                    size: 24, // Adjust the size as needed
                  ),
                  prefixIconColor: Colors.black,
                  hintStyle:
                      TextStyle(color: const Color.fromRGBO(0, 0, 0, 0.3)),
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
                  String pass = passwordController.text;
                  if (value!.isEmpty || value != pass) {
                    return "re-enter password should match with password.";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Re-enter Password',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    IconData(0xeaa9, fontFamily: 'MaterialIcons'),
                    size: 24, // Adjust the size as needed
                  ),
                  prefixIconColor: Colors.black,
                  hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3)),
                ),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 69,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    print("login");
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
                SizedBox(
                  width: 226,
                  height: 52,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(213, 113, 91, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        collectFormData();
                        print(formData);
                        if (!_registerFormKey.currentState!.validate() &&
                            !isFormDataValid(formData)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Some fields are still empty."),
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpFarmInfo(
                                    data: formData,
                                  )));
                        }
                      },
                      child: Text("Continue",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white))),
                ),
              ]),
            ]),
          ),
        )),
      ),
    );
  }
}
