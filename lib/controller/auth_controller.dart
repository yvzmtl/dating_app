

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dating_app/model/person.dart';
import 'package:flutter_dating_app/page/auth/login_page.dart';
import 'package:flutter_dating_app/page/home/home_page.dart';
import 'package:flutter_dating_app/utils/api.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController authController = Get.find();

  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  late Rx<User?> firebaseCurrentUser;

  pickImageFileFromGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      Get.snackbar("Profil Resmi", "Profil Resmi Başarıyla Seçildi");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  captureImageFromPhoneCamera() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      Get.snackbar("Profil Resmi", "Kamera ile Profil Resmi Başarıyla Seçildi");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  createNewUserAccount(
  //pesonel info
  File imageProfile,String email,String password,String name,String age, String gender,String phoneNo,
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
    
    try {
      // 1. user auth ve email ve password ile kullanıcı kayıdı
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      //2. storage resim yükleme
      String urlOfDownloadedImage = await uploadImageToStorage(imageProfile);

      //3. user bilgilerini firestore database kaydetme
      PersonModel person = PersonModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        imageProfile: urlOfDownloadedImage,
        email : email,
        password : password,
        name : name,
        age : int.parse(age),
        gender : gender.toLowerCase(),
        phoneNo : phoneNo,
        city : city,
        country : country,
        profileHeanding : profileHeanding,
        lookingForInaPartner : lookingForInaPartner,
        publishedDateTime : DateTime.now().millisecondsSinceEpoch,
        height : height,
        weight : weight,
        bodyType : bodyType,
        drink : drink,
        smoke : smoke,
        martialStatus : martialStatus,
        haveChildren : haveChildren,
        noOfChildren : noOfChildren,
        professional : professional,
        employmentStatus : employmentStatus,
        income : income,
        livingSituation : livingSituation,
        willingToRelocate : willingToRelocate,
        relationshipYouAreLookingFor : relationshipYouAreLookingFor,
        nationality : nationality,
        education : education,
        languageSpoken : languageSpoken,
        religion : religion,
        ethnicity : ethnicity,
      );

      await FirebaseFirestore.instance.collection(ApiDB.UsersDB)
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set(person.toJson());

      Get.snackbar("Kayıt Başarılı", "Tebrikler, başarıyla kayıt oldunuz");
      Get.to(()=>HomePage());


    } catch (e) {
      Get.snackbar("Auth Controller Kayıt Başarısız", "Hata mesajı = $e");
    }
  }
  
  Future<String> uploadImageToStorage(File imageProfile)  async {
    Reference ref = FirebaseStorage.instance.ref()
                        .child("Profile Images")
                        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask task = ref.putFile(imageProfile);
    TaskSnapshot snapshot = await task;

    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();

    return downloadUrlOfImage;
  }

  loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      Get.snackbar("Uyarı", "Giriş başarılı");
      Get.to(()=>HomePage());
    } catch (e) {
      if (e.toString() == "[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.") {
        Get.snackbar("Giriş başarısız", "Email/Şifre Hatalı");
      }else{
      Get.snackbar("Giriş başarısız", "Hata Mesajı : $e");
      print("Hata mesajı = " +e.toString());
      }
    }
  }

  checkUserIsLoggedIn(User? currentUser){
    if (currentUser == null) {
      Get.to(()=>LoginPage());
    } else {
      Get.to(()=>HomePage());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(firebaseCurrentUser,checkUserIsLoggedIn);
  }

  userLogout(){
    FirebaseAuth.instance.signOut();
  }

  // updateUserDataToFirebaseDatabase(
  //   //pesonel info
  // String name,String age,String phoneNo,
  // String city,String country,String profileHeanding,String lookingForInaPartner,

  // // Appearance - dış görünüş
  // String height,String weight,String bodyType,

  // // life style
  // String drink,String smoke,String martialStatus,String haveChildren,String noOfChildren,
  // String professional,String employmentStatus,String income,String livingSituation,
  // String willingToRelocate,String relationshipYouAreLookingFor,

  // // kültürel değerler
  // String nationality,String education,String languageSpoken,String religion,String ethnicity
  //  ) async {

  //  }


//   void addImageToFirebase(){


//     //CreateRefernce to path.
//     StorageReference ref = storageReference.child("yourstorageLocation/");

//     //StorageUpload task is used to put the data you want in storage
//     //Make sure to get the image first before calling this method otherwise _image will be null.

//     StorageUploadTask storageUploadTask = ref.child("image1.jpg").putFile(_image);

//      if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
//           final String url = await ref.getDownloadURL();
//           print("The download URL is " + url);
//      } else if (storageUploadTask.isInProgress) {

//           storageUploadTask.events.listen((event) {
//           double percentage = 100 *(event.snapshot.bytesTransferred.toDouble() 
//                                / event.snapshot.totalByteCount.toDouble());  
//           print("THe percentage " + percentage.toString());
//           });

//           StorageTaskSnapshot storageTaskSnapshot =await storageUploadTask.onComplete;
//           downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();

//           //Here you can get the download URL when the task has been completed.
//           print("Download URL " + downloadUrl1.toString());

//      } else{
//           //Catch any cases here that might come up like canceled, interrupted 
//      }

// }
}