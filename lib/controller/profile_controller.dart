
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dating_app/model/person.dart';
import 'package:flutter_dating_app/utils/api.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class ProfileController extends GetxController {

  final Rx<List<PersonModel>> userProfileList = Rx<List<PersonModel>>([]);
  List<PersonModel> get allUserProfileList => userProfileList.value;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedList = [];
  List _favoriteList = [];
  List get favoriteList => _favoriteList;


  List<String> likeSentList = [];
  List<String> likeReceivedList = [];
  List _likeList = [];
  List get likeList => _likeList;

  List<String> viewSentList = [];
  List<String> viewReceivedList = [];
  List _viewList = [];
  List get viewList => _viewList;

  getResult(){
    onInit();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (ApiDB.chosenAge == null || ApiDB.chosenCountry == null || ApiDB.chosenGender == null) {
      userProfileList.bindStream(
      FirebaseFirestore.instance.collection(ApiDB.UsersDB)
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
          List<PersonModel> profileList = [];

          for (var eachProfile in querySnapshot.docs) {
            profileList.add(PersonModel.fromDataSnapshot(eachProfile));
            // profileList.add(PersonModel.fromJson(eachProfile.data() as Map<String, dynamic>));
          }
          return profileList;
        })
      );
    } else {
      userProfileList.bindStream(
      FirebaseFirestore.instance.collection(ApiDB.UsersDB)
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("gender", isEqualTo: ApiDB.chosenGender.toString().toLowerCase()
        
        )
        .where("age", isEqualTo: int.parse(ApiDB.chosenAge.toString()))
        .where("country", isEqualTo: ApiDB.chosenCountry)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
          List<PersonModel> profileList = [];

          for (var eachProfile in querySnapshot.docs) {
            profileList.add(PersonModel.fromDataSnapshot(eachProfile));
            // profileList.add(PersonModel.fromJson(eachProfile.data() as Map<String, dynamic>));
          }
          return profileList;
        })
    );
    }
    
  }

  favoriteSentAndFavoriteReceived(String toUserID, String senderName) async {
    var currentUserID = FirebaseAuth.instance.currentUser!.uid;

    var document = await FirebaseFirestore.instance
                      .collection(ApiDB.UsersDB)
                      .doc(toUserID)
                      .collection(ApiDB.favoriteReceivedDB)
                      .doc(currentUserID)
                      .get();
    
    //database den bu favoriyi sil
    if (document.exists) {
      //favorite received listesinden currentUserID siliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(toUserID)
              .collection(ApiDB.favoriteReceivedDB)
              .doc(currentUserID)
              .delete();

      // favorite received listesinden toUserID siliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(currentUserID)
              .collection(ApiDB.favoriteSentDB)
              .doc(toUserID)
              .delete();

      Get.snackbar("Favoriler", "Favorilerden Kaldırıldı");

    } else {//database ekleyeceğiz
       //favorite received listesinden currentUserID ekliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(toUserID)
              .collection(ApiDB.favoriteReceivedDB)
              .doc(currentUserID)
              .set({});

      // favorite received listesinden toUserID ekliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(currentUserID)
              .collection(ApiDB.favoriteSentDB)
              .doc(toUserID)
              .set({});

      // Get.snackbar("Favoriler", "Favorilere Eklendi");
      sendNotificationToUser(toUserID, "Favorite", senderName);
      
    }

      update();
  }

  getFavoriteListKeys(bool isFavoriteSentClicked) async {
    favoriteSentList = [];
    favoriteSentList.clear();
    favoriteReceivedList = [];
    favoriteReceivedList.clear();
    if (isFavoriteSentClicked) {
      var favoriteSentDocument = await FirebaseFirestore.instance
                                        .collection(ApiDB.UsersDB)
                                        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                        .collection(ApiDB.favoriteSentDB)
                                        .get();
      
      for (int i = 0; i < favoriteSentDocument.docs.length; i++) {
        favoriteSentList.add(favoriteSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favoriteSentList);
    } else {
      var favoriteReceivedDocument = await FirebaseFirestore.instance
                                        .collection(ApiDB.UsersDB)
                                        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                        .collection(ApiDB.favoriteReceivedDB)
                                        .get();
      
      for (int i = 0; i < favoriteReceivedDocument.docs.length; i++) {
        favoriteReceivedList.add(favoriteReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favoriteReceivedList);
    }
  }
  
  getKeysDataFromUsersCollection(List<String> keysList) async {
    _favoriteList = [];
    _favoriteList.clear();
    
    var allUserDocument = await FirebaseFirestore.instance.collection(ApiDB.UsersDB).get();

    for (int i = 0; i < allUserDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (allUserDocument.docs[i].data()["uid"] == keysList[k]) {
          _favoriteList.add(allUserDocument.docs[i].data());
        }
      }
    }
    //update();
  }

  likeSentAndLikeReceived(String toUserID, String senderName) async {
    var currentUserID = FirebaseAuth.instance.currentUser!.uid;

    var document = await FirebaseFirestore.instance
                      .collection(ApiDB.UsersDB)
                      .doc(toUserID)
                      .collection(ApiDB.likeReceivedDB)
                      .doc(currentUserID)
                      .get();
    
    //database den bu like sil
    if (document.exists) {
      //like received listesinden currentUserID siliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(toUserID)
              .collection(ApiDB.likeReceivedDB)
              .doc(currentUserID)
              .delete();

      // like received listesinden toUserID siliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(currentUserID)
              .collection(ApiDB.likeSentDB)
              .doc(toUserID)
              .delete();

      Get.snackbar("Beğenme", "Beğenme Kaldırıldı");

    } else {//database ekleyeceğiz
       //like received listesinden currentUserID ekliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(toUserID)
              .collection(ApiDB.likeReceivedDB)
              .doc(currentUserID)
              .set({});

      // like received listesinden toUserID ekliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(currentUserID)
              .collection(ApiDB.likeSentDB)
              .doc(toUserID)
              .set({});
      
      Get.snackbar("Beğenme", "Beğenildi");
      sendNotificationToUser(toUserID, "Like", senderName);
    }
      update();
  }

  getLikeListKeys(bool isLikeSentClicked) async {
    likeReceivedList = [];
    likeReceivedList.clear();
    likeSentList = [];
    likeSentList.clear();
    if (isLikeSentClicked) {
      var likeSentDocument = await FirebaseFirestore.instance
                                        .collection(ApiDB.UsersDB)
                                        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                        .collection(ApiDB.likeSentDB)
                                        .get();
      
      for (int i = 0; i < likeSentDocument.docs.length; i++) {
        likeSentList.add(likeSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollectionLike(likeSentList);
    } else {
      var likeReceivedDocument = await FirebaseFirestore.instance
                                        .collection(ApiDB.UsersDB)
                                        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                        .collection(ApiDB.likeReceivedDB)
                                        .get();
      
      for (int i = 0; i < likeReceivedDocument.docs.length; i++) {
        likeReceivedList.add(likeReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollectionLike(likeReceivedList);
    }
  }

  getKeysDataFromUsersCollectionLike(List<String> keysList) async {
    _likeList = [];
    _likeList.clear();
    
    var allUserDocument = await FirebaseFirestore.instance.collection(ApiDB.UsersDB).get();

    for (int i = 0; i < allUserDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (allUserDocument.docs[i].data()["uid"] == keysList[k]) {
          _likeList.add(allUserDocument.docs[i].data());
        }
      }
    }
    // update();
  }


  viewSentAndViewReceived(String toUserID, String senderName) async {
    var currentUserID = FirebaseAuth.instance.currentUser!.uid;

    var document = await FirebaseFirestore.instance
                      .collection(ApiDB.UsersDB)
                      .doc(toUserID)
                      .collection(ApiDB.viewReceivedDB)
                      .doc(currentUserID)
                      .get();
    
    //database den bu like sil
    if (document.exists) {
      print("view list var");


    } else {//database ekleyeceğiz
       //view received listesinden currentUserID ekliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(toUserID)
              .collection(ApiDB.viewReceivedDB)
              .doc(currentUserID)
              .set({});

      // view received listesinden toUserID ekliyoruz
      await FirebaseFirestore.instance
              .collection(ApiDB.UsersDB)
              .doc(currentUserID)
              .collection(ApiDB.viewSentDB)
              .doc(toUserID)
              .set({});
      
      // Get.snackbar("Beğenme", "Beğenildi");
     // _isFavorite = true;
     sendNotificationToUser(toUserID, "View", senderName);
    }

      update();
  }

  getViewListKeys(bool isViewSentClicked) async {
    viewReceivedList = [];
    viewReceivedList.clear();
    viewSentList = [];
    viewSentList.clear();
    if (isViewSentClicked) {
      var viewSentDocument = await FirebaseFirestore.instance
                                        .collection(ApiDB.UsersDB)
                                        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                        .collection(ApiDB.viewSentDB)
                                        .get();
      
      for (int i = 0; i < viewSentDocument.docs.length; i++) {
        viewSentList.add(viewSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollectionView(viewSentList);
    } else {
      var viewReceivedDocument = await FirebaseFirestore.instance
                                        .collection(ApiDB.UsersDB)
                                        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                        .collection(ApiDB.viewReceivedDB)
                                        .get();
      
      for (int i = 0; i < viewReceivedDocument.docs.length; i++) {
        viewReceivedList.add(viewReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollectionView(viewReceivedList);
    }
  }
  
  getKeysDataFromUsersCollectionView(List<String> keysList) async {
    _viewList = [];
    _viewList.clear();
    
    var allUserDocument = await FirebaseFirestore.instance.collection(ApiDB.UsersDB).get();

    for (int i = 0; i < allUserDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (allUserDocument.docs[i].data()["uid"] == keysList[k]) {
          _viewList.add(allUserDocument.docs[i].data());
        }
      }
    }
    // update();
  }

  chooseImage() async{
    XFile? _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    
  }

  sendNotificationToUser(receivedID, featureType, senderName) async {
    String userDeviceToken = "";

    await FirebaseFirestore.instance
            .collection(ApiDB.UsersDB)
            .doc(receivedID)
            .get()
            .then((snapshot){
              if (snapshot.data()!["userDeviceToken"] != null) {
                userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
              }
            });
    notificationFormat(userDeviceToken,receivedID,featureType,senderName);
  }


  notificationFormat(userDeviceToken,receivedID,featureType,senderName){

    Map<String, String> headerNotification = 
    {
      "Content-Type" : "application/json",
      "Authorization" : ApiDB.fcmServerToken,
    };

    Map bodyNotification =
    {
      "body" : "$senderName kişisinden yeni bir $featureType alındı",
      "title" : "Yeni bir $featureType"
    };

    Map dataMap =
    {
      "click_action" : "FLUTTER_NOTIFICATION_CLICK",
      "id" : "1",
      "status" : "done",
      "userID" : receivedID,
      "senderID" : FirebaseAuth.instance.currentUser!.uid
    };

    Map notificationOfficialFormat = 
    {
      "notification" : bodyNotification,
      "data" : dataMap,
      "priority" : "high",
      "to" : userDeviceToken
    };

    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(notificationOfficialFormat)
    );
  }

  

}