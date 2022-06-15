import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

final blue = HexColor("1765FD");
final black = HexColor("333030");
final white = HexColor("FFFFFF");
final color_call = Color(0xFF1976D2);
final color_wp = Color(0xFF388E3C);
final color_mail = Color(0xFFE53935);
final colorGreenDark = HexColor("4FCB8D");
final colorGreenLight = HexColor("DDFFEE");
final colorBlueDark = HexColor("1765FD");
final colorBlueLight = HexColor("DBE6FF");
final colorNavy = HexColor("03045E");
final colorYellow = Colors.amber;

TextStyle appbarText() {
  return GoogleFonts.quicksand(
      color: white, fontWeight: FontWeight.w800);
}

TextStyle textStyle(Color color, double size, FontWeight fontWeight) {
  return GoogleFonts.quicksand(
      color: color, fontSize: size, fontWeight: fontWeight);
}
