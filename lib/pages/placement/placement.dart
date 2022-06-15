import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vvp/pages/placement/view_company_details.dart';
import 'package:vvp/services/service_connection.dart';
import 'package:vvp/services/service_placement_company.dart';
import 'package:vvp/services/style.dart';
import 'package:http/http.dart' as http;

class Placement extends StatefulWidget {
  const Placement({Key? key}) : super(key: key);

  @override
  _PlacementState createState() => _PlacementState();
}

class _PlacementState extends State<Placement> {

  String url =  ConnectionConstant.placement;
  Future<List<PlacementCompany>> getData() async{
    // String token;
    List<PlacementCompany> companyList = [];
    try{
      http.Response response = await http.get(
          Uri.parse(url),
          headers:{
            "Accept": "application/json"
          }
      );

      var jsonList = json.decode(response.body);
      print(jsonList);

      for(var j in jsonList){
        PlacementCompany obj = new PlacementCompany(
            company_id: j["Company_Id"] as int,
            company_name: j["Name_Of_Company"],
            company_detail: j["Company_Details"],
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
      print (companyList.length);
    }catch(e){
      print(e);
    }
    return companyList;
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
          "Placement",
          style: appbarText(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Campus Drive Details",
              style: textStyle(black, 24, FontWeight.w800)
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              // controller: usernameController,
              style: textStyle(black, 15, FontWeight.w500),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                hintText: "Search",
                hintStyle: textStyle(Colors.grey, 15, FontWeight.w500),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // _placementCard(),
            // _placementCard(),
            // _placementCard()
            Expanded(
              flex: 1,
              child: Container(
                child: FutureBuilder(
                  future: getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.data == null){
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Center(
                            child: SpinKitFadingCube(
                              color: Colors.blue,
                              size: 50.0,
                            ),
                          ),
                        );
                      }
                      else{
                        return SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index){
                                return _placementCard(snapshot.data[index] as PlacementCompany);
                          }),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _placementCard(PlacementCompany placementCompany) {

    Size size = MediaQuery.of(context).size;

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewCompanyDetails( placementCompany: placementCompany),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
        ),
        width: size.width * 1,
        child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text( placementCompany.company_name,
                  // "Company Name",
                  style: textStyle(black, 17, FontWeight.w500)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Text(placementCompany.job_title,
                  // "Job Title",
                  style: textStyle(black, 22, FontWeight.w800)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( placementCompany.venue,
                      // "Venue",
                      style: textStyle(Colors.grey, 17, FontWeight.w500),
                    ),
                    Text(placementCompany.interview_date_time,
                      // "Date & Time",
                      style: textStyle(Colors.grey, 17, FontWeight.w500)
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
