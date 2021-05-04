import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final fontSize;
  final text;
  CustomText({this.fontSize, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        // fontFamily:
        fontSize: fontSize,
         
      ),
    );
  }
}
