import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vvp/services/service_result.dart';
import 'package:http/http.dart' as http;
import '../services/service_connection.dart';
import '../services/style.dart';

class Results extends StatefulWidget {
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  String result_sem = '5';

  late SharedPreferences authenticationData;

  var jsonResult;

  String url =  ConnectionConstant.result;

  var choose_result = ['1','2','3','4','5','6','7','8'];
  //   'SEM 1','SEM 2','SEM 3','SEM 4','SEM 5','SEM 6','SEM 7','SEM 8'
  // ];
  // var choose_result = {
  //   1:'SEM 1',
  //   2:'SEM 2',
  //   3:'SEM 3',
  //   4:'SEM 4',
  //   5:'SEM 5',
  //   6:'SEM 6',
  //   7:'SEM 7',
  //   8:'SEM 8',
  // };

  @override
  void initState() {
    initialize().whenComplete(() {
      print("Init done");
    });
  }

  Future initialize() async {
    this.authenticationData = await SharedPreferences.getInstance();
    this.jsonResult = await getData();
    print(jsonResult);
  }

  Future getData() async{
      http.Response response = await http.get(
          Uri.parse(url),
          headers:{
            "Accept": "application/json"
          }
      );

      List<Result> resultList = [];
      final jsonList = json.decode(response.body);
      print(jsonList);
      String? username = authenticationData.getString("username");

      for(var res in jsonList){
        if(res["Student_Rollno"].toString().toLowerCase().compareTo(username!.toLowerCase()) == 0
        && res["sem"].toString().compareTo(result_sem.toString()) == 0)
          {
            print("result class");
            // Result r =  new Result(res["EXAMNUMBER"]);
            Result result = new Result(
                st_id: res["St_Id"],
                stu_rollno: res["Student_Rollno"],
                exam_no: res["EXAMNUMBER"],
                exam: res["exam"],
                spi: res["SPI"],
                cpi: res["CPI"],
                cgpa: res["CGPA"],
                total_backl: res["TOTBACKL"],
                curr_backl: res["CURBACKL"],
                result: res["RESULT"],
                sem: res["sem"],
                sub1: res["SUB1"], sub2: res["SUB2"], sub3: res["SUB3"], sub4: res["SUB4"], sub5: res["SUB5"],
                sub6: res["SUB6"], sub7: res["SUB7"], sub8: res["SUB8"], sub9: res["SUB9"], sub10: res["SUB10"],
                sub1_name: res["SUB1NA"], sub2_name: res["SUB2NA"],
                sub3_name: res["SUB3NA"], sub4_name: res["SUB4NA"],
                sub5_name: res["SUB5NA"], sub6_name: res["SUB6NA"],
                sub7_name: res["SUB7NA"], sub8_name: res["SUB8NA"],
                sub9_name: res["SUB9NA"], sub10_name: res["SUB10NA"],
                sub1_grade: res["SUB1GR"], sub2_grade: res["SUB2GR"],
                sub3_grade: res["SUB3GR"], sub4_grade: res["SUB4GR"],
                sub5_grade: res["SUB5GR"], sub6_grade: res["SUB6GR"],
                sub7_grade: res["SUB7GR"], sub8_grade: res["SUB8GR"],
                sub9_grade: res["SUB9GR"], sub10_grade: res["SUB10GR"],
                );
              print("class done");
              resultList.add(result);
              print("added");
          }
          print("roll no: " + res["Student_Rollno"] + " sem: " + res["sem"].toString());
      }
      print(resultList);
      return resultList;
  }

