import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'signup_confirmation.dart';

class SignUpHours extends StatefulWidget {
  final Map<String, dynamic> data2;

  const SignUpHours({super.key, required this.data2});

  @override
  State<SignUpHours> createState() => _SignUpHoursState();
}

class _SignUpHoursState extends State<SignUpHours> {
  var days = ['M', 'T', 'W', 'Th', 'F', 'S', 'Su'];
  var hours = [
    '8:00am - 10:00am',
    '10:00am - 1:00pm',
    '1:00pm - 4:00pm',
    '4:00pm - 7:00pm',
    '7:00pm - 10:00pm'
  ];

  Map<String, String> dayNameMap = {
    'M': 'mon',
    'T': 'tue',
    'W': 'wed',
    'Th': 'thu',
    'F': 'fri',
    'S': 'sat',
    'Su': 'sun'
  };

  int selectedIndex = 0;
  Map<String, Set<int>> selectedHoursMap = {};
  Map<String, List<String>> convertedMap = {};

  submitAll() async {
    selectedHoursMap.forEach((key, value) {
      // Convert abbreviated day name to full name
      String fullName = dayNameMap[key]!;

      convertedMap[fullName.toLowerCase()] =
          value.map((index) => hours[index]).toList();
    });

    print(convertedMap);
    widget.data2['business_hours'] = convertedMap;
    widget.data2['device_token'] = "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx";
    widget.data2['type'] = "email/facebook/google/apple";
    widget.data2['social_id'] = "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx";
    print(jsonEncode(widget.data2));

    final response = await post(
        Uri.parse("https://sowlab.pw/assignment/user/register"),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json'
        },
        body: jsonEncode(widget.data2));
    final resData = jsonDecode(response.body);

    resData['success']
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignUpConfirmation()),
            (route) => false)
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(resData['message']),
            duration: Duration(seconds: 3),
          ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    padding: EdgeInsets.all(22),
                    width: double.infinity,
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "FarmerEats",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: 32),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Signup 4 of 4",
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
                        child: Text("Business Hours",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Choose the hours your farm is open for pickups. This will allow customers to order deliveries.",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.3)),
                      ),
                      SizedBox(height: 40),
                      Wrap(
                        spacing: 5,
                        children: List.generate(
                          days.length,
                          (index) => FilterChip(
                            backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
                            side: BorderSide.none,
                            disabledColor: Color.fromRGBO(0, 0, 0, 0.3),
                            showCheckmark: false,
                            selectedColor: Color.fromRGBO(213, 113, 91, 1),
                            label: Text(days[index]),
                            selected: selectedIndex == index,
                            onSelected: (selected) {
                              setState(() {
                                selected ? selectedIndex = index : 0;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 5,
                        children: List.generate(
                            hours.length,
                            (index) => Padding(
                                  padding: EdgeInsets.all(5),
                                  child: FilterChip(
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    labelPadding: EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 5.0),
                                    side: BorderSide.none,
                                    selectedColor:
                                        Color.fromRGBO(248, 197, 105, 1),
                                    showCheckmark: false,
                                    backgroundColor:
                                        Color.fromRGBO(0, 0, 0, 0.1),
                                    label: Text(hours[index]),
                                    selected:
                                        selectedHoursMap[days[selectedIndex]]
                                                ?.contains(index) ??
                                            false,
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          selectedHoursMap.putIfAbsent(
                                              days[selectedIndex],
                                              () => Set<int>());
                                          selectedHoursMap[days[selectedIndex]]
                                              ?.add(index);
                                        } else {
                                          selectedHoursMap[days[selectedIndex]]
                                              ?.remove(index);
                                        }
                                      });
                                    },
                                  ),
                                )),
                      ),
                      SizedBox(
                        height: 239,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.arrow_back),
                              onTap: () {
                                print("back to signup-verification");
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(
                              width: 226,
                              height: 52,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(213, 113, 91, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  onPressed: () {
                                    //print(selectedHoursMap);
                                    submitAll();
                                  },
                                  child: Text("Submit",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white))),
                            ),
                          ]),
                    ])))));
  }
}
