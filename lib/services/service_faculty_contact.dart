import 'dart:async';
import 'package:vvp/pages/contact.dart';

class Users {
  int id;
  String faculty_name;
  String department;
  int mobile;
  int whatsapp;
  String email;
  String role;

  Users(this.id, this.faculty_name, this.department, this.mobile, this.whatsapp,
      this.email, this.role);

  Users.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        faculty_name = json['faculty_name'],
        department = json['department'],
        mobile = json['mobile_no'],
        whatsapp = json['whatsapp_no'],
        email = json['email'],
        role = json['role'];
}

class UserManager{
  final StreamController<int> _userCount = StreamController<int>();
  Stream<int> get userCount => _userCount.stream;

  Stream<List<Users>> get contactListView async*{
    List<Users> user = await ContactService.getUsers();
    yield user;
  }
  
  UserManager(){
    contactListView.listen((list) => _userCount.add(list.length));
  }
}