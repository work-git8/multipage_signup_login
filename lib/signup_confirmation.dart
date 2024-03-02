import 'package:flutter/material.dart';

class SignUpConfirmation extends StatefulWidget {
  const SignUpConfirmation({super.key});

  @override
  State<SignUpConfirmation> createState() => _SignUpConfirmationState();
}

class _SignUpConfirmationState extends State<SignUpConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(children: [
                      SizedBox(
                        height: 185,
                      ),
                      Icon(
                        Icons.done,
                        color: Color.fromRGBO(0, 203, 20, 1),
                        size: 80,
                      ),
                      SizedBox(
                        height: 33,
                      ),
                      Text("You’re all done!",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Hang tight! We are currently reviewing your account and will follow up with you in 2-3 business days. In the meantime, you can setup your inventory.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(137, 137, 137, 1)),
                      ),
                      SizedBox(
                        height: 316,
                      ),
                      SizedBox(
                        width: 330,
                        height: 52,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(213, 113, 91, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            onPressed: () {
                              print("got it");
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const Login()));
                            },
                            child: Text("Got it",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      )
                    ])))));
  }
}
