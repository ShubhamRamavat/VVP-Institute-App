import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/style.dart';
import 'login.dart';

class Logout extends StatefulWidget {
  const Logout({ Key? key }) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image(
            image: AssetImage('assets/icons/back_arrow.png'),
            width: 25,
          ),
          onPressed: () async {
            SharedPreferences prefs =
            await SharedPreferences.getInstance();
            print(prefs.getString('username'));
            prefs.remove('username');
            prefs.remove('password');
            prefs.setBool('login', true);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext ctx) => Login()));
          },
              //() {Navigator.pop(context);},
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "Log Out",
          style: appbarText(),
        ),
      ),
    );
  }
}