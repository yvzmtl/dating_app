
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/controller/auth_controller.dart';
import 'package:flutter_dating_app/controller/profile_controller.dart';
import 'package:flutter_dating_app/page/home/home_page.dart';
import 'package:flutter_dating_app/utils/api.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';
import 'package:flutter_dating_app/utils/register_textediting_controller.dart';
import 'package:flutter_dating_app/widget/custom_button_widget.dart';
import 'package:flutter_dating_app/widget/custom_text_field.dart';
import 'package:flutter_dating_app/widget/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {

  var profileCOntroller = ProfileController();
  var authController = AuthController();

  bool upLoading = false;
  bool next = false;
  final List<File> _image = [];
  List<String> urlsList = [];
  double val = 0;

   //pesonel info
  String name="";
  String gender="";
  String age="";
  String phoneNo="";
  String city="";
  String country="";
  String profileHeanding="";
  String lookingForInaPartner="";


  // Appearance - dış görünüş
  String height="";
  String weight="";
  String bodyType="";

  // life style
  String drink=""; // içki içiyor mu
  String smoke=""; // sigara içiyor mu
  String martialStatus=""; // medeni durumu
  String haveChildren=""; // çocuk var mı
  String noOfChildren=""; // çocuk sayısı
  String professional=""; // mesleği
  String employmentStatus=""; // çalışma durumu - tam zamanlı - yarı zamanlı
  String income=""; //maaş
  String livingSituation=""; // aile veya çocuklu yaşama durumu
  String willingToRelocate=""; // başka şehre taşınma durumu
  String relationshipYouAreLookingFor=""; // aradığınız ilişki - evlilik, arkadaşlık vs.


  // kültürel değerler
  String nationality=""; // vatandaşlık
  String education=""; // eğitim
  String languageSpoken=""; // konuşulan dil
  String religion=""; // din
  String ethnicity=""; // etnik köken - amerikan,avrupa vs.

  chooseImage() async{
    XFile? _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image.add(File(_pickedFile!.path));
    });
  }

  retrieveUserData() async {
    await FirebaseFirestore.instance
            .collection(ApiDB.UsersDB)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((snapshot) {
              if (snapshot.exists) {
                setState(() {


                  name = snapshot.data()!["name"];
                  gender = snapshot.data()!["gender"];
                  age = snapshot.data()!["age"].toString();
                  phoneNo = snapshot.data()!["phoneNo"];
                  city = snapshot.data()!["city"];
                  country = snapshot.data()!["country"];
                  profileHeanding = snapshot.data()!["profileHeanding"];
                  lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];


                  height = snapshot.data()!["height"];
                  weight = snapshot.data()!["weight"];
                  bodyType = snapshot.data()!["bodyType"];


                  drink = snapshot.data()!["drink"];
                  smoke = snapshot.data()!["smoke"];
                  martialStatus = snapshot.data()!["martialStatus"];
                  haveChildren = snapshot.data()!["haveChildren"];
                  noOfChildren = snapshot.data()!["noOfChildren"];
                  professional = snapshot.data()!["professional"];
                  employmentStatus = snapshot.data()!["employmentStatus"];
                  income = snapshot.data()!["income"];
                  livingSituation = snapshot.data()!["livingSituation"];
                  willingToRelocate = snapshot.data()!["willingToRelocate"];
                  relationshipYouAreLookingFor = snapshot.data()!["relationshipYouAreLookingFor"];


                  nationality = snapshot.data()!["nationality"];
                  education = snapshot.data()!["education"];
                  languageSpoken = snapshot.data()!["languageSpoken"];
                  religion = snapshot.data()!["religion"];
                  ethnicity = snapshot.data()!["ethnicity"];

                  ControllerValue.nameTextController.text = name;
                  ControllerValue.ageTextController.text = age;
                  ControllerValue.genderTextController.text = gender;
                  ControllerValue.phoneTextController.text = phoneNo;
                  ControllerValue.cityTextController.text = city;
                  ControllerValue.countryTextController.text = country;
                  ControllerValue.profileHeadingTextController.text = profileHeanding;
                  ControllerValue.lookingForInaPartnerTextController.text = lookingForInaPartner;
                  ControllerValue.heightTextController.text = height;
                  ControllerValue.weightTextController.text = weight;
                  ControllerValue.bodyTypeTextController.text = bodyType;
                  ControllerValue.drinkTextController.text = drink;
                  ControllerValue.smokeTextController.text = smoke;
                  ControllerValue.martialStatusTextController.text = martialStatus;
                  ControllerValue.haveChildrenTextController.text = haveChildren;
                  ControllerValue.noOfChildrenTextController.text = noOfChildren;
                  ControllerValue.professionalTextController.text = professional;
                  ControllerValue.employmentStatusTextController.text = employmentStatus;
                  ControllerValue.incomeTextController.text = income;
                  ControllerValue.livingSituationTextController.text = livingSituation;
                  ControllerValue.willingToRelocateTextController.text = willingToRelocate;
                  ControllerValue.relationshipYouAreLookingForTextController.text = relationshipYouAreLookingFor;
                  ControllerValue.nationalityTextController.text = nationality;
                  ControllerValue.educationTextController.text = education;
                  ControllerValue.languageSpokenTextController.text = languageSpoken;
                  ControllerValue.religionTextController.text = religion;
                  ControllerValue.ethnicityTextController.text = ethnicity;
                });
              }
            });
  }

  uploadImages() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });

      var refImages = FirebaseStorage.instance.ref()
                        .child("images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");

      await refImages.putFile(img).whenComplete(() async {
        await refImages.getDownloadURL().then((urlImage){
          urlsList.add(urlImage);

          i++;
        });
      });
    }
  }

   updateUserDataToFirebaseDatabase(
    //pesonel info
  String name,String age,String gender,String phoneNo,
  String city,String country,String profileHeanding,String lookingForInaPartner,

  // Appearance - dış görünüş
  String height,String weight,String bodyType,

  // life style
  String drink,String smoke,String martialStatus,String haveChildren,String noOfChildren,
  String professional,String employmentStatus,String income,String livingSituation,
  String willingToRelocate,String relationshipYouAreLookingFor,

  // kültürel değerler
  String nationality,String education,String languageSpoken,String religion,String ethnicity
   ) async {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: Dimensions.height10*20,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: Dimensions.height10),
                  Text("Resimler Yükleniyor...")
                ],
              ),
            ),
          ),
          
        );
      } 
    );
    await uploadImages();

    await FirebaseFirestore.instance
      .collection(ApiDB.UsersDB)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
        //personel info
        'name' : name,
        'age' : int.parse(age),
        'gender' : gender.toLowerCase(),
        'phoneNo' : phoneNo,
        'city' : city,
        'country' : country,
        'profileHeanding' : profileHeanding,
        'lookingForInaPartner' : lookingForInaPartner,

        //dış görünüş
        'height' : height,
        'weight' : weight,
        'bodyType' : bodyType,

        //yaşam tarzı
        'drink' : drink,
        'smoke' : smoke,
        'martialStatus' : martialStatus,
        'haveChildren' : haveChildren,
        'noOfChildren' : noOfChildren,
        'professional' : professional,
        'employmentStatus' : employmentStatus,
        'income' : income,
        'livingSituation' : livingSituation,
        'willingToRelocate' : willingToRelocate,
        'relationshipYouAreLookingFor' : relationshipYouAreLookingFor,

        // kültürel değerler
        'nationality' : nationality,
        'education' : education,
        'languageSpoken' : languageSpoken,
        'religion' : religion,
        'ethnicity' : ethnicity,

        //images
        'urlImages1' : urlsList[0].toString(),
        'urlImages2' : urlsList[1].toString(),
        'urlImages3' : urlsList[2].toString(),
        'urlImages4' : urlsList[3].toString(),
        'urlImages5' : urlsList[4].toString(),
      });

      Get.snackbar("Güncelleme", "Güncelleme başarılı");

      Get.to(()=>HomePage());

      setState(() {
        upLoading = false;
        _image.clear();
        urlsList.clear();
      });

   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(
          text: next ? "Profil Bilgilendirme" : "5 Resim Seçiniz",
          fontSize: Dimensions.height10*2.2,  
        ),
        actions: [
          next  ? Container()
                : IconButton(
                  onPressed: (){
                    if (_image.length == 5) {
                      setState(() {
                        upLoading = true;
                        next = true;
                      });
                    } else {
                      Get.snackbar("Uyarı", "Lütfen 5 resim seçiniz");
                    }
                  },
                  icon: Icon(Icons.navigate_next_outlined, size: Dimensions.height10*4,)
          )
        ],
      ),
      body: next  
        ? SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.height10*3),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
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

              //gender
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

                            
              CustomButtonWidget(text: "Güncelle",
                onPressed: () async {
                 if (
                      // personel info
                      ControllerValue.nameTextController.text.trim().isNotEmpty
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

                      _image.length > 0
                      ? await updateUserDataToFirebaseDatabase(
                        // personel info
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
                        ) : null;
                        


                    }
                     else {
                      Get.snackbar("Uyarı", "Lütfen boş alanları doldurunuz");
                    }
                }
                 ,),
              ],
            ),
          ),
        )
        : Stack(
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.height5),
              child: GridView.builder(
                itemCount: _image.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3 ),
                itemBuilder: (context,index){
                  return index == 0
                    ? Container(
                      color: Colors.white30,
                      child: Center(
                        child: IconButton(
                          onPressed:(){
                            if (_image.length < 5) {
                              !upLoading ? chooseImage() : null;
                            } else {
                              setState(() {
                                upLoading = true;
                              });
                              Get.snackbar("Uyarı", "Zaten 5 resim seçilmiş.Daha fazla seçilemez");
                            }
                          } , 
                          icon: Icon(Icons.add)),
                      ),
                    )
                    : Container(
                      margin: EdgeInsets.all(Dimensions.height5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_image[index-1],),
                          fit: BoxFit.cover
                        )
                      ),
                    );
                }),  
            )
          ],
        )
    );
  }
}

