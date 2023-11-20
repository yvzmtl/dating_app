
import 'package:dating_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10*12),
              Image.asset("assets/images/logo.png",width: Dimensions.width10*18,),
              SizedBox(height: Dimensions.height10*2),
              Text("Hoşgeldiniz",style: TextStyle(fontSize: Dimensions.height10*2.5,fontWeight: FontWeight.bold)),
              SizedBox(height: Dimensions.height10*2),
              Text("En iyi eşleşme için lütfen giriş yapınız.",style: TextStyle(fontSize: Dimensions.height10*1.8,fontWeight: FontWeight.bold))
             
            ],
          ) ),
      )
    );
  }
}