import 'package:flutter/material.dart';
import 'package:vvp/pages/profile/profile.dart';
import 'package:vvp/services/style.dart';

import '../activity_points/add_activity.dart';
import 'drawer_header.dart';
import 'drawer_list.dart';
import '../notification_settings.dart';

class Nav_Drawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: white,
        child: ListView(
          children: <Widget>[
            //Header of Drawer---------------
            Drawer_Header(),
            //List of Drawer---------------
            Drawer_List(),
          ],
        ),
      ),
    );
  }
}