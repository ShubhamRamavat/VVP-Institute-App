import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vvp/services/service_connection.dart';

import '../../services/service_library_data.dart';
import '../../services/style.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  String url = ConnectionConstant.library;
  Future<List<LibraryData>> getLibrary() async {

    http.Response response = await http.get(
        Uri.parse(
            url),
        headers: {"Accept": "application/json"});

    var jsonUser = json.decode(response.body);

    List<LibraryData> libraryList = [];
    for (var u in jsonUser) {
      LibraryData obj = new LibraryData(
          u['Book_Id'],
          u['Book_First_Author_Name'],
          u['Book_Title'],
          u['Accession_No'],
          u['Book_Status_Id'],
          u['Book_Publication_Id'],
          u['Department_Id'],
          u['Attachment_Filename']);
      libraryList.add(obj);
      print(libraryList.length);
    }
    return libraryList;
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
          "Library",
          style: appbarText(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(top:10),
              width: size.width * 1,
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
            Padding(
              padding: const EdgeInsets.only(top:80),
              child: FutureBuilder(
                future: getLibrary(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: SpinKitFadingCube(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          LibraryData libraryData = new LibraryData(
                              snapshot.data[index].book_id,
                              snapshot.data[index].author,
                              snapshot.data[index].bookTitle,
                              snapshot.data[index].acce_no,
                              snapshot.data[index].status,
                              snapshot.data[index].publication,
                              snapshot.data[index].department,
                              snapshot.data[index].image
                              );
                          return _libraryCard(libraryData);
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _libraryCard(LibraryData l) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () => _showBook(l),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(1),
              height: size.height * 0.1,
              width: size.width * 0.15,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              //   border: Border.all(color: Colors.grey, width: 1),
              // ),
              child: Image(
                image: NetworkImage(l.image),
                fit: BoxFit.cover,
              ),
            ),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Text(l.bookTitle,
                        style: textStyle(black, 22, FontWeight.w800)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 20),
                    child: Text(
                      l.author,
                      style: textStyle(black, 16, FontWeight.w500),
                    ),
                  ),
                ]),
            Spacer(),
            IconButton(
                onPressed: () {
                  _showBook(l);
                },
                icon: Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  void _showBook(LibraryData l) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size.height * 0.85,
            child: Container(
              child: _bookDetail(l),
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

  SingleChildScrollView _bookDetail(LibraryData l) {
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
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(1),
                      height: size.height * 0.2,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade500,
                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                        // border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Image(
                        image: NetworkImage(l.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(l.author,
                        style: textStyle(Colors.grey, 20, FontWeight.w800)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(l.bookTitle,
                        style: textStyle(black, 26, FontWeight.w800)),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        height: 1,
                        width: size.width * 1,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Text("About Book", style: textStyle(black, 20, FontWeight.w800)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Accession No.",
                          style: textStyle(Colors.grey, 16, FontWeight.w500)),
                      SizedBox(height: 4),
                      Text(l.acce_no,
                          style: textStyle(black, 20, FontWeight.w600)),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey.shade500,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Status",
                            style: textStyle(Colors.grey, 16, FontWeight.w500)),
                        SizedBox(height: 4),
                        Text(l.status.toString(),
                            style: textStyle(black, 20, FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text("Publication",
                  style: textStyle(Colors.grey, 16, FontWeight.w500)),
              SizedBox(height: 4),
              Text(l.publication.toString(),
                  style: textStyle(black, 20, FontWeight.w600)),
              SizedBox(height: 30),
              Text("Department Name",
                  style: textStyle(Colors.grey, 16, FontWeight.w500)),
              SizedBox(height: 4),
              Text(l.department.toString(), style: textStyle(black, 20, FontWeight.w600)),
            ],
          )),
    );
  }
}
