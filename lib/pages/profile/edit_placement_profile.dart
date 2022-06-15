import 'package:flutter/material.dart';
import 'package:vvp/services/style.dart';

class Edit_Placement_Profile extends StatefulWidget {
  const Edit_Placement_Profile({Key? key}) : super(key: key);

  @override
  _Edit_Placement_ProfileState createState() => _Edit_Placement_ProfileState();
}

class _Edit_Placement_ProfileState extends State<Edit_Placement_Profile> {
  String intersted = 'Job';

  var items = [
    'Job',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Image(
              image: AssetImage('assets/icons/back_arrow.png'),
              width: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text("Edit Placement Profile", style: appbarText()),
        backgroundColor: blue,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Intersted',
              style: textStyle(black, 20, FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              value: intersted,
              style: textStyle(black, 17, FontWeight.w500),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  intersted = newValue as String;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Upload Resume',
              style: textStyle(black, 20, FontWeight.w800),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 120,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      "Choose File",
                      style: textStyle(blue, 12, FontWeight.w800),
                    ),
                    color: Colors.white,
                    textColor: blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: blue)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Less than 2MB",
                    style: textStyle(black, 12, FontWeight.w800),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("Save",
                      style: textStyle(white, 17, FontWeight.w800)),
                  color: blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
