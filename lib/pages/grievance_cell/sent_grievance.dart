import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vvp/pages/contact.dart';
import 'package:vvp/pages/grievance_cell/view_mail.dart';
import 'package:http/http.dart' as http;
import 'package:vvp/services/service_connection.dart';
import 'dart:async';
import 'dart:convert';

import 'package:vvp/services/style.dart';

import '../../services/service_grievance.dart';

class Sent_Grievance extends StatefulWidget {
  const Sent_Grievance({Key? key}) : super(key: key);

  @override
  _Sent_GrievanceState createState() => _Sent_GrievanceState();
}

class _Sent_GrievanceState extends State<Sent_Grievance> {

  Widget multipleCard(Grievance g, Size size) {
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new ViewMail(g),
              ),
            );
          },
          child: Container(
            // height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
            ),
            width: size.width * 1,
            margin: EdgeInsets.only(top: 10, right: 5, left: 5),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      "To: " + g.Email_Send_To,
                      style: textStyle(black, 18, FontWeight.w800)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2, bottom: 10),
                    child: Text(
                      g.Subject,
                      style: textStyle(black, 17, FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2, bottom: 10),
                    child: Text(
                      g.Description,
                      style: textStyle(Colors.grey, 17, FontWeight.w600),
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  Future<List<Grievance>> getUsers() async {

    print("fetch");

    String url = ConnectionConstant.grievances;
    http.Response response = await http.get(
        Uri.parse(
            url),
        headers: {"Accept": "application/json"});

      print(response.statusCode);

    var jsonUser = json.decode(response.body);
    print(jsonUser);

    List<Grievance> usersList = [];
    for (var u in jsonUser) {
      Grievance obj = new Grievance(
          u["Ask_The_Cena_Id"],
          u["Entry_Date"],
          u["Subject"],
          u["Description"],
          "grievance.cell@vvpedulink.ac.in",
          u["Email_From"],
          " ",
          u["Deleted"]);
      usersList.add(obj);
    }

    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: SpinKitFadingCube(
                color: Colors.blue,
                size: 50.0,
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Grievance grievance = new Grievance(
                  snapshot.data[index].ask_the_cena_id,
                  snapshot.data[index].Entry_Date,
                  snapshot.data[index].Subject,
                  snapshot.data[index].Description,
                  snapshot.data[index].Email_Send_To,
                  snapshot.data[index].Email_From,
                  snapshot.data[index].Attachment_Filename,
                  snapshot.data[index].deleted);
              return multipleCard(grievance, size);
            },
          );
        }
      },
    );
  }
}
