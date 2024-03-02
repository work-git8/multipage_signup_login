import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/reset_password.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';

import 'login.dart';

Map responseData = {};

class VerifyOTP extends StatefulWidget {
  final String phoneNumber;
  final Function code;

  const VerifyOTP({super.key, required this.phoneNumber, required this.code});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

TextEditingController verifyOtpController = TextEditingController();

class _VerifyOTPState extends State<VerifyOTP> {
  late var messageData;

  Future<Map<String, dynamic>> submit(String otp) async {
    final response = await post(
        Uri.parse("https://sowlab.pw/assignment/user/verify-otp"),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json'
        },
        body: jsonEncode({"mobile": otp}));

    return responseData = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 58,
      height: 59,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
    );

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
              child: Text("Verify OTP",
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
            Pinput(
              length: 5,
              controller: verifyOtpController,
              defaultPinTheme: defaultPinTheme,
              showCursor: true,
              onCompleted: (pin) => print(pin),
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
                  onPressed: () async {
                    print("Submit");
                    await submit(verifyOtpController.text);
                    print(responseData);
                    responseData['success']
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResetPassword(
                                  tokenData: responseData,
                                )))
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(responseData['message'])));
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => ResetPassword(
                    //           tokenData: responseData,
                    //         )));
                  },
                  child: Text("Submit",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white))),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
                onTap: () async {
                  print("Resend Code");
                  messageData = await widget.code(widget.phoneNumber);
                  print(messageData);
                  messageData['success']
                      ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(messageData['message']!),
                          backgroundColor: Colors.green,
                        ))
                      : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(messageData['message']),
                          backgroundColor: Colors.red,
                        ));
                },
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline),
                ))
          ]),
        )),
      ),
    );
  }
}
