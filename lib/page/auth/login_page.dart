
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/controller/auth_controller.dart';
import 'package:flutter_dating_app/page/auth/register_page.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';
import 'package:flutter_dating_app/widget/custom_button_widget.dart';
import 'package:flutter_dating_app/widget/custom_text_field.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showProgressBar = false;
  var authController = AuthController.authController;

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
              Text("En iyi eşleşme için lütfen giriş yapınız.",style: TextStyle(fontSize: Dimensions.height10*1.8,fontWeight: FontWeight.bold)),

              SizedBox(height: Dimensions.height10*3),

              //email
              SizedBox(
                width: Dimensions.screenWidth,
               // height: Dimensions.height10*10,
                child: CustomTextFieldWidget(
                  textEditingController: emailController,
                  text: "Email",
                  icon: Icons.email_outlined,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),
             
             //password
             SizedBox(
               width: Dimensions.screenWidth,
              //  height: Dimensions.height10*5,
               child: CustomTextFieldWidget(
                  textEditingController: passwordController,
                  text: "Şifre",
                  icon: Icons.lock_outline_rounded,
                  isObscure: true,
                ),
             ),

             SizedBox(height: Dimensions.height10*2),

             //login buton
            //  Container(
            //   width: Dimensions.screenWidth-15,
            //   height: Dimensions.height10*5,
            //   decoration: const BoxDecoration(
            //     color: Colors.black,
            //     borderRadius: BorderRadius.all(Radius.circular(12)),
            //     boxShadow: [
            //       BoxShadow(color: Color.fromRGBO(240, 17, 91, 1),offset: Offset(2, 0),blurRadius: 10),
            //       BoxShadow(color: Color.fromRGBO(240, 141, 174, 1),offset: Offset(0, 2),blurRadius: 10),
            //     ]
            //   ),
            //   child: InkWell(
            //     onTap: () {
                 
            //     },
            //     child: Center(
            //       child: Text(
            //         "Giriş Yap", 
            //         style: TextStyle(
            //           fontSize: Dimensions.height10*2,
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            //  ),
            CustomButtonWidget(
                text: "Giriş Yap",
                onPressed: () async{
                  if (emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) 
                  {
                    setState(() {
                        showProgressBar = true;
                      });
                    await authController.loginUser(emailController.text.trim(), passwordController.text.trim());
                    setState(() {
                        showProgressBar = false;
                      });
                  
                  } else {
                    Get.snackbar("Uyarı", "Email / Şifre hatalı");
                  }
                }),

             SizedBox(height: Dimensions.height10*1.5),

             //Hesabım yok butonu
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hesabınız Yok Mu?",
                  style: TextStyle(
                    fontSize: Dimensions.height10*1.6,
                    color: Colors.grey
                  ),
                ),
                SizedBox(width: Dimensions.width5),
                InkWell(
                  onTap: () {
                     Get.to(()=>RegisterPage());
                  },
                  child:Text(
                  "Kayıt Ol",
                  style: TextStyle(
                    fontSize: Dimensions.height10*1.8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
                )
              ],
             ),
           
             SizedBox(height: Dimensions.height10*1.6),

             showProgressBar == true 
              ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),)
              : Container()

            ],
          )),
      )
    );
  }
}