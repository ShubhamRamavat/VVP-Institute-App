import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vvp/pages/contact.dart';
import 'package:vvp/pages/grievance_cell/view_mail.dart';
import 'package:vvp/services/style.dart';

class Inbox_Grievance extends StatefulWidget {
  const Inbox_Grievance({Key? key}) : super(key: key);

  @override
  _Inbox_GrievanceState createState() => _Inbox_GrievanceState();
}

class _Inbox_GrievanceState extends State<Inbox_Grievance> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ViewMail(),
            //   ),
            // );
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
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "Admin",
                      style: textStyle(black, 20, FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2, bottom: 5),
                    child: Text(
                      "Subject of Grievance",
                      style: textStyle(black, 17, FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2, bottom: 5),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      style: textStyle(Colors.grey, 17, FontWeight.w600),
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}