// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vvp/services/service_placement_company.dart';
import 'package:vvp/services/style.dart';

class ViewCompanyDetails extends StatefulWidget {
  // const ViewCompanyDetails({Key? key}) : super(key: key);

  PlacementCompany placementCompany;
  ViewCompanyDetails({required this.placementCompany});

  @override
  _ViewCompanyDetailsState createState() => _ViewCompanyDetailsState();
}

class _ViewCompanyDetailsState extends State<ViewCompanyDetails> {

  String lastDate(){
    if(widget.placementCompany.registration_last_date == null)
      return "";
    else
      return "Last Date : " + widget.placementCompany.registration_last_date.toString();
  }
  String bond(){
    if(widget.placementCompany.bond_duration==null)
      return "None";
    else
      return "Yes";
  }
  String bondDetail(){
    if(widget.placementCompany.bond_duration==null)
      return "None";
    else
      return widget.placementCompany.bond_duration.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Company Details",
              style: appbarText()),
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
          backgroundColor: blue,
          elevation: 2,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),

// <--------------------------- Heading ----------------------------->

              Center(
                child: Column(
                  children: [
                    Text( widget.placementCompany.job_title,
                      // "Job Title",
                      style: textStyle(black, 26, FontWeight.w800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text( widget.placementCompany.company_name,
                        // "Company Name",
                        style: textStyle(black, 20, FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    Text( widget.placementCompany.company_detail,
                        // "Company Details",
                        style: textStyle(Colors.grey, 17, FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),

// <--------------------------- date + venue ----------------------------->

              Row(
                children: [
                  Icon(Icons.location_on,
                      size: 22, color: Colors.grey.shade700),
                  SizedBox(
                    width: 20,
                  ),
                  Text( widget.placementCompany.venue,
                    // "Venue",
                    style: textStyle(Colors.grey, 17, FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.calendar_month,
                      size: 22, color: Colors.grey.shade700),
                  SizedBox(
                    width: 20,
                  ),
                  Text( widget.placementCompany.interview_date_time,
                    // "Interview Date & Time",
                    style: textStyle(Colors.grey, 17, FontWeight.w500)
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42, top: 3),
                child: Text(lastDate(),
                  //     "Date",
                  style: textStyle(Colors.grey, 17, FontWeight.w500)
                ),
              ),
              SizedBox(
                height: 30,
              ),

// <--------------------------- Job Details ----------------------------->

              Text("Job Description",
                  style: textStyle(black, 18, FontWeight.w800)),
              SizedBox(
                height: 10,
              ),
              Text(widget.placementCompany.job_description,
                  style: textStyle(Colors.grey, 15, FontWeight.w500)),
              SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(
                      text: "• ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: <TextSpan>[
                    TextSpan(
                      text: "Package CTC : " + widget.placementCompany.package_CTC.toString(),
                      style: textStyle(black, 15, FontWeight.w500),
                    )
                  ])),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      text: "• ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: <TextSpan>[
                    TextSpan(
                      text: "Bond : " + bond(),
                      style: textStyle(black, 15, FontWeight.w500),
                    )
                  ])),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      text: "• ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: <TextSpan>[
                    TextSpan(
                      text: "Bond Details : " + bondDetail(),
                      style: textStyle(black, 15, FontWeight.w500),
                    )
                  ])),
              SizedBox(
                height: 50,
              ),

// <--------------------------- Decision Butttons  ----------------------------->

              Center(
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.done, size: 24, color: Colors.green),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Interested",
                          style: textStyle(Colors.green, 17, FontWeight.w500)
                        ),
                      ],
                    ),
                    color: Colors.white,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.green)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close, size: 24, color: Colors.red),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Not Interested",
                          style: textStyle(Colors.red, 17, FontWeight.w500),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.red)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
