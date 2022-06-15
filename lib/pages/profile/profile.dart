import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vvp/pages/profile/placement_profile.dart';

import '../../services/service_dialog.dart';
import '../../services/style.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String username = '';
  String email = '';

  initState() {
    getData();
  }

  getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        username = prefs.getString('username')!;
        email = prefs.getString('email')!;
      });
    } catch (e) {
      showAlertDialog(context, 'VVP Institute', e.toString());
    }
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
          "Profile",
          style: appbarText(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/dummy_profile.png')),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    username,
                    style: textStyle(black, 22, FontWeight.w800),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    email,
                    style: textStyle(Colors.grey, 18, FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Center(
                child: SizedBox(
                  height: 50,
                  width: size.width * 0.9,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Placement_Profile(),
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
          ],
        ),
      ),
    );
  }
}
