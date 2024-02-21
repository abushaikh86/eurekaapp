// ignore_for_file: non_constant_identifier_names, constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const SUCCESS_MESSAGE = " You will be contacted by us very soon.";

// Api related
const project_url = "http://192.168.0.117/3psap/";
const apiBaseURL = "http://192.168.0.117/3psap/api";
// const socketUrl = "wss://192.168.0.117/3psap/api";
const delayedTime = 30;
const refTime = 6;
const databaseName = "eureka.db";

double Latitude = 0.0;
double Longitude = 0.0;

Color mainColor = Color.fromRGBO(51, 51, 207, 1);
Color secColor = Color.fromRGBO(64, 78, 103, 1);

// Asset Constants
const navBarLogoImage = "images/logo-alt.png";

void Notification(var message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
