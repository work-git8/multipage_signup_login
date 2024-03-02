import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'signup_hours.dart';

TextEditingController attachmentController = TextEditingController();

class SignUpVerification extends StatefulWidget {
  final Map<String, dynamic> data1;

  const SignUpVerification({super.key, required this.data1});

  @override
  State<SignUpVerification> createState() => _SignUpVerificationState();
}

class _SignUpVerificationState extends State<SignUpVerification> {
  bool attachedFile = false;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);

    if (result != null) {
      String fileName = result.files.first.name;
      attachedFile = true;
      setState(() {
        attachmentController.text = fileName;
      });
      print('File name: $fileName');
    } else {
      print("user didn't select any file");
    }
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: 32),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Signup 3 of 4",
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
                        child: Text("Verification",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Attached proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.3)),
                      ),
                      SizedBox(height: 57),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Attach proof of registration",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("attach");
                                pickFile();
                              },
                              child: CircleAvatar(
                                radius: 26,
                                backgroundColor:
                                    Color.fromRGBO(213, 113, 91, 1),
                                child: Icon(
                                  //IconData(0xe130, fontFamily: 'MaterialIcons'),
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 40,
                      ),
                      Visibility(
                        visible: attachedFile,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 48,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(children: [
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                                controller: attachmentController,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  print("clear");
                                  setState(() {
                                    attachmentController.clear();
                                    attachedFile = false;
                                  });
                                },
                                child: Icon(Icons.close),
                              ),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 308,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.arrow_back),
                              onTap: () {
                                print("back to signup-farminfo");
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
                                    print("continue to verification");
                                    attachedFile
                                        ? widget.data1['registration_proof'] =
                                            attachmentController.text
                                        : widget.data1['registration_proof'] =
                                            '';
                                    print(widget.data1);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => SignUpHours(
                                                  data2: widget.data1,
                                                )));
                                  },
                                  child: Text(
                                      attachedFile ? "Submit" : "Continue",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white))),
                            ),
                          ]),
                    ])))));
  }
}
