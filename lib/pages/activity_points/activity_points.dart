import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vvp/services/service_connection.dart';

import '../../services/service_activity_point.dart';
import '../../services/style.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'add_activity.dart';

class Activity_Points extends StatefulWidget {
  const Activity_Points({Key? key}) : super(key: key);

  @override
  State<Activity_Points> createState() => _Activity_PointsState();
}

class _Activity_PointsState extends State<Activity_Points> {
  String url = ConnectionConstant.activity;
  String totalPoint = '0';
  List<ActivityPoint> pointList = [];

  Future<List<ActivityPoint>> getPoints() async {
    http.Response response = await http.get(
        Uri.parse(
            url),
        headers: {"Accept": "application/json"});

    var jsonUser = json.decode(response.body);

    List<ActivityPoint> pointList = [];
    for (var u in jsonUser) {
     ActivityPoint obj = new ActivityPoint(
          u['Student_Activity_Points_Id'],
          u['Student_Id'],
          u['Main_Heading_Index'],
          u['Sub_Heading_Index'],
          u['Assign_Activity_Index'],
          u['Approval_Status'],
          u['Semester'],
          u['Activity_Point'],
          u['Event_Date']);
      pointList.add(obj);
      print(pointList.length);
    }
    
    return pointList;
  }

  String getTotal()
  {
    int total=0;
    for(var i = 0; i < pointList.length; i++)
    {
      total += pointList[i].activity_Point;
    }
    return total.toString();
  }
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image(
            image: AssetImage('assets/icons/back_arrow.png'),
            width: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: blue,
        elevation: 2,
        title: Text(
          "100 Points Activity",
          style: appbarText(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.fromLTRB(25, 20, 20, 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorNavy,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Points :",
                            style: textStyle(white, 16, FontWeight.w500)),
                        SizedBox(height: 4),
                        Text("28",
                            style: textStyle(white, 46, FontWeight.w800)),
                      ],
                    ),
                    ButtonTheme(
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Add_Activity()),
                          );
                        },
                        color: white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: colorNavy,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Add More Activity',
                              style: textStyle(colorNavy, 14, FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text("Acitivty Status",
                  style: textStyle(black, 18, FontWeight.w800)),
              SizedBox(height: 10),
              FutureBuilder(
                future: getPoints(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: SpinKitFadingCube(
                          color: Colors.blue,
                          size: 30.0,
                        ),
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            ActivityPoint pointData = new ActivityPoint(
                                snapshot.data[index].student_Activity_Points_Id,
                            snapshot.data[index].student_Id,
                            snapshot.data[index].main_Heading_Index,
                            snapshot.data[index].sub_Heading_Index,
                            snapshot.data[index].assign_Activity_Index,
                            snapshot.data[index].approval_Status,
                            snapshot.data[index].semester,
                            snapshot.data[index].activity_Point,
                            snapshot.data[index].event_Date
                            );
                            
                            // totalPoint = getTotal();
                            return Expanded(child: _activityCard(pointData));
                          }),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _activityCard(ActivityPoint point) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () => _showActivity(point),
      child: Container(
        margin: EdgeInsets.only(bottom: 14),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: point.approval_Status == 'Pending'? colorYellow : colorGreenDark,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Text(point.main_Heading_Index.toString(),
                    style: textStyle(black, 16, FontWeight.w800)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Text(point.sub_Heading_Index.toString(),
                    style: textStyle(black, 22, FontWeight.w800)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status : " + point.approval_Status.toString(),
                      style: textStyle(black, 16, FontWeight.w500),
                    ),
                    Text(
                      "Semester : " + point.semester.toString(),
                      style: textStyle(black, 16, FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  void _showActivity(ActivityPoint point) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size.height * 0.8,
            child: Container(
              child: _activityDetail(point),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          );
        });
  }

  SingleChildScrollView _activityDetail(ActivityPoint point) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 2,
                  width: size.width * 0.1,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RichText(
                  text: TextSpan(
                      text: "• ",
                      style: TextStyle(color: point.approval_Status == 'Pending'? colorYellow : colorGreenDark, fontSize: 20),
                      children: <TextSpan>[
                    TextSpan(
                      text: "Status : " + point.approval_Status.toString(),
                      style: textStyle(point.approval_Status == 'Pending'? colorYellow : colorGreenDark, 20, FontWeight.w800),
                    )
                  ])),
              SizedBox(
                height: 20,
              ),
              Text("Activity Points : " + point.activity_Point.toString(),
                  style: textStyle(black, 20, FontWeight.w800)),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 1,
                  width: size.width * 1,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 20),
              Text("Details", style: textStyle(black, 20, FontWeight.w800)),
              SizedBox(height: 20),
              Text(point.main_Heading_Index.toString(),
                  style: textStyle(black, 20, FontWeight.w500)),
              SizedBox(height: 20),
              Text(point.sub_Heading_Index.toString(), style: textStyle(black, 20, FontWeight.w500)),
              SizedBox(height: 20),
              Text(point.assign_Activity_Index.toString(),
                  style: textStyle(black, 18, FontWeight.w500)),
              SizedBox(height: 20),
              Text("Semester : " + point.semester.toString(),
                  style: textStyle(black, 16, FontWeight.w500)),
              SizedBox(height: 20),
              Text("Event Date : " + point.event_Date,
                  style: textStyle(black, 16, FontWeight.w500)),
            ],
          )),
    );
  }
}
