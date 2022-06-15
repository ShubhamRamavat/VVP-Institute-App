// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:vvp/services/service_instruction.dart';
import 'package:vvp/services/style.dart';
import 'package:http/http.dart' as http;
import '../../services/service_connection.dart';

class Instructions extends StatefulWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  bool showvalue = false;
  String dropdownValue = 'All';
  String url = ConnectionConstant.instruction;

  Future<List<Instruction>> getData() async{
    // String token;
    List<Instruction> instructionList = [];
    print("fetching...");

    try{
      http.Response response = await http.get(
          Uri.parse(url),
          headers:{
            "Accept": "application/json"
          }
      );
      var jsonList = json.decode(response.body);

      for(var instruct in jsonList){
        Instruction obj = new Instruction(
            instruction_id: instruct["Instruction_Id"],
            instruction_type: instruct["Instruction_Type"],
            instruction_sem: instruct["Instruction_Sem"],
            instruction_branch: instruct["Instruction_Branch"],
            instruction_datetime: DateTime.parse(instruct["Instruction_Datetime"]),
            instruction_title: instruct["Instruction_Title"],
            instruction_sender: instruct["Instruction_Sender"],
            instruction_description: instruct["Instruction_Description"],
            instruction_delete: instruct["Instruction_Delete"],
            instruction_isFeatured: instruct["Instruction_IsFeatured"]);
        instructionList.add(obj);
      }
      print (instructionList.length);

    }catch(e){
      print(e);
    }
    return instructionList;
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
          "Instructions",
          style: appbarText(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.6,
                      child: TextField(
                        // controller: usernameController,
                        style: textStyle(black, 15, FontWeight.w800),
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey, size: 20),
                          hintText: "Search",
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
                      ),
                    ),
                    Container(
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, top: 5),
                        child: DropdownButton(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: textStyle(black, 15, FontWeight.w800),
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['All', 'Instructions', 'Events']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.data == null){
                        return Container(
                          child: Center(
                            child: SpinKitFadingCube(
                              color: Colors.blue,
                              size: 50.0,
                            ),
                          ),
                        );
                      }
                      else{

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index){
                              Instruction i = snapshot.data[index];

                              if(dropdownValue == 'Instructions'){
                                print("0" + dropdownValue);
                                if(i.instruction_type == 0){
                                  if(i.instruction_datetime.compareTo(DateTime.now()) == 0){
                                    return Container(
                                      child: Row(
                                        children: [
                                          // SizedBox(
                                          //   height: 30,
                                          //   child: Text("Today",
                                          //       style: textStyle(Colors.grey.shade700, 18, FontWeight.w500)),
                                          // ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Expanded(child: _intructionsCard(i)),
                                        ],
                                      ),
                                    );
                                  }else{
                                    return Container(
                                      child: Row(
                                        children: [
                                          // SizedBox(
                                          //   height: 30,
                                          //   child: Text("Previous",
                                          //       style: textStyle(Colors.grey.shade700, 18, FontWeight.w500)),
                                          // ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Expanded(child: _intructionsCard(i)),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }
                              else if(dropdownValue == 'Events'){
                                print("1" + dropdownValue);
                                if(i.instruction_type == 1){
                                  if(i.instruction_datetime.compareTo(DateTime.now()) == 0){
                                    return Container(
                                      child: Row(
                                        children: [
                                          // SizedBox(
                                          //   height: 30,
                                          //   child: Text("Today",
                                          //       style: textStyle(Colors.grey.shade700, 18, FontWeight.w500)),
                                          // ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Expanded(child: _intructionsCard(i)),
                                        ],
                                      ),
                                    );
                                  }else{
                                    return Container(
                                      child: Row(
                                        children: [
                                          // SizedBox(
                                          //   height: 30,
                                          //   child: Text("Previous",
                                          //       style: textStyle(Colors.grey.shade700, 18, FontWeight.w500)),
                                          // ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Expanded(flex: 1,child: _intructionsCard(i)),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }

                                if(i.instruction_datetime.compareTo(DateTime.now()) == 0){
                                  return Container(
                                    child: Row(
                                      children: [
                                        // SizedBox(
                                        //   height: 30,
                                        //   child: Text("Today",
                                        //       style: textStyle(Colors.grey.shade700, 18, FontWeight.w500)),
                                        // ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Expanded(child: _intructionsCard(i)),
                                      ],
                                    ),
                                  );
                                }
                                else{
                                  return Container(
                                    child: Row(
                                      children: [
                                        // SizedBox(
                                        //   height: 30,
                                        //   child: Text("Previous",
                                        //       style: textStyle(Colors.grey.shade700, 18, FontWeight.w500)),
                                        // ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Expanded(child: _intructionsCard(i)),
                                      ],
                                    ),
                                  );
                                }
                              }
                            );
                      }
                    }),

                  // _intructionsCard(),

          ]),
        ),
      ),
    );
  }

  String checkDay(DateTime dt){
    if(dt.compareTo(DateTime.now()) == 0)
      return "Today";
    else{
      return DateFormat('EEEE').format(dt).toString();
    }
  }


  Widget _intructionsCard(Instruction i) {

    Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () => _showInstruction(i),
      child: Container(
        margin: EdgeInsets.only(bottom: 14),
        width: double.infinity,
        padding: EdgeInsets.only(left: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
          color: i.instruction_type == 0? colorBlueDark : colorGreenDark  ,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            color: i.instruction_type == 0? colorBlueLight : colorGreenLight ,
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Date day
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Text(DateFormat("hh:mm a").format(i.instruction_datetime).toString() + "  " + checkDay(i.instruction_datetime),
                      style: textStyle(black, 14, FontWeight.w500)),
                ),
                //instruction title
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Text(i.instruction_title,
                      style: textStyle(black, 22, FontWeight.w800)),
                ),
                //sendername
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 20),
                  child: Text(
                    i.instruction_sender,
                    style: textStyle(black, 16, FontWeight.w800),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  void _showInstruction(Instruction i) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size.height * 0.8,
            child: Container(
              // padding: EdgeInsets.only(top:20),
              child: _instructionDetail(i),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          );
        });
  }

  SingleChildScrollView _instructionDetail(Instruction i) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 2,
                  width: size.width * 0.1,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //"Instruction Title"
              Text(i.instruction_title,
                  style: textStyle(black, 22, FontWeight.w800)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Sender Name
                  Text(i.instruction_sender,
                      style: textStyle(black, 18, FontWeight.w800)),
                  Text(DateFormat("hh:mm a").format(i.instruction_datetime).toString() + "  " + checkDay(i.instruction_datetime),
                      style: textStyle(Colors.grey, 14, FontWeight.w500)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //Detail instruction.
              Text(
                   i.instruction_description,
                  style: textStyle(black, 14, FontWeight.w500)),
              SizedBox(height: 20),
            ],
          )),
    );
  }
}
