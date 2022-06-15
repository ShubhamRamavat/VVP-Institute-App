// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vvp/pages/login.dart';
import 'package:vvp/services/style.dart';
import 'dashboard.dart';


class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  late SharedPreferences authenticationData;
  bool loginStatus = true;

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete((){
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    this.authenticationData = await SharedPreferences.getInstance();
    loginStatus = (authenticationData.getBool('login'))!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      splash: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset("assets/images/splash_bg.png", fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.2),
                SizedBox(width: size.width * 0.05),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Welcome To,", style: textStyle(white, 30, FontWeight.bold),),
                ),
                SizedBox(height: size.height * 0.01),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Text("V.V.P. Institute App", style: textStyle(white, 40, FontWeight.bold),),
                  ),
                Center(
                    child: SizedBox(
                      height: size.height * 0.6,
                      width: size.width * 0.6,
                      child: Image.asset("assets/images/splash.png")
                    ),
                  ),
              ],
            ),
        ],
      ),
      nextScreen: loginStatus? Login() : Dashboard(),
      splashIconSize: double.infinity,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
    );
  }
}