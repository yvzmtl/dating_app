
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/controller/profile_controller.dart';
import 'package:flutter_dating_app/page/tab_screens/user_details_screen.dart';
import 'package:flutter_dating_app/utils/api.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';
import 'package:flutter_dating_app/widget/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SwipingScreen extends StatefulWidget {
  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {

  ProfileController profileController = Get.put(ProfileController());
  String senderName = "";
  var pagecontroller = PageController(initialPage: 0, viewportFraction: 1);
  int _activePage = 0;

  applyFilter(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return AlertDialog(
              title: CustomTextWidget(text: "Filtrele"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Cinsiyet filtreleme
                  CustomTextWidget(text: "Cinsiyet"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: CustomTextWidget(text: "Seçiniz"),
                      value: ApiDB.chosenGender,
                      underline: Container(),
                      items: [
                        "Erkek",
                        "Kadın",
                        "Diğer"
                      ].map((selectedValue){
                        return DropdownMenuItem(
                          value: selectedValue,
                          child: CustomTextWidget(
                            text: selectedValue,
                            fontWeight: FontWeight.w500
                          )
                        );
                      }).toList(), 
                      onChanged: (String? value) {
                        setState(() {
                          ApiDB.chosenGender = value;
                        });
                        },
                    ),
                  ),
                  SizedBox(height: Dimensions.height10*2),

                  //Ülke filtreleme
                  CustomTextWidget(text: "Ülke"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: CustomTextWidget(text: "Seçiniz"),
                      value: ApiDB.chosenCountry,
                      underline: Container(),
                      items: [
                        "Türkiye",
                        "Almanya",
                        "Filistin",
                        "Birleşik Krallık",
                        "Çin",
                        "İngiltere",
                        "Diğer"
                      ].map((selectedValue){
                        return DropdownMenuItem(
                          value: selectedValue,
                          child: CustomTextWidget(
                            text: selectedValue,
                            fontWeight: FontWeight.w500
                          )
                        );
                      }).toList(), 
                      onChanged: (String? value) {
                        setState(() {
                          ApiDB.chosenCountry = value;
                        });
                        },
                    ),
                  ),
                  SizedBox(height: Dimensions.height10*2),

                  // Yaş
                  CustomTextWidget(text: "Yaş"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: CustomTextWidget(text: "Seçiniz"),
                      value: ApiDB.chosenAge,
                      underline: Container(),
                      items: [
                        "18",
                        "20",
                        "25",
                        "30",
                        "35",
                        "40",
                        "45",
                        "50",
                        "55",
                        "60",
                        "Diğer",
                      ].map((selectedValue){
                        return DropdownMenuItem(
                          value: selectedValue,
                          child: CustomTextWidget(
                            text: selectedValue,
                            fontWeight: FontWeight.w500
                          )
                        );
                      }).toList(), 
                      onChanged: (String? value) {
                        setState(() {
                          ApiDB.chosenAge = value;
                        });
                        },
                    ),
                  ),
                  SizedBox(height: Dimensions.height10*2)
                
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: (){
                    profileController.getResult();

                    Get.back();
                  }, 
                  child: Text("Filtrele"))
              ],
            );
          }
        );
      }
    );
  }

  readCurrentUserData() async {
    await FirebaseFirestore.instance
            .collection(ApiDB.UsersDB)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((snapshot) {
              setState(() {
                senderName = snapshot.data()!["name"].toString();
              });
            });
  }

  startChattingWhatsApp(String receiverPhoneNumber) async{
    var androidUrl = "whatsapp://send?phone=$receiverPhoneNumber&text=Merhaba, profilini Dating App uygulamasından buldum";
    var iosUrl = "https://wa.me/$receiverPhoneNumber?text=${Uri.parse("Merhaba, profilini Dating App uygulamasından buldum")}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }

    } on Exception{
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: CustomTextWidget(text: "Whatsapp Bulunamadı"),
            content: CustomTextWidget(text: "Whatsapp yüklenmemiş"),
            actions: [
              TextButton(
                onPressed: (){
                  Get.back();
                },
                child: CustomTextWidget(text: "OK"))
            ],
          );
        });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
        itemCount: profileController.allUserProfileList.length,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        onPageChanged: (int page){
          setState(() {
            _activePage = page;
          });
        },
        scrollDirection: Axis.horizontal,
        itemBuilder:(context,index){
          final eachProfileInfo = profileController.allUserProfileList[index];
          return DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(eachProfileInfo.imageProfile.toString(),),fit: BoxFit.cover)
            ),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height10*1.2),
              child: Column(
                children: [

                  //filter icon button
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: Dimensions.height10*1.5),
                      child: IconButton(
                        onPressed: (){
                          applyFilter();
                        }, 
                        icon: Icon(Icons.filter_list,size: Dimensions.height10*3)
                      ),
                    ),
                  ),

                  Spacer(),
                  //user data
                  GestureDetector(
                    onTap: (){
                      profileController.viewSentAndViewReceived(eachProfileInfo.uid.toString(), senderName);

                      Get.to(()=>UserDetailsScreen(userID: eachProfileInfo.uid));
                    },
                    child: Column(
                      children: [
                        //name  
                        CustomTextWidget(
                          text: eachProfileInfo.name!.toUpperCase().toString(),
                          fontWeight: FontWeight.bold,
                          textColor: Colors.grey.shade400,
                          fontSize: Dimensions.height10*2.4,
                        ),

                        //age and city
                        CustomTextWidget(
                          text: "${eachProfileInfo.age!} ⦿ ${eachProfileInfo.city!.toUpperCase()}",
                          textColor: Colors.grey.shade400,
                          fontSize: Dimensions.height10*1.6,
                        ),

                        SizedBox(height: Dimensions.height5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white30,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.height10*1.6)
                                )
                              ),
                              child: CustomTextWidget(
                                text: eachProfileInfo.professional!.toUpperCase().toString())
                            ),
                            SizedBox(width: Dimensions.width5),
                            ElevatedButton(
                              onPressed: (){
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white30,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.height10*1.6)
                                )
                              ),
                              child: CustomTextWidget(
                                text: eachProfileInfo.religion!.toUpperCase().toString())
                            ),
                          ],
                        ),

                        SizedBox(height: Dimensions.height5),

                        //country and etnik köken
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white30,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.height10*1.6)
                                )
                              ),
                              child: CustomTextWidget(
                                text: eachProfileInfo.country!.toUpperCase().toString())
                            ),
                            SizedBox(width: Dimensions.width5),
                            ElevatedButton(
                              onPressed: (){
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white30,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.height10*1.6)
                                )
                              ),
                              child: CustomTextWidget(
                                text: eachProfileInfo.ethnicity!.toUpperCase().toString())
                            ),
                          ],
                        ),

                        SizedBox(height: Dimensions.height10*1.4),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //favorite button
                            GestureDetector(
                              onTap: (){
                                profileController.favoriteSentAndFavoriteReceived(eachProfileInfo.uid.toString(), senderName);
                                //profileController.isFavorite ? Get.snackbar("Favoriler", "Favorilere eklendi") :  Get.snackbar("Favoriler", "Favorilerden çıkarıldı") ;
                              },
                              child: Image.asset(
                                "assets/images/favorite.png",
                                width: Dimensions.width10*6,
                              ),
                            ),

                            // SizedBox(width: Dimensions.width10*2),

                            //chat
                            GestureDetector(
                              onTap: (){
                                startChattingWhatsApp(eachProfileInfo.phoneNo.toString());
                              },
                              child: Image.asset(
                                "assets/images/chat.png",
                                width: Dimensions.width10*6,
                              ),
                            ),
                            // SizedBox(width: Dimensions.width10*2),

                            //like
                            GestureDetector(
                              onTap: (){
                                profileController.likeSentAndLikeReceived(eachProfileInfo.uid.toString(), senderName);
                              },
                              child: Image.asset(
                                "assets/images/like.png",
                                width: Dimensions.width10*6,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
          


         
        });
      })
    );
  }
}