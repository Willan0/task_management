import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/constant/color.dart';
import 'package:task_management/constant/dimen.dart';

class EasyText extends StatelessWidget {
  const EasyText(
      {super.key,
      required this.text,
      this.fontSize = kFi13x,
      this.fontColor = whiteColor,
      this.fontWeight = FontWeight.w400});

  final String text;
  final FontWeight fontWeight;
  final Color fontColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: fontSize, color: fontColor, fontWeight: fontWeight)),
    );
  }
}
