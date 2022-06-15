// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vvp/pages/grievance_cell/compose_mail.dart';
import 'package:vvp/pages/grievance_cell/inbox_grievance.dart';
import 'package:vvp/pages/grievance_cell/sent_grievance.dart';
import 'package:vvp/pages/grievance_cell/trash_grievance.dart';
import 'package:vvp/services/style.dart';

class Grievance_Cell extends StatefulWidget {
  const Grievance_Cell({Key? key}) : super(key: key);

  @override
  _Grievance_CellState createState() => _Grievance_CellState();
}

class _Grievance_CellState extends State<Grievance_Cell> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
          icon: Image(
            image: AssetImage('assets/icons/back_arrow_dark.png'),
            width: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          backgroundColor: white,
          elevation: 2,
          title: Text('Grievance Cell',
              style: textStyle(black, 20, FontWeight.w800)),
          bottom: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: blue,
            indicatorColor: blue,
            indicatorPadding: EdgeInsets.only(left: 25, right: 25),
            tabs: [
              _TabName(tname: "Sent"),
              _TabName(tname: "Trash"),
            ],
          ),
        ),
        body: Stack(children: [
          TabBarView(
            children: [
              Sent_Grievance(),
              Trash_Grievance(),
            ],
          ),

// <--------------------------- Compose Button ----------------------------->

          Positioned(
            bottom: 35,
            right: 20,
            child: ButtonTheme(
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComposeMail()),
                  );
                },
                color: blue,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Compose',
                      style: textStyle(white, 14, FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class _TabName extends StatelessWidget {

  String tname;
  _TabName({required this.tname});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        child: Text(
          tname,
          style: textStyle(black, 17, FontWeight.w800),
        ),
      ),
    );
  }
}