import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'login.dart';

Map<String, dynamic> resetFormData = {};

class ResetPassword extends StatefulWidget {
  final Map tokenData;
  const ResetPassword({super.key, required this.tokenData});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

TextEditingController newPasswordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class _ResetPasswordState extends State<ResetPassword> {
  resetFormSubmit() async {
    resetFormData = {
      "token": widget.tokenData['token'],
      "password": newPasswordController.text,
      "cpassword": confirmPasswordController.text
    };

    final res = await post(
        Uri.parse("https://sowlab.pw/assignment/user/reset-password"),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json'
        },
        body: jsonEncode(resetFormData));

    final responseData = jsonDecode(res.body);
    responseData['success']
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData['message']),
            backgroundColor: Colors.green,
          ))
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData['message']),
            backgroundColor: Colors.blueGrey,
          ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
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
              child: Text("Reset Password",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login()));
                },
                child: RichText(
                  text: TextSpan(
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                            text: "Remember your password? ",
                            style:
                                TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3))),
                        TextSpan(
                            text: "Login",
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
                if (value!.isEmpty) {
                  return "password required";
                } else {
                  return null;
                }
              },
              obscureText: true,
              controller: newPasswordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                hintText: 'New Password',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                ),
                prefixIcon: Icon(
                  IconData(0xeaa9, fontFamily: 'MaterialIcons'),
                ),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                String pass = newPasswordController.text;
                if (value!.isEmpty || value != pass) {
                  return "confirm password should match with password.";
                } else {
                  return null;
                }
              },
              obscureText: true,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                hintText: 'Confirm New Password',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                ),
                prefixIcon: Icon(
                  IconData(0xeaa9, fontFamily: 'MaterialIcons'),
                ),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                    print("Submit");
                    resetFormSubmit();
                  },
                  child: Text("Submit",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white))),
            ),
          ]),
        )),
      ),
    );
  }
}
