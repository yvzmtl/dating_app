

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/controller/auth_controller.dart';
import 'package:flutter_dating_app/page/auth/login_page.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';
import 'package:flutter_dating_app/widget/custom_button_widget.dart';
import 'package:flutter_dating_app/widget/custom_text_field.dart';
import 'package:flutter_dating_app/utils/register_textediting_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var authController = AuthController.authController;


  

  bool showProgressBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10*10),

              Text(
                "Hesap Oluştur",
                style: TextStyle(
                  fontSize: Dimensions.height10*2.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)
              ),

              SizedBox(height: Dimensions.height10*2),

              // Text(
              //   "şimdi başla",
              //   style: TextStyle(
              //     fontSize: Dimensions.height10*1.8,
              //     fontWeight: FontWeight.bold )
              // ),

              // SizedBox(height: Dimensions.height10*1.6),

              // profil avatarı seçme
              // GestureDetector(
              //   onTap: () {
              //     authController.pickImageFileFromGallery();
              //   },
              //   child: 
              authController.imageFile == null ?
                CircleAvatar(
                  radius: Dimensions.height10*8,
                  backgroundImage: AssetImage("assets/images/user_avatar.png"),
                  backgroundColor: Colors.white,
                )
                :Container(
                  width: Dimensions.width10*18,
                  height: Dimensions.height10*18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: FileImage(
                        File(authController.imageFile!.path)
                      )
                    ) 
                  ),
                )
                ,
              // ),

              Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: ()  async{
                    await authController.pickImageFileFromGallery();
                    setState(() {
                      authController.imageFile;
                    });
                  }, 
                  icon: const Icon(Icons.image_outlined,color: Colors.grey,size: 30)
                  ),

                  SizedBox(width: Dimensions.width10),

                  IconButton(onPressed: () async {
                    await authController.captureImageFromPhoneCamera();
                    setState(() {
                      authController.imageFile;
                    });
                  }, 
                  icon: const Icon(Icons.camera_alt_outlined,color: Colors.grey,size: 30)
                  ),
                ],
              ),

              SizedBox(height: Dimensions.height10*3),

              //**************** PROFILE INFO ***************/

              Text(
                "Kişisel Bilgiler",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.height10*2,
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: Dimensions.height10),

              //name
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.nameTextController,
                  text: "Ad Soyad",
                  icon: Icons.person_outline,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

              //email
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.emailTextController,
                  text: "Email",
                  icon: Icons.email_outlined,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),
             
              //password
              SizedBox(
               width: Dimensions.screenWidth,
               child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.passwordTextController,
                  text: "Şifre",
                  icon: Icons.lock_outline_rounded,
                  isObscure: true,
                ),
              ),

              SizedBox(height: Dimensions.height5),

              //age
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.ageTextController,
                  text: "Yaş",
                  icon: Icons.numbers,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

              // gender
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.genderTextController,
                  text: "Cinsiyet",
                  icon: Icons.person_sharp,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

             //phone
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.phoneTextController,
                  text: "Telefon",
                  icon: Icons.phone,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

               //ülke
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.countryTextController,
                  text: "Ülke",
                  icon: Icons.location_city,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

             //şehir
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.cityTextController,
                  text: "Şehir",
                  icon: Icons.location_city,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

            

             //profileHeading
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.profileHeadingTextController,
                  text: "Profil Başlığı",
                  icon: Icons.text_fields,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

             //lookingForInaPartner
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.lookingForInaPartnerTextController,
                  text: "Partner İstiyor musun?",
                  icon: Icons.face,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height10*2),



              //**************** DIŞ GÖRÜNÜŞ ***************/

              Text(
                "Dış Görünüş",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.height10*2,
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: Dimensions.height10),

              //Height
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.heightTextController,
                  text: "Boy",
                  icon: Icons.insert_chart,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

              //weight
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.weightTextController,
                  text: "Kilo",
                  icon: Icons.table_chart,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

              //vücut tipi
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.bodyTypeTextController,
                  text: "Vücut Tipi",
                  icon: Icons.type_specimen,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height10*2),


               //**************** HAYAT TARZI ***************/

              Text(
                "Hayat Tarzı",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.height10*2,
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: Dimensions.height10),

              // içiyor mu
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.drinkTextController,
                  text: "İçki içiyor musun?",
                  icon: Icons.local_drink,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

              //sigara 
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.smokeTextController,
                  text: "Sigara içiyor musun?",
                  icon: Icons.smoking_rooms_rounded,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

              //medeni durumu
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.martialStatusTextController,
                  text: "Medeni Durum",
                  icon: CupertinoIcons.person_2,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

              //Çocuk var mı?
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.haveChildrenTextController,
                  text: "Çocuk var mı?",
                  icon: CupertinoIcons.person_3_fill,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

               SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.noOfChildrenTextController,
                  text: "Kaç çocuk var?",
                  icon: CupertinoIcons.person_3_fill,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

              //meslek
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.professionalTextController,
                  text: "Meslek",
                  icon: Icons.business_center,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

              //çalışma durumu
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.employmentStatusTextController,
                  text: "Çalışma Durumu",
                  icon: CupertinoIcons.rectangle_stack_person_crop_fill,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

              //maaş
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.incomeTextController,
                  text: "Maaş",
                  icon: CupertinoIcons.money_dollar,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

              //yaşam durumu
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.livingSituationTextController,
                  text: "Yaşam Durumu",
                  icon: CupertinoIcons.person_2_square_stack,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

              //başka yere taşınma durumu
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.willingToRelocateTextController,
                  text: "Başka yere taşınmak ister misiniz?",
                  icon: CupertinoIcons.arrow_right_arrow_left,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

              //aradığınız ilişki nedir
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.relationshipYouAreLookingForTextController,
                  text: "Aradığınız ilişki nedir?",
                  icon: CupertinoIcons.person_2,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height10*2),

              //**************** KÜLTÜREL DEĞERLER ***************/

              Text(
                "Kültürel Değerler",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.height10*2,
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: Dimensions.height10),

              // vatandaşlık
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.nationalityTextController,
                  text: "Vatandaşlık",
                  icon: Icons.flag,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

              //Eğitim 
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.educationTextController,
                  text: "Eğitim",
                  icon: Icons.history_edu,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

              //Hangi dili konuşuyorsun
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.languageSpokenTextController,
                  text: "Hangi dili konuşuyorsun?",
                  icon: Icons.record_voice_over,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

              //din
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.religionTextController,
                  text: "Din",
                  icon: Icons.panorama_fish_eye_sharp,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),


               //etnik köken
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: ControllerValue.ethnicityTextController,
                  text: "Etnik Köken",
                  icon: CupertinoIcons.eye,
                  isObscure: false,
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
              CustomButtonWidget(text: "Kayıt Ol",
                onPressed: () async {
                  if (authController.imageFile != null) {
                    if (
                      // personel info
                      ControllerValue.nameTextController.text.trim().isNotEmpty
                      && ControllerValue.emailTextController.text.trim().isNotEmpty
                      && ControllerValue.passwordTextController.text.trim().isNotEmpty
                      && ControllerValue.nameTextController.text.trim().isNotEmpty
                      && ControllerValue.ageTextController.text.trim().isNotEmpty
                      && ControllerValue.genderTextController.text.trim().isNotEmpty
                      && ControllerValue.phoneTextController.text.trim().isNotEmpty
                      && ControllerValue.cityTextController.text.trim().isNotEmpty
                      && ControllerValue.countryTextController.text.trim().isNotEmpty
                      && ControllerValue.profileHeadingTextController.text.trim().isNotEmpty
                      && ControllerValue.lookingForInaPartnerTextController.text.trim().isNotEmpty

                      // Dış görünüş
                      && ControllerValue.heightTextController.text.trim().isNotEmpty
                      && ControllerValue.weightTextController.text.trim().isNotEmpty
                      && ControllerValue.bodyTypeTextController.text.trim().isNotEmpty

                      // life style
                      && ControllerValue.drinkTextController.text.trim().isNotEmpty
                      && ControllerValue.smokeTextController.text.trim().isNotEmpty
                      && ControllerValue.martialStatusTextController.text.trim().isNotEmpty
                      && ControllerValue.haveChildrenTextController.text.trim().isNotEmpty
                      && ControllerValue.noOfChildrenTextController.text.trim().isNotEmpty
                      && ControllerValue.professionalTextController.text.trim().isNotEmpty
                      && ControllerValue.employmentStatusTextController.text.trim().isNotEmpty
                      && ControllerValue.incomeTextController.text.trim().isNotEmpty
                      && ControllerValue.livingSituationTextController.text.trim().isNotEmpty
                      && ControllerValue.willingToRelocateTextController.text.trim().isNotEmpty
                      && ControllerValue.relationshipYouAreLookingForTextController.text.trim().isNotEmpty

                      // Kültirel değerler
                      && ControllerValue.nationalityTextController.text.trim().isNotEmpty
                      && ControllerValue.educationTextController.text.trim().isNotEmpty
                      && ControllerValue.languageSpokenTextController.text.trim().isNotEmpty
                      && ControllerValue.religionTextController.text.trim().isNotEmpty
                      && ControllerValue.ethnicityTextController.text.trim().isNotEmpty
                    ) {

                      setState(() {
                        showProgressBar = true;
                      });
                      
                      await authController.createNewUserAccount(
                        // personel info
                        authController.profileImage!,
                        ControllerValue.emailTextController.text.trim(),
                        ControllerValue.passwordTextController.text.trim(),
                        ControllerValue.nameTextController.text.trim(),
                        ControllerValue.ageTextController.text.trim(),
                        ControllerValue.genderTextController.text.trim(),
                        ControllerValue.phoneTextController.text.trim(),
                        ControllerValue.cityTextController.text.trim(),
                        ControllerValue.countryTextController.text.trim(),
                        ControllerValue.profileHeadingTextController.text.trim(),
                        ControllerValue.lookingForInaPartnerTextController.text.trim(),

                      // Dış görünüş
                        ControllerValue.heightTextController.text.trim(),
                        ControllerValue.weightTextController.text.trim(),
                        ControllerValue.bodyTypeTextController.text.trim(),

                      // life style
                        ControllerValue.drinkTextController.text.trim(),
                        ControllerValue.smokeTextController.text.trim(),
                        ControllerValue.martialStatusTextController.text.trim(),
                        ControllerValue.haveChildrenTextController.text.trim(),
                        ControllerValue.noOfChildrenTextController.text.trim(),
                        ControllerValue.professionalTextController.text.trim(),
                        ControllerValue.employmentStatusTextController.text.trim(),
                        ControllerValue.incomeTextController.text.trim(),
                        ControllerValue.livingSituationTextController.text.trim(),
                        ControllerValue.willingToRelocateTextController.text.trim(),
                        ControllerValue.relationshipYouAreLookingForTextController.text.trim(),

                      // Kültirel değerler
                        ControllerValue.nationalityTextController.text.trim(),
                        ControllerValue.educationTextController.text.trim(),
                        ControllerValue.languageSpokenTextController.text.trim(),
                        ControllerValue.religionTextController.text.trim(),
                        ControllerValue.ethnicityTextController.text.trim()
                        );

                      setState(() {
                        showProgressBar = false;
                        authController.imageFile = null;
                      });

                    } else {
                      Get.snackbar("Uyarı", "Lütfen boş alanları doldurunuz");
                    }
                    
                  } else {
                    Get.snackbar("Resim bulunamadı", "Lütfen bir resim yükleyin");
                  }
                }
                 ,),

              SizedBox(height: Dimensions.height10*1.5),

             //Hesabın var mı butonu
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Zaten bir hesabınız var mı??",
                    style: TextStyle(
                    fontSize: Dimensions.height10*1.6,
                    color: Colors.grey
                  ),
                ),
                SizedBox(width: Dimensions.width5),
                InkWell(
                  onTap: () {
                     Get.to(()=>LoginPage());
                  },
                  child:Text(
                  "Giriş Yap",
                  style: TextStyle(
                    fontSize: Dimensions.height10*1.8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                  ),
                )],
              ),
           
              SizedBox(height: Dimensions.height10*2),

              showProgressBar == true 
               ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),)
               : Container(),  

              SizedBox(height: Dimensions.height10*3),
             
            ],
          ),
        ),
      ),
    );
  }
}