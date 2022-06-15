import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vvp/pages/grievance_cell/sent_grievance.dart';
import 'package:vvp/pages/grievance_cell/view_mail.dart';
import 'package:vvp/services/service_connection.dart';

import '../../services/service_grievance.dart';

class Trash_Grievance extends StatefulWidget {
  const Trash_Grievance({ Key? key }) : super(key: key);

  @override
  _Trash_GrievanceState createState() => _Trash_GrievanceState();
}

class _Trash_GrievanceState extends State<Trash_Grievance> {

  String url = ConnectionConstant.grievances;
  Future<List<Grievance>> getUsers() async {
    http.Response response = await http.get(
        Uri.parse(
            url),
        headers: {"Accept": "application/json"});

    var jsonUser = json.decode(response.body);

    List<Grievance> usersList = [];
    for (var u in jsonUser) {
      if(u["Deleted"] == 1) {
        Grievance obj = new Grievance(
            u["Ask_The_Cena_Id"],
            u["Entry_Date"],
            u["Subject"],
            u["Description"],
            "grievance.cell@vvpedulink.ac.in",
            u["Email_From"],
            "",
            u["Deleted"]); // , u["username"], u["email"], u["address"], u["phone"], u["website"], u["company"]);//);
        usersList.add(obj);
      }
    }
    return usersList;
  }

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
                builder: (context) => ViewMail(g),
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
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 10),
                    child: Text(
                      "To: " + g.Email_Send_To,
                      style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2, bottom: 10),
                    child: Text(
                      g.Subject,
                      style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2, bottom: 10),
                    child: Text(
                      g.Description,
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
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