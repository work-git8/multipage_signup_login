import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'login.dart';
import 'verify_otp.dart';

TextEditingController phoneController = TextEditingController();
Map resData = {};

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  Future<Map<String, dynamic>> sendCode(String mobile) async {
    final response = await post(
        Uri.parse("https://sowlab.pw/assignment/user/forgot-password"),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json'
        },
        body: jsonEncode({"mobile": mobile}));

    return resData = jsonDecode(response.body);
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
              child: Text("Forgot Password?",
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
                prefixIcon: Icon(Icons.phone_outlined),
                hintText: 'Phone Number',
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
                    print("Send Code");
                    sendCode(phoneController.text);
                    resData['success']
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VerifyOTP(
                                  phoneNumber: phoneController.text,
                                  code: sendCode,
                                )))
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(resData['message'])));

                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => VerifyOTP(
                    //           phoneNumber: phoneController.text,
                    //           code: sendCode,
                    //         )));
                  },
                  child: Text("Send Code",
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
