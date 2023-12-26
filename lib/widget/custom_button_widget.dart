
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? buttonColor;
  final FontWeight? fontWeight;
  final VoidCallback? onPressed;

  const CustomButtonWidget({super.key, 
    required this.text, 
    this.fontSize = 20, 
    this.buttonColor = Colors.white70, 
    this.fontWeight = FontWeight.bold, 
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
              width: Dimensions.screenWidth-15,
              height: Dimensions.height10*5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(240, 121, 161, 1),
                  Color.fromRGBO(223, 15, 84, 1)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight) ,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(240, 17, 91, 1),offset: Offset(2, 0),blurRadius: 10),
                  BoxShadow(color: Color.fromRGBO(240, 141, 174, 1),offset: Offset(0, 2),blurRadius: 10),
                ]
              ),
              child: InkWell(
                onTap: onPressed,
                child: Center(
                  child: Text(
                    text, 
                    style: TextStyle(
                      fontSize: fontSize,
                      color: buttonColor,
                      fontWeight: fontWeight),
                  ),
                ),
              ),
             );
  }
}