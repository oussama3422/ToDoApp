import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color.fromARGB(255, 44, 5, 173);
const Color orangeClr = Color.fromARGB(207, 9, 123, 175);
const Color pinkClr = Color.fromARGB(255, 96, 5, 114);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );

 

}

  
  TextStyle get headingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? white : darkGreyClr,
    ));
  }
  TextStyle get subheadingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? white : darkGreyClr,
    ));
  }
  TextStyle get titleStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? white : darkGreyClr,
    ));
  }
  TextStyle get suubTitleStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? white: darkGreyClr,
    ));
  }
  TextStyle get bodyStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Get.isDarkMode ? white : darkGreyClr,
    ));
  }
  TextStyle get body2Style {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Get.isDarkMode ? Colors.grey[200] :darkGreyClr,
    ));
  }