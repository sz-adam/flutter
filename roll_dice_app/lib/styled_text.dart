import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, this.fontSize, this.color, {super.key});

  final String text;
  final double fontSize; 
  final Color color;

  @override
  Widget build(context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}