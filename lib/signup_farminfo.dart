import 'package:flutter/material.dart';

import 'signup_verification.dart';

TextEditingController businessNameController = TextEditingController();
TextEditingController informalNameController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController stateController = TextEditingController(text: 'New York');
TextEditingController zipcodeController = TextEditingController();
final farmInfoFormKey = GlobalKey<FormState>();
Map<String, dynamic> formData1 = {};

class SignUpFarmInfo extends StatefulWidget {
  final Map<String, dynamic> data;
  const SignUpFarmInfo({super.key, required this.data});

  @override
  State<SignUpFarmInfo> createState() => _SignUpFarmInfoState();
}

class _SignUpFarmInfoState extends State<SignUpFarmInfo> {
  Map<String, dynamic> collectFormData() {
    formData1 = {
      'business_name': businessNameController.text,
      'informal_name': informalNameController.text,
      'address': addressController.text,
      'city': cityController.text,
      'state': stateController.text,
      'zipcode': int.parse(zipcodeController.text)
    };
    return formData1;
  }

  bool isFormDataValid(Map<String, dynamic> validData) {
    // Check if any required field is empty
    if (validData.containsValue(null) || validData.containsValue('')) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> states = ['New York', 'Michigan', 'California', 'New Jersey'];
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          child: Form(
            key: farmInfoFormKey,
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
                  "Signup 2 of 4",
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
                child: Text("Farm Info",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              ),
              SizedBox(height: 40),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "field can't be empty";
                  } else {
                    return null;
                  }
                },
                controller: businessNameController,
                decoration: InputDecoration(
                  hintText: 'Business Name',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.discount_outlined),
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
                    return "field can't be empty";
                  } else {
                    return null;
                  }
                },
                controller: informalNameController,
                decoration: InputDecoration(
                  hintText: 'Informal Name',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.tag_faces_sharp),
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
                    return "field can't be empty";
                  } else {
                    return null;
                  }
                },
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Street Address',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.home_outlined),
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
                    return "field can't be empty";
                  } else {
                    return null;
                  }
                },
                controller: cityController,
                decoration: InputDecoration(
                  hintText: 'City',
                  filled: true,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.location_on_outlined),
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
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field can't e empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'State',
                        filled: true,
                        fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3)),
                      ),
                      items: states.map((item) {
                        return DropdownMenuItem(
                          value: item.toString(),
                          child: Text(
                            item.toString(),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        print(value);
                        stateController.text = value.toString();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter numeric value";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: zipcodeController,
                      decoration: InputDecoration(
                        hintText: 'Enter Zipcode',
                        filled: true,
                        fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3)),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    print("back to signup");
                    Navigator.of(context).pop();
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
                        print("continue to verification");
                        collectFormData();
                        widget.data['role'] = 'farmer';
                        print(formData1);
                        widget.data.addAll(formData1);
                        print(widget.data);
                        if (!farmInfoFormKey.currentState!.validate() &&
                            !isFormDataValid(formData1)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Some fields are still empty."),
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpVerification(
                                    data1: widget.data,
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
