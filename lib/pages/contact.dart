import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:vvp/services/service_connection.dart';
import 'package:vvp/services/style.dart';
import '../services/service_faculty_contact.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class ContactService{
  static String url = ConnectionConstant.contacts;

  static Future getUsers() async {
    http.Response response = await http.get(
        Uri.parse(url),
        headers: {"Accept": "application/json"})
        .timeout(const Duration(seconds: 15),
      onTimeout: () {
        return http.Response('Request Time OUT', 408); // Request Timeout response status code
      },);

    print(response.statusCode);
    List jsonUser = json.decode(response.body);
    print(jsonUser);
    print(jsonUser.map((e) => new Users.fromJson(e)).toList());
    return jsonUser.map((e) => new Users.fromJson(e)).toList();
  }
}

class _ContactState extends State<Contact> {


  Widget _contactCards(String faculty_name, String department, int mobile_no,
      int whatsapp_no, String email, Size size) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      borderOnForeground: true,
      child: Container(
        height: 160,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                faculty_name,
                style: textStyle(black, 20, FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 2, bottom: 5),
              child: Text(
                department + " Department",
                style: textStyle(black, 17, FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 5, right: 5),
              height: 1,
              width: size.width * 0.9,
              color: Colors.black,
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    color: Colors.transparent,
                    onPressed: () {
                      UrlLauncher.launch('tel:+91${mobile_no.toString()}');
                    },
                    child: Column(
                      children: [
                        Icon(Icons.call, color: color_call),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text("Call",
                            style: textStyle(color_call, 14, FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    color: Colors.transparent,
                    onPressed: () {
                      UrlLauncher.launch("https://wa.me/+91$whatsapp_no");
                    },
                    child: Column(
                      children: [
                        Icon(MdiIcons.whatsapp, color: color_wp),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text("Whatsapp",
                            style: textStyle(color_wp, 14, FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    color: Colors.transparent,
                    onPressed: () {
                      UrlLauncher.launch('mailto:$email');
                    },
                    child: Column(
                      children: [
                        Icon(Icons.mail, color: color_mail),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text("Email",
                            style: textStyle(color_mail, 14, FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
          "Contact Diary",
          style: appbarText(),
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                child: TextField(
                  // controller: usernameController,
                  style: textStyle(black, 15, FontWeight.w800),
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.search, color: Colors.grey, size: 20),
                    hintText: "Search",
                    hintStyle: textStyle(Colors.grey, 15, FontWeight.w800),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    fillColor: white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: StreamBuilder(
                      stream: UserManager().contactListView,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Container(
                            child: Center(
                              child: SpinKitFadingCube(
                                color: Colors.blue,
                                size: 50.0,
                              ),//new Text("Loading...."),
                            ),
                          );
                        }
                        else if(snapshot.connectionState == ConnectionState.done){
                          if (snapshot.data != null) {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(snapshot.data[index]);
                                return _contactCards(
                                    snapshot.data[index].faculty_name,
                                    snapshot.data[index].department,
                                    snapshot.data[index].mobile,
                                    snapshot.data[index].whatsapp,
                                    snapshot.data[index].email,
                                    size);
                              },
                            );
                          } else {
                            return Container(
                              child: Center(
                                child: Text("No Data Found"),
                              ),
                            );
                          }
                        }
                        else if(snapshot.hasError)
                        {
                          return Container(
                            child: Center(
                              child: Text("Error Occurred!"),
                            ),
                          );
                        }
                        else
                          return Container(
                            child: Center(
                              child: Text("Something went wrong. Try again later!"),
                            ),
                          );

                      },
                    )),
              ),
            ],
          ),
        ));
  }
}
