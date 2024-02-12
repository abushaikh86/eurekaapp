// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, constant_identifier_names

import 'dart:async';
import 'package:eureka/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eureka/login.dart';
import 'package:eureka/util/constants.dart' as constants;
// import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const String KEY_LOGIN = "login";
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Color?> _colorAnimation;
  var time = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: time),
    );

    animation = Tween<double>(begin: 1.0, end: 1.0).animate(controller);
    _colorAnimation = ColorTween(
      begin: Colors.white, // Initial color (white)
      end: Colors.green, // Final color (green)
    ).animate(controller);

    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // The animation has completed; you can navigate to the next screen here
      }
    });
    loginCheck();

  }

  Future<void> loginCheck() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    var isLogged = sharedPrefs.getBool(KEY_LOGIN);
    // var studentId = sharedPrefs.getInt('student_id');

    Timer(Duration(seconds: time), () {
      if (isLogged != null && isLogged) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("EUREKA", style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold, color: constants.mainColor),),
              SizedBox(height: 100),
              FadeTransition(
                opacity: animation,
                child: Image.asset(
                  'assets/splash_bg.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width-20,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 50.0,
                height: 50.0,
                // child: CircularProgressIndicator(
                //   valueColor: _colorAnimation,
                //   strokeWidth: 5.0,
                // ),
              ),
              ElevatedButton(
                onPressed: () async {
    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => Login()));

                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  primary: constants
                      .secColor, // Set the button's background color
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 4, // Add some elevation
                  padding: EdgeInsets.only(left: 100,right: 100,top:15,bottom: 15)
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
                ),
              ),
              // FadeTransition(
              //   opacity: animation,
              //   child: Text(
              //     'Plus Point',
              //     style: GoogleFonts.robotoMono(
              //       textStyle: TextStyle(
              //         color: Colors.white,
              //         fontSize: 30,
              //         fontWeight: FontWeight.w600,
              //         fontStyle: FontStyle.italic,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
