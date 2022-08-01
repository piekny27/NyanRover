import 'package:flutter/material.dart';


//COLORS
class Colors{
  static const blu01 = Color(0xff2565aa);
  static const blu02 = Color(0xff1c3052);
}

//TEXT STYLES
class TextStyles {
  static const h1 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colors.blu01,
  );
static const h2 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
      color: Colors.blu02,
  );
static const h3 = TextStyle(
      fontSize: 13,
      color: Colors.blu01
  );
}

// ASSETS JSON
const notesJSON = 'JSON/test.json';