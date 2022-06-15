import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/style.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart' as http;


class Add_Activity extends StatefulWidget {
  const Add_Activity({Key? key}) : super(key: key);

  @override
  State<Add_Activity> createState() => _Add_ActivityState();
}

class _Add_ActivityState extends State<Add_Activity> {
  int major_activity = 0;
  int sub_activity = 0;
  int assign_activity_lvl = 0;
  int activity_semester = 1;
  int is_winner = 0;
  String class_teacher = 'Faculty Name 1';
  late String eventDate ;
  
  DateTime now = DateTime.now();
  

  TextEditingController descController = new TextEditingController();
  TextEditingController remarkController = new TextEditingController();

  Future<void> createActivity() async {
  
    String formattedDate = DateFormat('EEE d MMM kk:mm:ss').format(now);
    
    print(major_activity);
    print(sub_activity);
    print(assign_activity_lvl);
    print(activity_semester);
    print(is_winner);
    print(class_teacher);
    print(eventDate);
    print(descController.text);
    print(remarkController.text);

    http.Response response = await http.post(
                          Uri.parse(
                              "http://6ce8-2409-4041-6d87-e456-14f4-5626-6440-8c08.ngrok.io/VVP_API/web/member/create"),
                          body: {
                            "Main_Heading_Index": major_activity.toString(),
                            "Description": descController.text,
                            "Sub_Heading_Index": sub_activity.toString(),
                            "Assign_Activity_Index": assign_activity_lvl.toString(),
                            "Event_Date": eventDate,
                            "Winner": is_winner.toString(),
                            "Approval_By":class_teacher,
                            "Remarks":remarkController.text,
                            "Verified_Date_Time":formattedDate,
                            // "file": file,
                          });
  }

  var list_major_activity = [
    'Bridge Course',
    'Technical/Research Skill',
    'Sports and Cultrual ',
  ];
  var list_sub_activity = [
    'Sports',
    'Cultrual',
  ];
  var list_assign_activity_lvl = [
    'College Level',
    'Zonal Level',
  ];
  var list_class_teacher = [
    'Faculty Name 1',
    'Faculty Name 2',
  ];

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
          "Add Activity Points",
          style: appbarText(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
// <--------------------------- Major Activity ----------------------------->
              Text("Major Activity",
                  style: textStyle(black, 18, FontWeight.w800)),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: major_activity,
                style: textStyle(black, 16, FontWeight.w500),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: list_major_activity.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    major_activity = list_major_activity.indexOf(newValue as String);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Sub Activity ----------------------------->
              Text("Sub Activity",
                  style: textStyle(black, 18, FontWeight.w800)),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: sub_activity,
                style: textStyle(black, 16, FontWeight.w500),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: list_sub_activity.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    sub_activity = list_sub_activity.indexOf(newValue as String);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Assign Activity Level ----------------------------->
              Text("Assign Activity Level",
                  style: textStyle(black, 18, FontWeight.w800)),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: assign_activity_lvl,
                style: textStyle(black, 16, FontWeight.w500),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: list_assign_activity_lvl.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    assign_activity_lvl = list_assign_activity_lvl.indexOf(newValue as String);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Description ----------------------------->
              Text(
                'Description',
                style: textStyle(black, 18, FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                minLines: 3,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                controller: descController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: blue, width: 0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: blue, width: 0),
                  ),
                ),
                style: textStyle(black, 16, FontWeight.w500),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Activity Semester ----------------------------->
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Activity Semester",
                      style: textStyle(black, 18, FontWeight.w800)),
                  Container(
                    width: 100,
                    // height: 80,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: activity_semester,
                      style: textStyle(black, 16, FontWeight.w500),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: <String>['1', '2', '3', '4', '5', '6', '7', '8']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          activity_semester = newValue as int;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Event Date ----------------------------->
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Event Date',
                    style: textStyle(black, 18, FontWeight.w700),
                  ),
                  Container(
                    width: size.width * 0.5,
                    child: DateTimePicker(
                      style: textStyle(black, 15, FontWeight.w800),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month,
                            color: Colors.grey, size: 20),
                        hintText: "Date",
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
                      initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onChanged: (val) {
                        setState(() {
                          eventDate = val;
                        });
                      },
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val)  {
                        setState(() {
                          eventDate = val as String;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Winner ----------------------------->
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Winner", style: textStyle(black, 18, FontWeight.w800)),
                  Container(
                    width: 100,
                    // height: 80,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: is_winner,
                      style: textStyle(black, 16, FontWeight.w500),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: <String>[
                        'No',
                        'Yes',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          is_winner = newValue as int;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Remarks ----------------------------->
              Text(
                'Remarks',
                style: textStyle(black, 18, FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                minLines: 3,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                controller: remarkController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: blue, width: 0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: blue, width: 0),
                  ),
                ),
                style: textStyle(black, 16, FontWeight.w500),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Attach File ----------------------------->
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
                      "No file Chosen",
                      style: textStyle(black, 14, FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Class Teacher ----------------------------->
              Text("Class Teacher",
                  style: textStyle(black, 18, FontWeight.w800)),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: class_teacher,
                style: textStyle(black, 16, FontWeight.w500),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: list_class_teacher.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    class_teacher = newValue as String;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
// <--------------------------- Save Button ----------------------------->
              Center(
                child: SizedBox(
                  height: 50,
                  width: size.width * 1,
                  child: RaisedButton(
                    onPressed: () {
                      createActivity();
                    },
                    child: Text("Save",
                        style: textStyle(white, 16, FontWeight.w800)),
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
      ),
    );
  }
}
