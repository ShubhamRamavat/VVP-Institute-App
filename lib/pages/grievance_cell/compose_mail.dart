// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vvp/services/service_connection.dart';
import 'package:vvp/services/style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:dio/dio.dart';

class ComposeMail extends StatefulWidget {
  const ComposeMail({Key? key}) : super(key: key);

  @override
  _ComposeMailState createState() => _ComposeMailState();
}

class _ComposeMailState extends State<ComposeMail> {
  TextEditingController subjectController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController captchController = new TextEditingController();

  bool showvalue = false;

  final _formKey = GlobalKey<FormState>();

  String sender_mail = 'grievance.cell@vvpedulink.ac.in';
  String nature_type = 'Department';
  String subject = '';
  String desc = ' ';
  String file = ' ';
  String finalCaptcha = ' ';
  int Nature_of_Grevience = 0;

  // Random random = new Random();
  int captch = new Random().nextInt(9999);

  var choose_mail = [
    'grievance.cell@vvpedulink.ac.in',
  ];

  var nature_list = [
    'Department',
    'Student Section',
    'Account Section',
    'Library',
    'Establihment',
    'Other'
  ];

  File img = new File('assets/images/bg.png');

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;

    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Image(
              image: AssetImage('assets/icons/close.png'),
              width: 17,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Image(
                image: AssetImage('assets/icons/sent.png'),
                width: 20,
              ),
              onPressed: () async {
                try {
                  subject = subjectController.text.toString();
                  desc = descController.text.toString();
                  finalCaptcha = captchController.text;
                  if (_formKey.currentState!.validate() &&
                      finalCaptcha.compareTo(captch.toString()) == 0) {
                    if (showvalue) {
                      print(sender_mail);
                      print(nature_type);
                      print(subject);
                      print(desc);
                      print(Nature_of_Grevience);

                      http.Response response = await http.post(
                          Uri.parse(
                              ConnectionConstant.baseURL + "/member/create"),
                          body: {
                            "Subject": subject.toString(),
                            "Description": desc.toString(),
                            "Email_Send_To": sender_mail.toString(),
                            "Email_From": "shubham@gmail.com",
                            "Deleted": 0.toString(),
                            "Nature_of_Grevience": Nature_of_Grevience.toString(),
                            // "file": file,
                          });

                      print(response.statusCode);

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(" Please Accept Terms and Condition")));
                    }
                  }
                } catch (e) {}

                // Navigator.pop(context);
              },
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // <--------------------------- Sender Mail ----------------------------->

                Text(
                  'To',
                  style: textStyle(black, 17, FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: sender_mail,
                  style: textStyle(black, 17, FontWeight.w500),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: choose_mail.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      sender_mail = newValue as String;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                // <--------------------------- Nature of Grievance ----------------------------->

                Text(
                  'Nature of Grievance',
                  style: textStyle(black, 17, FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: nature_type,
                  style: textStyle(black, 17, FontWeight.w500),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: nature_list.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      Nature_of_Grevience =
                          nature_list.indexOf(newValue as String);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                // <--------------------------- Subject of Grievance ----------------------------->

                Text(
                  'Subject of Grievance',
                  style: textStyle(black, 17, FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    controller: subjectController,
                    style: textStyle(black, 17, FontWeight.w500),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Subject';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                // <--------------------------- Desciption of Grievance ----------------------------->

                Text(
                  'Desciption of Grievance',
                  style: textStyle(black, 17, FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  minLines: 3,
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  controller: descController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  style: textStyle(black, 17, FontWeight.w500),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Description';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                // <--------------------------- Attachment ----------------------------->

                Text(
                  'Attachment',
                  style: textStyle(black, 17, FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: RaisedButton(
                        onPressed: () {
                          _pickFile();
                        },
                        child: Text(
                          "Choose File",
                          style: textStyle(blue, 12, FontWeight.w800),
                        ),
                        color: Colors.white,
                        textColor: blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: blue)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Less than 2MB",
                        style: textStyle(black, 12, FontWeight.w800),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                // <--------------------------- Captcha ----------------------------->

                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.white,
                      ),
                      child: Text(
                        captch.toString(),
                        style: textStyle(black, 15, FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        controller: captchController,
                        style: textStyle(black, 17, FontWeight.w500),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Captcha';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                // <--------------------------- Agreement ----------------------------->

                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: blue,
                      value: this.showvalue,
                      onChanged: (value) {
                        setState(() {
                          this.showvalue = value as bool;
                        });
                      },
                    ),
                    Container(
                      width: size.width * 0.75,
                      child: Text(
                        "I certify that the Information Uploaded on this application is correct to the best of my knowledge.",
                        style: textStyle(black, 15, FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
