import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vvp/pages/grievance_cell/compose_mail.dart';
import 'package:vvp/pages/logout.dart';

import '../../services/style.dart';
import '../activity_points/add_activity.dart';
import '../login.dart';
import '../notification_settings.dart';

class Drawer_List extends StatefulWidget {
  const Drawer_List({Key? key}) : super(key: key);

  @override
  State<Drawer_List> createState() => _Drawer_ListState();
}

class _Drawer_ListState extends State<Drawer_List> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 12),
          buildMenuItem(
            text: 'Notificaions',
            icon: Icons.notifications,
            onClicked: () => selectedItem(context, 0),
          ),
          const SizedBox(height: 4),
          buildMenuItem(
            text: 'Compose Grievance',
            icon: Icons.send,
            onClicked: () => selectedItem(context, 1),
          ),
          const SizedBox(height: 4),
          buildMenuItem(
            text: 'Add Activity Points',
            icon: Icons.star_rate_rounded,
            onClicked: () => selectedItem(context, 2),
          ),
          const SizedBox(height: 4),
          buildMenuItem(
            text: 'Log Out',
            icon: Icons.logout,
            onClicked: () async {
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
                //() => selectedItem(context, 3),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = black;
    final hoverColor = black;

    return ListTile(
      leading: Icon(icon, color: color,),
      title: Text(text, style: textStyle(black, 14, FontWeight.w500)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Notification_Settings(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ComposeMail(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Add_Activity(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Logout(),
        ));
        break;
    }
  }
}
