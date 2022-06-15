import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vvp/pages/profile/edit_placement_profile.dart';
import 'package:vvp/services/service_placement_company.dart';
import 'package:vvp/services/style.dart';
import 'package:http/http.dart' as http;
import '../../services/service_connection.dart';
import '../placement/view_company_details.dart';

class Placement_Profile extends StatefulWidget {
  const Placement_Profile({Key? key}) : super(key: key);

  @override
  _Placement_ProfileState createState() => _Placement_ProfileState();
}

class _Placement_ProfileState extends State<Placement_Profile> {
  PlacementCompany? p;
  Future<List<PlacementCompany>> getData() async {
    // String token;
    List<PlacementCompany> companyList = [];
    try {
      http.Response response = await http.get(
          Uri.parse(ConnectionConstant.placement),
          headers: {"Accept": "application/json"});

      var jsonList = json.decode(response.body);
      print(jsonList);

      for (var j in jsonList) {
        PlacementCompany obj = new PlacementCompany(
          company_id: j["Company_Id"] as int,
          company_name: j["Name_Of_Company"],
          company_detail: j["Company_Details"]!,
          interview_date_time: j["Interview_Date"] + "  " + j["Interview_Time"],
          venue: j["Interview_Venue"],
          job_title: j["Job_Title"],
          job_description: j["Job_Description"],
          package_CTC: j["Package_CTC"].toDouble(),
          security_deposite: j["Security_Deposite"],
          bond_duration: j["Bond_Duration"],
          registration_last_date: j["Registration_Last_Date"],
        );
        companyList.add(obj);
      }
      print(companyList.length);
      print(companyList);
      for (PlacementCompany c in companyList) {
        print(c.company_name);
      }
    } catch (e) {
      print(e);
    }

    return companyList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
        title: Text("Placement Profile", style: appbarText()),
        backgroundColor: blue,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 50,
                  width: size.width * 0.9,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Edit_Placement_Profile(),
                        ),
                      );
                    },
                    child: Text("Edit Placement Profile",
                        style: textStyle(blue, 17, FontWeight.w500)),
                    color: Colors.white,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: blue)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text("Intersted Companies",
                  style: textStyle(black, 22, FontWeight.w800)),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: SpinKitFadingCube(
                            color: Colors.blue,
                            size: 50.0,
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
                              return _Container_Placement(
                                  placementCompany:
                                      snapshot.data[index] as PlacementCompany);
                            }),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class _Container_Placement extends StatelessWidget {
  // const _Container_Placement({
  //   Key? key,
  // }) : super(key: key);
  PlacementCompany placementCompany;
  _Container_Placement({required this.placementCompany});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewCompanyDetails(
              placementCompany: placementCompany,
            ),
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
        margin: EdgeInsets.only(top: 10, bottom: 5),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                    //"Company Name",
                    placementCompany.company_name,
                    style: textStyle(black, 17, FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Text(
                    //"Job Title",
                    placementCompany.job_title,
                    style: textStyle(black, 22, FontWeight.w800)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // "Venue",
                      placementCompany.venue,
                      style: textStyle(Colors.grey, 17, FontWeight.w500),
                    ),
                    Text(
                        //"Date & Time",
                        placementCompany.interview_date_time,
                        style: textStyle(Colors.grey, 17, FontWeight.w500)),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
