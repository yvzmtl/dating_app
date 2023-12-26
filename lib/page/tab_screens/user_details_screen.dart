

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/controller/auth_controller.dart';
import 'package:flutter_dating_app/page/account_setting_page/account_settings_page.dart';
import 'package:flutter_dating_app/utils/api.dart';
import 'package:flutter_dating_app/utils/app_colors.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';
import 'package:flutter_dating_app/widget/custom_text_widget.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatefulWidget {

  String? userID;

  UserDetailsScreen({super.key,this.userID});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {

  //personel info
  String name = "";
  String age = "";
  String phoneNo = "";
  String city = "";
  String country = "";
  String profileHeanding = "";
  String lookingForInaPartner = "";

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

  //slider image
  String urlImage1 = "https://firebasestorage.googleapis.com/v0/b/dating-app-a04ef.appspot.com/o/Place%20Holder%2Fuser_avatar.png?alt=media&token=359e60ae-de99-46d2-800d-d5b7b89ade66";
  String urlImage2 = "https://firebasestorage.googleapis.com/v0/b/dating-app-a04ef.appspot.com/o/Place%20Holder%2Fuser_avatar.png?alt=media&token=359e60ae-de99-46d2-800d-d5b7b89ade66";
  String urlImage3 = "https://firebasestorage.googleapis.com/v0/b/dating-app-a04ef.appspot.com/o/Place%20Holder%2Fuser_avatar.png?alt=media&token=359e60ae-de99-46d2-800d-d5b7b89ade66";
  String urlImage4 = "https://firebasestorage.googleapis.com/v0/b/dating-app-a04ef.appspot.com/o/Place%20Holder%2Fuser_avatar.png?alt=media&token=359e60ae-de99-46d2-800d-d5b7b89ade66";
  String urlImage5 = "https://firebasestorage.googleapis.com/v0/b/dating-app-a04ef.appspot.com/o/Place%20Holder%2Fuser_avatar.png?alt=media&token=359e60ae-de99-46d2-800d-d5b7b89ade66";

  retrieveUserInfo() async {
    await FirebaseFirestore.instance.
        collection(ApiDB.UsersDB)
        .doc(widget.userID)
        .get()
        .then((snapshot){
          if (snapshot.exists) {
            if (snapshot.data()!["urlImage1"] != null) {
              setState(() {
                urlImage1 = snapshot.data()!["urlImage1"];
                urlImage2 = snapshot.data()!["urlImage2"];
                urlImage3 = snapshot.data()!["urlImage3"];
                urlImage4 = snapshot.data()!["urlImage4"];
                urlImage5 = snapshot.data()!["urlImage5"];
              });
            }
            setState(() {
              //personel info
              name = snapshot.data()!["name"];
              age = snapshot.data()!["age"].toString();
              phoneNo = snapshot.data()!["phoneNo"];
              city = snapshot.data()!["city"];
              country = snapshot.data()!["country"];
              profileHeanding = snapshot.data()!["profileHeanding"];
              lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];

              // Appearance - dış görünüş
              height = snapshot.data()!["height"];
              weight = snapshot.data()!["weight"];
              bodyType = snapshot.data()!["bodyType"];

              // life style
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

              // kültürel değerler
              nationality = snapshot.data()!["nationality"];
              education = snapshot.data()!["education"];
              languageSpoken = snapshot.data()!["languageSpoken"];
              religion = snapshot.data()!["religion"];
              ethnicity = snapshot.data()!["ethnicity"];
            });
          }
        });
  }
  
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    retrieveUserInfo();
  }
  
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.tabBackgroundColorGrey,
        title: Text("Profil",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        // automaticallyImplyLeading: widget.userID == FirebaseAuth.instance.currentUser ? false : true,
        leading: widget.userID != FirebaseAuth.instance.currentUser!.uid 
        ? IconButton(
            onPressed:(){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_outlined,size: Dimensions.height10*3))
        : Container(),
        actions: [
          widget.userID == FirebaseAuth.instance.currentUser!.uid
          ? Row(
            children: [
              IconButton(
                onPressed: (){
                  Get.to(()=> AccountSettingsPage());
                }, 
                icon: Icon(Icons.settings,color: Colors.white,size: Dimensions.height10*3,)
              ),
              IconButton(
                onPressed: (){
                  authController.userLogout();
                }, 
                icon: Icon(Icons.logout,color: Colors.white,size: Dimensions.height10*3,)
              ),
            ],
          )
          : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10*2),
          child: Column(
            children: [

              //image slider
              SizedBox(
                height: Dimensions.screenHeight*0.4,
                width: Dimensions.screenWidth,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.height10*0.2),
                  child: Carousel(
                    indicatorBarColor: AppColor.mainColorDark.withOpacity(0.3),
                    autoScrollDuration: Duration(seconds: 2),
                    animationPageDuration: Duration(milliseconds: 500),
                    activateIndicatorColor: AppColor.mainColorDark,
                    unActivatedIndicatorColor: AppColor.mainColorGrey,
                    animationPageCurve: Curves.easeIn,
                    indicatorBarHeight: Dimensions.height10*3,
                    indicatorHeight: Dimensions.height10,
                    indicatorWidth: Dimensions.width10,
                    stopAtEnd: false,
                    autoScroll: true,
                    items: [
                      Image.network(urlImage1,fit: BoxFit.cover),
                      Image.network(urlImage2,fit: BoxFit.cover),
                      Image.network(urlImage3,fit: BoxFit.cover),
                      Image.network(urlImage4,fit: BoxFit.cover),
                      Image.network(urlImage5,fit: BoxFit.cover),
                    ]
                  ),
                ),
              ),

              SizedBox(height: Dimensions.height10*3),

              //personel info title
              Align(
                alignment: Alignment.topLeft,
                child: CustomTextWidget(
                  text: "Kullanıcı Bilgileri",
                  fontSize: Dimensions.height10*2,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(color: Colors.white, thickness: 2),

              //personel info data
              Container(
                color: AppColor.mainColorDark,
                padding: EdgeInsets.all(Dimensions.height10),
                child: Table(
                  children: [
                    //name
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Ad Soyad ",fontSize: Dimensions.height10*1.8),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.8),

                          ],
                        ),
                        CustomTextWidget(text: name ,fontSize: Dimensions.height10*1.8,textColor: Colors.grey,),
                      ]
                    ),

                    // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //age
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Yaş ",fontSize: Dimensions.height10*1.8),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.8),
                          ],
                        ),
                        CustomTextWidget(text: age ,fontSize: Dimensions.height10*1.8,textColor: Colors.grey,),
                      ]
                    ),

                    // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //phone
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Telefon ",fontSize: Dimensions.height10*1.8),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.8),
                          ],
                        ),
                        CustomTextWidget(text: phoneNo ,fontSize: Dimensions.height10*1.8,textColor: Colors.grey,),
                      ]
                    ),
                    
                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //country
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Ülke ",fontSize: Dimensions.height10*1.8),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.8),
                          ],
                        ),
                        CustomTextWidget(text: country ,fontSize: Dimensions.height10*1.8,textColor: Colors.grey,),
                      ]
                    ),
                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //city
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Şehir ",fontSize: Dimensions.height10*1.8),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.8),
                          ],
                        ),
                        CustomTextWidget(text: city ,fontSize: Dimensions.height10*1.8,textColor: Colors.grey,),
                      ]
                    ),
                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    // looking for in a partner
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Özellikler ",fontSize: Dimensions.height10*1.8),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.8),
                          ],
                        ),
                        CustomTextWidget(text: lookingForInaPartner ,fontSize: Dimensions.height10*1.8,textColor: Colors.grey,),
                      ]
                    ), 
                  ],
                ),
              ),

              Divider(color: Colors.grey.withOpacity(0.3), thickness: 1),

              //görünüş  title
              SizedBox(height: Dimensions.height10),
              Align(
                alignment: Alignment.topLeft,
                child: CustomTextWidget(
                  text: "Görünüş",
                  fontSize: Dimensions.height10*2,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(color: Colors.white, thickness: 2),

              //görünüş data
              Container(
                color: AppColor.mainColorDark,
                padding: EdgeInsets.all(Dimensions.height10),
                child: Table(
                  children: [
                    //height
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Boy ",fontSize: Dimensions.height10*1.8),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.8),

                          ],
                        ),
                        CustomTextWidget(text: height ,fontSize: Dimensions.height10*1.8,textColor: Colors.grey,),
                      ]
                    ),

                    // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //weight
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Kilo ",fontSize: Dimensions.height10*1.8),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.8),
                          ],
                        ),
                        CustomTextWidget(text: weight ,fontSize: Dimensions.height10*1.8,textColor: Colors.grey,),
                      ]
                    ),

                    // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //BodyType
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Vücut Tipi ",fontSize: Dimensions.height10*1.8),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.8),
                          ],
                        ),
                        CustomTextWidget(text: bodyType ,fontSize: Dimensions.height10*1.8,textColor: Colors.grey,),
                      ]
                    ),
                  ],
                ),
              ),

              Divider(color: Colors.grey.withOpacity(0.3), thickness: 1),

               //Life Style  title
              SizedBox(height: Dimensions.height10),
              Align(
                alignment: Alignment.topLeft,
                child: CustomTextWidget(
                  text: "Yaşam Stili",
                  fontSize: Dimensions.height10*2,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(color: Colors.white, thickness: 2),

               //yaşam style data
              Container(
                color: AppColor.mainColorDark,
                padding: EdgeInsets.all(Dimensions.height10),
                child: Table(
                  children: [
                    //drink
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "İçki ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),

                          ],
                        ),
                        CustomTextWidget(text: drink ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),

                    // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //smoke
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Sigara ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: smoke ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),

                    // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //martialStatus
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Medeni Durum ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: martialStatus ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),
                    
                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //haveChildren
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Çocuk Var mı? ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: haveChildren ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),
                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //noOfChildren
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Çocuk Sayısı ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: noOfChildren ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),
                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    // professional
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Meslek ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: professional ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),

                    // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    // employmentStatus
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Çalışma Durumu",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: employmentStatus ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ), 

                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    // income
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Maaş",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: income ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ), 

                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    // livingSituation
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Yaşam",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: livingSituation ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),

                      // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    // willingToRelocate
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Taşınma",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: willingToRelocate ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ), 

                      // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    // livingSituation
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "İlişki",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: relationshipYouAreLookingFor ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ), 
                  ],
                ),
              ),

              Divider(color: Colors.grey.withOpacity(0.3), thickness: 1),

               //Life Style  title
              SizedBox(height: Dimensions.height10),
              Align(
                alignment: Alignment.topLeft,
                child: CustomTextWidget(
                  text: "Kiltürel Değerler",
                  fontSize: Dimensions.height10*2,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(color: Colors.white, thickness: 2),

              //kültürel değerler data
              Container(
                color: AppColor.mainColorDark,
                padding: EdgeInsets.all(Dimensions.height10),
                child: Table(
                  children: [
                    //nationality
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Ulus ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),

                          ],
                        ),
                        CustomTextWidget(text: nationality ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),

                    // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //education
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Eğitim ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: education ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),

                    // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //languageSpoken
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Dil ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: languageSpoken ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),
                    
                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //religion
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Din ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: religion ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),
                     // ekstra row
                    const TableRow(
                      children: [
                        CustomTextWidget(text: ""),
                        CustomTextWidget(text: ""),
                      ]
                    ),

                    //ethnicity
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(text: "Etnik Köken ",fontSize: Dimensions.height10*1.6),
                            CustomTextWidget(text: ":  ",fontSize: Dimensions.height10*1.6),
                          ],
                        ),
                        CustomTextWidget(text: ethnicity ,fontSize: Dimensions.height10*1.6,textColor: Colors.grey,),
                      ]
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}