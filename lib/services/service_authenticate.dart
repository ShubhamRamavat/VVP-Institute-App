import 'dart:convert';

import 'package:vvp/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vvp/services/service_connection.dart';
import 'package:vvp/services/service_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dbcrypt/dbcrypt.dart';

class Auth extends StatefulWidget{

  late String url;
  late String username;
  late String password;

  Auth({required this.url, required this.username, required this.password});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  late SharedPreferences authenticationData;

  getPref() async{
    authenticationData = await SharedPreferences.getInstance();
  }

  Future<dynamic> getUsers() async{
    try{
      print("fetching");
      http.Response response = await http.get(
          Uri.parse(ConnectionConstant.login),
          headers: {
            "Accept": "application/json",
          }
      ).timeout(const Duration(seconds: 2),
        onTimeout: () {
          return http.Response('Request Time OUT', 408); // Request Timeout response status code
        },);

      var json = jsonDecode(response.body);
      print(json);
      return json;
    }
    catch(e){
      print(e);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // if(snapshot.connectionState == ConnectionState.done){
            //   print("connection done");
            if (snapshot.hasData) {
              print("snapshot has data");
              getPref();
              var jsonUser = snapshot.data;

              List user = [];
              for (var u in jsonUser) {
                user.add(u['username']);
              }
              print(user);

              if (user.indexOf(widget.username) == -1) {
                showAlertDialog(
                    context, 'VVP Institute', 'User does not exists');
              }
              else {
                var pass = jsonUser[user.indexOf(
                    widget.username)]['password_hash'];
                print("pass " + pass);
                var isCorrect = new DBCrypt().checkpw(widget.password, pass);
                print("is correct : ");
                print(isCorrect);
                if (isCorrect == true) {
                  authenticationData.setBool('login', false);
                  authenticationData.setString('username', widget.username);
                  authenticationData.setString('password', widget.password);

                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext ctx) => Dashboard()));
                }
                else
                  showAlertDialog(context, 'VVP Institue', 'Invalid password');
              }
            }
          // }
            else if(snapshot.hasError){
              showAlertDialog(context, 'VVP Institue', 'Something went wrong!');
              print(snapshot.hasError.toString());
            }
            return Center(
              child: Text("LOADING"),
              // SpinKitRotatingCircle(
              //   color: Colors.blue,
              //   size: 50.0,
              // ),
            );

          },
        ),
      ),
    );
  }
}