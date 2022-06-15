import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vvp/pages/grievance_cell/sent_grievance.dart';
import 'package:vvp/services/service_connection.dart';
import 'package:vvp/services/style.dart';
import 'package:http/http.dart' as http;

import '../../services/service_grievance.dart';

class ViewMail extends StatefulWidget {
  Grievance grievance;
  ViewMail(this.grievance);

  @override
  _ViewMailState createState() => _ViewMailState(grievance);
}

class _ViewMailState extends State<ViewMail> {
  Grievance grievance;
  _ViewMailState(this.grievance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Image(
              image: AssetImage('assets/icons/back_arrow.png'),
              width: 25,
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
                image: AssetImage('assets/icons/delete.png'),
                width: 20,
              ),
              onPressed: () async{
                try {
                Uri url = Uri.parse(
                    ConnectionConstant.grievances +
                        grievance.ask_the_cena_id.toString());
                http.Response response = await http.put(
                  url,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, int>{'Deleted': 1}),
                );
                print(response.statusCode);
              } catch (e) {}
                Navigator.pop(context);
              },
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              grievance.Subject,
              style: textStyle(black, 26, FontWeight.w800),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              grievance.Email_From,
              style: textStyle(black, 18, FontWeight.w800),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "To: " + grievance.Email_Send_To,
              style: textStyle(Colors.grey, 15, FontWeight.w800),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              grievance.Description,
              style: textStyle(black, 15, FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
