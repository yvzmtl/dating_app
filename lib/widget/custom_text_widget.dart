

import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {

  final String text;
  final Color? textColor;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final TextOverflow textOverflow;
  final int maxLines;

  const CustomTextWidget({super.key, 
    required this.text, 
    this.fontWeight, 
    this.textColor = Colors.white, 
    this.fontSize = 12, 
    this.letterSpacing, 
    this.textOverflow = TextOverflow.ellipsis, 
    this.maxLines = 1
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        overflow: textOverflow,
      ),
    );
  }
}