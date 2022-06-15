// ignore_for_file: deprecated_member_use

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vvp/pages/contact.dart';
import 'package:vvp/pages/activity_points/activity_points.dart';
import 'package:vvp/pages/contact_original.dart';
import 'package:vvp/pages/grievance_cell/grievance_cell.dart';
import 'package:vvp/pages/grievance_cell/sent_grievance.dart';
import 'package:vvp/pages/instructions/instructions.dart';
import 'package:vvp/pages/library/library.dart';
import 'package:vvp/pages/login.dart';
import 'package:vvp/pages/placement/placement.dart';
import 'package:vvp/pages/results.dart';
import 'dart:core';
import 'package:vvp/services/service_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vvp/services/style.dart';

import 'drawer/nav_drawer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String username = "";
  String firstname = "";
  String lastname = "";

  // ignore: must_call_super
  initState() {
    getData();
  }

  getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        username = prefs.getString('username')!;
        print('username : ' + username);
      });
    } catch (e) {
      showAlertDialog(context, 'VVP Institute', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "VVP Institute App",
          style: GoogleFonts.quicksand(
              color: white, fontSize: 24, fontWeight: FontWeight.w800),
        ),
        backgroundColor: blue,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Image.asset('assets/icons/nav_icon.png', width: 26),
            onPressed: () {
              Scaffold.of(context).openDrawer();
        },
          );
        }),
      ),
      drawer: Nav_Drawer(),
      body: Container(
        decoration: BoxDecoration(
          color: blue,
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(50, 30, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome, " + username,
                        style: textStyle(white, 20, FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   "200470107508",
                      //   style: textStyle(white, 16, FontWeight.w800),
                      // ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30,30,30,0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        children: [
                          Grid_Menu(
                            size: size,
                            path: Contact(),
                            img: "assets/icons/icon_contact.png",
                            label: "Contact Diary",
                          ),
                          Grid_Menu(
                            size: size,
                            path: Instructions(),
                            img: "assets/icons/icon_instructions.png",
                            label: "Instructions",
                          ),
                          Grid_Menu(
                            size: size,
                            path: Grievance_Cell(),
                            img: "assets/icons/icon_grievance.png",
                            label: "Grievance Cell",
                          ),
                          Grid_Menu(
                            size: size,
                            path: Activity_Points(),
                            img: "assets/icons/icon_points.png",
                            label: "100 Points",
                          ),
                          Grid_Menu(
                            size: size,
                            path: Results(),
                            img: "assets/icons/icon_results.png",
                            label: "Results",
                          ),
                          Grid_Menu(
                            size: size,
                            path: Placement(),
                            img: "assets/icons/icon_placement.png",
                            label: "Placement",
                          ),
                          Grid_Menu(
                            size: size,
                            path: Library(),
                            img: "assets/icons/icon_library.png",
                            label: "Library",
                          ),
                        ],
                      ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Grid_Menu extends StatelessWidget {
  Grid_Menu({
    Key? key,
    required this.size,
    required this.path,
    required this.img,
    required this.label,
  }) : super(key: key);

  final Size size;
  var path;
  String img = "";
  String label = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => path),
          );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(2,2),
                  blurRadius: 2,
                  // spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(-2,-2),
                  blurRadius: 2,
                  // spreadRadius: 1,
                ),
              ]
            ),
        height: size.height * 0.12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(img, height: 50,),
            SizedBox(
              height: 15,
            ),
            Text(label,
                style: textStyle(black, 17, FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}