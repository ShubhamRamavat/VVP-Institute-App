import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String alertTitle, String alretContent) {
  // Create button
  // ignore: deprecated_member_use
  Widget okButton = FlatButton(
    child: Text("OKAY", style: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold),),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(alertTitle, style: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold),),
    content: Text(alretContent, style: TextStyle(
        fontSize: 16, ),),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}