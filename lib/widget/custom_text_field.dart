
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/utils/app_colors.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';

class CustomTextFieldWidget extends StatelessWidget {

  final TextEditingController? textEditingController;
  final IconData? icon;
  final String? assetRef;
  final String? text;
  final bool? isObscure;

  const CustomTextFieldWidget({super.key,
    this.textEditingController, 
    this.icon, 
    this.assetRef, 
    this.text, 
    this.isObscure
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: textEditingController,
        obscureText: isObscure!,
        decoration: InputDecoration(
          labelText: text,
          prefixIcon: icon != null 
            ? Icon(icon) 
            : Padding(padding: EdgeInsets.all(8),
                child: Image.asset(assetRef.toString())),
          labelStyle: TextStyle(fontSize: Dimensions.height10*1.8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height10*0.6),
            borderSide: BorderSide(color: AppColor.mainColorGrey)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height10*0.6),
            borderSide: BorderSide(color: AppColor.mainColorGrey)
          ),
        ),
      ),
    );
  }
}