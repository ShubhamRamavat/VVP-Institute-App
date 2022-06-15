
import 'package:flutter/material.dart';


import '../services/style.dart';

class Notification_Settings extends StatefulWidget {
  const Notification_Settings({Key? key}) : super(key: key);

  @override
  State<Notification_Settings> createState() => _Notification_SettingsState();
}

class _Notification_SettingsState extends State<Notification_Settings> {
  bool notification_status = false;

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
          "Notification Settings",
          style: appbarText(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notification",
                  style: textStyle(black, 20, FontWeight.w800),
                ),
                Switch(
                  activeColor: blue,
                  value: notification_status,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      notification_status = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
