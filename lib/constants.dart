import 'package:flutter/material.dart';

//COLORS
class Colorss{
  static const blu01 = Color(0xff2565aa);
  static const blu02 = Color(0xff1c3052);
  static const gray01 = Color(0xffbbbbbb);
  static const gray02 = Color(0xff5e6060);
  static const gray03 = Color(0xff515151);
  static const gray04 = Color(0xff3c3f41);
  static const gray05 = Color(0xff313335);
  static const gray06 = Color(0xff2b2b2b);
}

//TEXT STYLES
class TextStyles {
  static const h1 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colorss.blu01,
  );
static const h2 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
      color: Colorss.blu02,
  );
static const h3 = TextStyle(
      fontSize: 13,
      color: Colorss.blu01
  );
}

// ASSETS JSON
const notesJSON = 'assets/JSON/notifications.json';

//ASSETS IMAGES
const background1 = 'assets/images/background.jpg';
const background2 = 'https://images.pexels.com/photos/7608002/pexels-photo-7608002.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
const logo1 = 'https://static.vecteezy.com/system/resources/previews/005/891/013/non_2x/mars-rover-curiosity-black-and-white-color-logo-illustration-free-vector.jpg';