  @override
  Widget build(BuildContext context) {
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
          "Results",
          style: appbarText(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exam Details-----------
              Row(
                children: [
                  Text("Semester : ", style: textStyle(black, 17, FontWeight.w800)),
                  SizedBox(width: 10),
                  DropdownButton(
                    value: result_sem,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: textStyle(black, 15, FontWeight.w500),
                    underline: Container(
                      height: 2,
                    ),
                    items: choose_result.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        result_sem = newValue!;
                        print(result_sem);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),

              FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      var list = snapshot.data;
                      print(list);
                      if(snapshot.data.length != 0){
                        Result r = snapshot.data[0];
                        return Column(
                          children: [
                            Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              columnWidths: const <int, TableColumnWidth>{
                                0: IntrinsicColumnWidth(),
                                1: IntrinsicColumnWidth(),
                                2: FlexColumnWidth(),
                                3: IntrinsicColumnWidth(),
                              },
                              children: [
                                TableRow(children: [
                                  Text("Exam No. : ",
                                      style: textStyle(black, 17, FontWeight.w800)),
                                  SizedBox(width: 10),
                                  Text(r.exam_no.toString(),
                                      style: textStyle(black, 17, FontWeight.w500)),
                                  SizedBox(height: 40),
                                ]),

                                TableRow(children: [
                                  Text("Exam : ",
                                      style: textStyle(black, 17, FontWeight.w800)),
                                  SizedBox(width: 10),
                                  // //It contains 2 Fields Exam + Year-------------
                                  Text(r.exam.toString(),
                                      style: textStyle(black, 17, FontWeight.w500)),
                                  SizedBox(height: 40),
                                ]),

                                TableRow(children: [
                                  Text("Total Backlog : ",
                                      style: textStyle(black, 17, FontWeight.w800)),
                                  SizedBox(width: 10),
                                  Text(r.total_backl.toString(), style: textStyle(black, 17, FontWeight.w500)),
                                  SizedBox(height: 40),
                                ]),

                                TableRow(children: [
                                  Text("Current Backlog : ",
                                      style: textStyle(black, 17, FontWeight.w800)),
                                  SizedBox(width: 10),
                                  Text(r.curr_backl.toString(), style: textStyle(black, 17, FontWeight.w500)),
                                  SizedBox(height: 40),
                                ]),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            // Result Table-----------
                            Table(
                              border: TableBorder.all(color: Colors.blueGrey),
                              columnWidths: const <int, TableColumnWidth>{
                                0: IntrinsicColumnWidth(),
                                1: FlexColumnWidth(),
                                2: FixedColumnWidth(80),
                              },
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    Container(
                                      height: 60,
                                      color: Color.fromARGB(255, 35, 59, 83),
                                      child: Center(
                                          child: Text("SUBJECT CODE",
                                              style: textStyle(white, 15, FontWeight.w800))),
                                    ),
                                    Container(
                                      height: 60,
                                      color: Color.fromARGB(255, 35, 59, 83),
                                      child: Center(
                                          child: Text("SUBJECT NAME",
                                              style: textStyle(white, 15, FontWeight.w800))),
                                    ),
                                    Container(
                                      height: 60,
                                      color: Color.fromARGB(255, 35, 59, 83),
                                      child: Center(
                                          child: Text("GRADE",
                                              style: textStyle(white, 15, FontWeight.w800))),
                                    ),
                                  ],
                                ),
                                row_subject(
                                    r.sub1, r.sub1_name, r.sub1_grade),
                                row_subject(
                                    r.sub2, r.sub2_name, r.sub2_grade),
                                row_subject(
                                    r.sub3, r.sub3_name, r.sub3_grade),
                                row_subject(
                                    r.sub4, r.sub4_name, r.sub4_grade),
                                row_subject(
                                    r.sub5, r.sub5_name, r.sub5_grade),
                                row_subject(
                                    r.sub6, r.sub6_name, r.sub6_grade),
                              ],
                            ),
                            SizedBox(height: 20),

                            // SPI, CPI, CGPA, Result-----------
                            Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(children: [
                                  Text("SPI : ",
                                      style: textStyle(black, 17, FontWeight.w800)),
                                  Text(r.spi.toString(), style: textStyle(black, 17, FontWeight.w500)),
                                  SizedBox(width: 30),
                                  Text("CPI : ",
                                      style: textStyle(black, 17, FontWeight.w800)),
                                  Text(r.cpi.toString(), style: textStyle(black, 17, FontWeight.w500)),
                                ]),
                              ],
                            ),
                            SizedBox(height: 10),
                            Table(
                              children: [
                                TableRow(children: [
                                  Text("CGPA : ",
                                      style: textStyle(black, 17, FontWeight.w800)),
                                  Text(r.cgpa.toString(), style: textStyle(black, 17, FontWeight.w500)),
                                  SizedBox(width: 30),
                                  Text("Result : ",
                                      style: textStyle(black, 17, FontWeight.w800)),
                                  Text(r.result.toUpperCase(), style: textStyle(black, 17, FontWeight.w500)),
                                ]),
                              ],
                            )
                          ],
                        );
                      }
                      return Text("No Data Found");
                    }
                    else
                      return Container(
                        child: Center(
                          child: SpinKitFadingCube(
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        ),
                      );

              }),

            ],
          ),
        ),
      ),
    );
  }

  TableRow row_subject(int sub_code, String sub_name, String sub_grade) {
    return TableRow(
      children: [
        Container(
          height: 60,
          width: 120,
          child: Center(
              child: Text(sub_code.toString(),
                  style: textStyle(black, 15, FontWeight.w500))),
        ),
        Container(
          height: 60,
          width: 128,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: Text(sub_name,
                    style: textStyle(black, 15, FontWeight.w500))),
          ),
        ),
        Container(
          height: 60,
          width: 128,
          child: Center(
              child: Text(sub_grade,
                  style: textStyle(black, 15, FontWeight.w500))),
        ),
      ],
    );
  }
}
