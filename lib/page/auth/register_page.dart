

import 'package:dating_app/utils/dimensions.dart';
import 'package:dating_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

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

            ],
          ),
        ),
      ),
    );
  }
}