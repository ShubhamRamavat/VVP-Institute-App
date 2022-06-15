import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vvp/pages/profile/profile.dart';
import 'package:vvp/services/style.dart';

import '../../services/service_dialog.dart';

class Drawer_Header extends StatefulWidget {
  @override
  _Drawer_HeaderState createState() => _Drawer_HeaderState();
}

class _Drawer_HeaderState extends State<Drawer_Header> {

  var username;
  var s_email;
  initState() {
    getData();
  }
  getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        username = prefs.getString('username')!;
        print('username : ' + username);
        
        s_email = prefs.getString('email')!;
        print('email : ' + s_email);
      });
    } catch (e) {
      showAlertDialog(context, 'VVP Institute', e.toString());
    }
  }

  final email = 'sarah@abs.com';
  final urlImage =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 2,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 54, horizontal: 20),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/images/dummy_profile.png')),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username!,
                    style: textStyle(black, 20, FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  // FittedBox(
                  //   child: Text(
                  //     s_email!,
                  //     style: textStyle(Colors.grey.shade600, 14, FontWeight.w800),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
