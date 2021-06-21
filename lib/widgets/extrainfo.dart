import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExtraInfo extends StatefulWidget {
  ExtraInfo({this.textFirst, this.value, this.textLast});
  final value;
  final textFirst;
  final textLast;

  @override
  _ExtraInfoState createState() => _ExtraInfoState();
}

class _ExtraInfoState extends State<ExtraInfo> {
  String textFirst, valueInfo, textLast;
  double width = 0.0;

  @override
  void initState() {
    super.initState();
    getValue(widget.textFirst, widget.value, widget.textLast);
  }

  getValue(String textOne, dynamic value, String textTwo) {
    textFirst = textOne;
    valueInfo = value.toString();
    textLast = textTwo;
    if (textFirst == 'Wind') {
      if (value >= 0 && value <= 10)
        width = 5;
      else if (value > 10 && value < 20)
        width = 10;
      else if (value > 20 && value < 30)
        width = 20;
      else if (value > 30 && value < 40)
        width = 30;
      else if (value > 40 && value < 50)
        width = 40;
      else
        width = 50;
    }
    if (textFirst == 'Pressure') {
      if (value < 500)
        width = 50;
      else if (value > 500 && value < 600)
        width = 45;
      else if (value > 600 && value < 700)
        width = 40;
      else if (value > 700 && value < 800)
        width = 35;
      else if (value > 800 && value < 900)
        width = 30;
      else if (value > 900 && value < 1000)
        width = 25;
      else if (value > 1000 && value < 1100)
        width = 20;
      else if (value > 1100 && value < 1200) width = 15;
    }
    if (textFirst == 'Humidity') {
      if (value > 90 && value <= 100)
        width = 50;
      else if (value > 70 && value < 90)
        width = 40;
      else if (value > 50 && value < 70)
        width = 30;
      else if (value > 30 && value < 50)
        width = 20;
      else if (value > 10 && value < 30)
        width = 10;
      else
        width = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textFirst,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          valueInfo,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        Text(
          textLast,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        Stack(
          children: [
            Container(
              height: 5,
              width: 50,
              color: Colors.white38,
            ),
            Container(
              height: 5,
              width: width,
              color: Colors.greenAccent,
            )
          ],
        )
      ],
    );
  }
}
