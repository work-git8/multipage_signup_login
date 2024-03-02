import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int length;
  final Color color;
  final int index;
  final int currentIndex;

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
    );
  }

  const CustomScaffold(
      {super.key,
      required this.color,
      required this.title,
      required this.description,
      required this.image,
      required this.length,
      required this.index,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: null,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            color: color,
            //color: Color.fromRGBO(94, 162, 95, 1),
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(flex: 5, child: Image.asset(image)),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              length,
                              (index) => buildDot(index, context),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 60,
                          margin: EdgeInsets.all(20),
                          width: double.infinity,
                          child: FloatingActionButton(
                            child: Text(
                              "Join the movement!",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              print("Join the movement!");
                            },
                            backgroundColor: color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 14),
                          ),
                          onTap: () {
                            print("login");
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
