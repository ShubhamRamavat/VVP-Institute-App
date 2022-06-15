// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vvp/services/service_authenticate.dart';
import 'package:vvp/services/service_dialog.dart';
import 'package:vvp/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:dbcrypt/dbcrypt.dart';
import 'package:vvp/services/style.dart';
import 'package:vvp/services/service_connection.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();
  var jsonUser;
  var s_email;
  late SharedPreferences authenticationData;
  late bool loginStatus;
  String url = ConnectionConstant.login;
  String _urlfp =
      'https://cena.vvpedulink.ac.in/esta/web/index.php/user-management/auth/password-recovery';

  @override
  void initState() {
    super.initState();
    initialize().whenComplete(() {
      setState(() {});
    });
  }

  Future getUsers() async {
    try {
      print("fetching");
      http.Response response =
          await http.get(Uri.parse(ConnectionConstant.login), headers: {
        "Accept": "application/json",
      }).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          return http.Response(
              'Request Time OUT', 408); // Request Timeout response status code
        },
      );

      var json = jsonDecode(response.body);
      print(json);
      return json.toList();
    } catch (e) {
      print(e);
    }
  }

  Future initialize() async {
    this.authenticationData = await SharedPreferences.getInstance();
    this.jsonUser = await getUsers();
  }

  Future<int> delay(int sec) async {
    setState(() {
      _isLoading = true;
    });

    int flag = 0; //0-successful login , 1-invalid username, 2-invalid password
    List user = [];
    for (var u in jsonUser) {
      user.add(u['username']);
    }
    print(user);

    if (user.indexOf(usernameController.text.toString()) == -1) {
      flag = 1;
    } 
    else {
      setState(() {
        s_email = jsonUser[user.indexOf(usernameController.text)]['email'];
        print(s_email);
      });
      var pass =
          jsonUser[user.indexOf(usernameController.text)]['password_hash'];
      var isCorrect =
          new DBCrypt().checkpw(passwordController.text.toString(), pass);
      print(isCorrect);
      if (isCorrect == true) {
        flag = 0;
      } else
        flag = 2;
    }
    await Future.delayed(Duration(seconds: sec));
    return flag;
  }

  authenticate() async {
    if (_formKey.currentState!.validate()) {
      int flag = await delay(2);
      setState(() {
        _isLoading = false;
      });
      if (flag == 0) {
        authenticationData.setBool('login', false);

        authenticationData.setString('email', s_email.toString());
        authenticationData.setString(
            'username', usernameController.text.toString());
        authenticationData.setString(
            'password', passwordController.text.toString());

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext ctx) => Dashboard()));
      } else if (flag == 1) {
        showAlertDialog(context, 'VVP Institute', 'Invalid Username');
      } else if (flag == 2) {
        showAlertDialog(context, 'VVP Institue', 'Invalid password');
      } else {
        showAlertDialog(context, 'VVP Institue', 'Something went wrong!');
      }
    }
  }

  void forgetPassword() async {
    print('forget Password');
    if (!await launch(_urlfp)) throw 'Could not launch $_urlfp';
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.06),
                Row(
                  children: [
                    SizedBox(width: size.width * 0.05),
                    SizedBox(
                      height: size.height * 0.17,
                      width: size.width * 0.17,
                      child: Image.asset('assets/images/splash.png'),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text("V.V.P. Institute App",
                        style: textStyle(white, 30, FontWeight.w700)),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.07),
                        Row(
                          children: [
                            SizedBox(width: size.width * 0.06),
                            Text("Login",
                                style: textStyle(black, 35, FontWeight.w700)),
                          ],
                        ),
                        SizedBox(height: size.height * 0.07),

// <--------------------------- Username Textfield ----------------------------->
                        Row(
                          children: [
                            SizedBox(width: size.width * 0.06),
                            Image.asset("assets/icons/avatar.png", width: 25),
                            SizedBox(width: 15),
                            Container(
                              width: size.width * 0.78,
                              child: TextFormField(
                                controller: usernameController,
                                style: textStyle(black, 20, FontWeight.w500),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Username';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  labelStyle: textStyle(
                                      Colors.grey, 20, FontWeight.w500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.05),

// <--------------------------- Password Textfield ----------------------------->

                        Row(
                          children: [
                            SizedBox(width: size.width * 0.06),
                            Image.asset("assets/icons/security.png", width: 30),
                            SizedBox(width: 10),
                            Container(
                              width: size.width * 0.78,
                              child: TextFormField(
                                controller: passwordController,
                                style: textStyle(black, 20, FontWeight.w500),
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: textStyle(
                                      Colors.grey, 20, FontWeight.w500),
                                  contentPadding: EdgeInsets.all(8),
                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        _secureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey),
                                    onPressed: () {
                                      setState(() {
                                        _secureText = !_secureText;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                obscureText: _secureText,
                              ),
                            ),
                          ],
                        ),

// <--------------------------- Forgot Password ----------------------------->

                        SizedBox(height: size.width * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Forgot Password?',
                                style: textStyle(blue, 17, FontWeight.w800),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = forgetPassword,
                              ),
                            ),
                            SizedBox(width: 25),
                          ],
                        ),
                        SizedBox(height: size.width * 0.1),

// <--------------------------- Login Button ----------------------------->

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: blue,
                          ),
                          height: 50,
                          width: size.width * 0.88,
                          child: RaisedButton.icon(
                            icon: _isLoading
                                ? CircularProgressIndicator()
                                : Container(),
                            label: Text(
                              _isLoading ? 'Loading...' : 'Login',
                              style: textStyle(white, 20, FontWeight.w800),
                            ),
                            onPressed: _isLoading ? null : authenticate,
                            color: blue,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
