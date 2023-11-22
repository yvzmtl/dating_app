

import 'package:dating_app/page/auth/login_page.dart';
import 'package:dating_app/utils/dimensions.dart';
import 'package:dating_app/widget/custom_button_widget.dart';
import 'package:dating_app/widget/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //personel info
  TextEditingController emailTextController = TextEditingController(); //mail
  TextEditingController passworTextController = TextEditingController(); //şifre
  TextEditingController nameTextController = TextEditingController(); //ad soyad
  TextEditingController ageTextController = TextEditingController(); //yaş
  TextEditingController phoneTextController = TextEditingController(); //telefon
  TextEditingController cityTextController = TextEditingController(); //şehir
  TextEditingController countryTextController = TextEditingController(); //ülke
  TextEditingController profileHeadingTextController = TextEditingController(); // profil açıklaması
  TextEditingController lookingForInaPartnerTextController = TextEditingController(); //ortak aranıyor mu

  // dış görünüş
  TextEditingController heightTextController = TextEditingController(); //boy
  TextEditingController weightTextController = TextEditingController(); // kilo
  TextEditingController bodyTypeTextController = TextEditingController(); // vücut tipi

  //hayat tarzı
  TextEditingController drinkTextController = TextEditingController(); // içki içiyor mu
  TextEditingController smokeTextController = TextEditingController(); // sigara içiyor mu
  TextEditingController martialStatusTextController = TextEditingController(); // medeni durumu
  TextEditingController haveChildrenTextController = TextEditingController(); // çocuk var mı
  TextEditingController noOfChildrenTextController = TextEditingController(); // çocuk sayısı
  TextEditingController professionalTextController = TextEditingController(); // mesleği
  TextEditingController employmentStatusTextController = TextEditingController(); // çalışma durumu - tam zamanlı - yarı zamanlı
  TextEditingController incomeTextController = TextEditingController(); //maaş
  TextEditingController livingSituationTextController = TextEditingController(); // aile veya çocuklu yaşama durumu
  TextEditingController willingToRelocateTextController = TextEditingController(); // başka şehre taşınma durumu
  TextEditingController relationshipYouAreLookingForTextController = TextEditingController(); // aradığınız ilişki - evlilik, arkadaşlık vs.

  // kültürel değerler
  TextEditingController nationalityTextController = TextEditingController(); // vatandaşlık
  TextEditingController educationTextController = TextEditingController(); // eğitim
  TextEditingController languageSpokenTextController = TextEditingController(); // konuşulan dil
  TextEditingController religionTextController = TextEditingController(); // din
  TextEditingController ethnicityTextController = TextEditingController(); // etnik köken - amerikan,avrupa vs.

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
              GestureDetector(
                onTap: () {
                  
                },
                child: CircleAvatar(
                  radius: Dimensions.height10*8,
                  backgroundImage: AssetImage("assets/images/user_avatar.png"),
                  backgroundColor: Colors.white,
                ),
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
                  textEditingController: nameTextController,
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
                  textEditingController: emailTextController,
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
                  textEditingController: passworTextController,
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
                  textEditingController: ageTextController,
                  text: "Yaş",
                  icon: Icons.numbers,
                  isObscure: false,
                ),
              ),

              SizedBox(height: Dimensions.height5),

             //phone
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: phoneTextController,
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
                  textEditingController: countryTextController,
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
                  textEditingController: cityTextController,
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
                  textEditingController: profileHeadingTextController,
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
                  textEditingController: lookingForInaPartnerTextController,
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
                  textEditingController: heightTextController,
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
                  textEditingController: weightTextController,
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
                  textEditingController: bodyTypeTextController,
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
                  textEditingController: drinkTextController,
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
                  textEditingController: smokeTextController,
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
                  textEditingController: martialStatusTextController,
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
                  textEditingController: haveChildrenTextController,
                  text: "Çocuk var mı?",
                  icon: CupertinoIcons.person_3_fill,
                  isObscure: false,
                ),
              ),

               SizedBox(height: Dimensions.height5),

              //meslek
              SizedBox(
                width: Dimensions.screenWidth,
                child: CustomTextFieldWidget(
                  textEditingController: professionalTextController,
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
                  textEditingController: employmentStatusTextController,
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
                  textEditingController: incomeTextController,
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
                  textEditingController: livingSituationTextController,
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
                  textEditingController: willingToRelocateTextController,
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
                  textEditingController: relationshipYouAreLookingForTextController,
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
                  textEditingController: nationalityTextController,
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
                  textEditingController: educationTextController,
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
                  textEditingController: languageSpokenTextController,
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
                  textEditingController: religionTextController,
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
                  textEditingController: ethnicityTextController,
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
              CustomButtonWidget(text: "Kayıt Ol"),

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