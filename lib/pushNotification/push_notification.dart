

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/page/tab_screens/user_details_screen.dart';
import 'package:flutter_dating_app/utils/api.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';
import 'package:flutter_dating_app/widget/custom_text_widget.dart';
import 'package:get/get.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // bildirim alınması
  Future whenNotificationReceived(BuildContext context) async {

    //1. Terminated
    // Uygulama komple kapatıldığı zaman ve direk açıldığında bildirimin gelmesi
    messaging.getInitialMessage().then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //uygulamayı aç ve bildirim bilgilerini göster
        openAppAndShowNotificationData(remoteMessage.data["userID"],remoteMessage.data["senderID"],context);
      }
    });

    // 2. foreground
    // Uygulama açıkken bildirim gönderilmesi
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) { 
      if (remoteMessage != null) {
        //uygulamayı aç ve bildirim bilgilerini göster
        openAppAndShowNotificationData(remoteMessage.data["userID"],remoteMessage.data["senderID"],context);
      }
    });

    //3. background
    // Uygulama arka planda çalışıyorken bildirim gelmesi
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //uygulamayı aç ve bildirim bilgilerini göster
        openAppAndShowNotificationData(remoteMessage.data["userID"],remoteMessage.data["senderID"],context);
      }
    });
  }
  
  openAppAndShowNotificationData(recivedID, senderID, context) async{
    await FirebaseFirestore.instance
      .collection(ApiDB.UsersDB)
      .doc(senderID)
      .get().then((snapshot) {

        String profileImage = snapshot.data()!["imageProfile"].toString();
        String name = snapshot.data()!["name"].toString();
        String age = snapshot.data()!["age"].toString();
        String city = snapshot.data()!["city"].toString();
        String country = snapshot.data()!["country"].toString();
        String professional = snapshot.data()!["professional"].toString();

        showDialog(
          context: context,
          builder: (context){
            return NotificationDialogBox(senderID,profileImage,name,age,city,country,professional,context);
          }
        );
    });
  }
  
  NotificationDialogBox(senderID, profileImage, name, age, city, country, professional, context) {
    return Dialog(
      child: GridTile(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10*0.3),
          child: SizedBox(
            height: Dimensions.height10*30,
            child: Card(
              color: Colors.blue.shade200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(profileImage),
                    fit: BoxFit.cover
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.height10*0.8),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: name + " ⦿ "+age.toString(),
                          fontSize: Dimensions.height10*1.6,
                          fontWeight: FontWeight.bold
                        ),

                        SizedBox(height: Dimensions.height10*0.8),

                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: Dimensions.height10*1.6
                            ),

                            SizedBox(width: Dimensions.height10*0.2),

                            Expanded(
                              child: CustomTextWidget(
                                text: city + " , " + country.toString(),
                                maxLines: 4,
                                fontSize: Dimensions.height10*1.4,
                              )
                            )
                          ],
                        ),

                        Spacer(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: ElevatedButton(
                                onPressed: (){
                                  Get.back();

                                  Get.to(()=>UserDetailsScreen(userID: senderID));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: CustomTextWidget(
                                  text: "Profili Göster"),
                              ),
                            ),

                            Center(
                              child: ElevatedButton(
                                onPressed: (){
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                child: CustomTextWidget(
                                  text: "Kapat"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future generateDeviceRegistrationToken() async {
    String? deviceToken = await messaging.getToken();

    await FirebaseFirestore.instance
            .collection(ApiDB.UsersDB)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
              "userDeviceToken" : deviceToken
            });
  }
}