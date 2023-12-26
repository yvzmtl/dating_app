
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonModel {

  //pesonel info
  String? uid;
  String? imageProfile;
  String? email;
  String? password;
  String? name;
  int? age;
  String? gender;
  String? phoneNo;
  String? city;
  String? country;
  String? profileHeanding;
  String? lookingForInaPartner;
  int? publishedDateTime;


  // Appearance - dış görünüş
  String? height;
  String? weight;
  String? bodyType;

  // life style
  String? drink; // içki içiyor mu
  String? smoke; // sigara içiyor mu
  String? martialStatus; // medeni durumu
  String? haveChildren; // çocuk var mı
  String? noOfChildren; // çocuk sayısı
  String? professional; // mesleği
  String? employmentStatus; // çalışma durumu - tam zamanlı - yarı zamanlı
  String? income; //maaş
  String? livingSituation; // aile veya çocuklu yaşama durumu
  String? willingToRelocate; // başka şehre taşınma durumu
  String? relationshipYouAreLookingFor; // aradığınız ilişki - evlilik, arkadaşlık vs.


  // kültürel değerler
  String? nationality; // vatandaşlık
  String? education; // eğitim
  String? languageSpoken; // konuşulan dil
  String? religion; // din
  String? ethnicity; // etnik köken - amerikan,avrupa vs.

  PersonModel({
    this.uid,
    this.imageProfile,
    this.email,
    this.password,
    this.name,
    this.age,
    this.gender,
    this.phoneNo,
    this.city,
    this.country,
    this.profileHeanding,
    this.lookingForInaPartner,
    this.publishedDateTime,
    this.height,
    this.weight,
    this.bodyType,
    this.drink,
    this.smoke,
    this.martialStatus,
    this.haveChildren,
    this.noOfChildren,
    this.professional,
    this.employmentStatus,
    this.income,
    this.livingSituation,
    this.willingToRelocate,
    this.relationshipYouAreLookingFor,
    this.nationality,
    this.education,
    this.languageSpoken,
    this.religion,
    this.ethnicity
  });

  // PersonModel.fromJson(Map<String,dynamic> datasnapshot){
  //     uid: datasnapshot["uid"];
  //     imageProfile: datasnapshot["imageProfile"];
  //     email: datasnapshot["email"];
  //     password: datasnapshot["password"];
  //     name: datasnapshot["name"];
  //     age: datasnapshot["age"];
  //     phoneNo: datasnapshot["phoneNo"];
  //     city: datasnapshot["city"];
  //     country: datasnapshot["country"];
  //     profileHeanding: datasnapshot["profileHeanding"];
  //     lookingForInaPartner: datasnapshot["lookingForInaPartner"];
  //     publishedDateTime: datasnapshot["publishedDateTime"];
  //     height: datasnapshot["height"];
  //     weight: datasnapshot["weight"];
  //     bodyType: datasnapshot["bodyType"];
  //     drink: datasnapshot["drink"];
  //     smoke: datasnapshot["smoke"];
  //     martialStatus: datasnapshot["martialStatus"];
  //     haveChildren: datasnapshot["haveChildren"];
  //     noOfChildren: datasnapshot["noOfChildren"];
  //     professional: datasnapshot["professional"];
  //     employmentStatus: datasnapshot["employmentStatus"];
  //     income: datasnapshot["income"];
  //     livingSituation: datasnapshot["livingSituation"];
  //     willingToRelocate: datasnapshot["willingToRelocate"];
  //     relationshipYouAreLookingFor: datasnapshot["relationshipYouAreLookingFor"];
  //     nationality: datasnapshot["nationality"];
  //     education: datasnapshot["education"];
  //     languageSpoken: datasnapshot["languageSpoken"];
  //     religion: datasnapshot["religion"];
  //     ethnicity: datasnapshot["ethnicity"];

  // }

  static PersonModel fromDataSnapshot(DocumentSnapshot snapshot){
    var datasnapshot = snapshot.data() as Map<String,dynamic>;

    return PersonModel(
      uid: datasnapshot["uid"],
      imageProfile: datasnapshot["imageProfile"],
      email: datasnapshot["email"],
      password: datasnapshot["password"],
      name: datasnapshot["name"],
      age: datasnapshot["age"],
      gender: datasnapshot["gender"],
      phoneNo: datasnapshot["phoneNo"],
      city: datasnapshot["city"],
      country: datasnapshot["country"],
      profileHeanding: datasnapshot["profileHeanding"],
      lookingForInaPartner: datasnapshot["lookingForInaPartner"],
      publishedDateTime: datasnapshot["publishedDateTime"],
      height: datasnapshot["height"],
      weight: datasnapshot["weight"],
      bodyType: datasnapshot["bodyType"],
      drink: datasnapshot["drink"],
      smoke: datasnapshot["smoke"],
      martialStatus: datasnapshot["martialStatus"],
      haveChildren: datasnapshot["haveChildren"],
      noOfChildren: datasnapshot["noOfChildren"],
      professional: datasnapshot["professional"],
      employmentStatus: datasnapshot["employmentStatus"],
      income: datasnapshot["income"],
      livingSituation: datasnapshot["livingSituation"],
      willingToRelocate: datasnapshot["willingToRelocate"],
      relationshipYouAreLookingFor: datasnapshot["relationshipYouAreLookingFor"],
      nationality: datasnapshot["nationality"],
      education: datasnapshot["education"],
      languageSpoken: datasnapshot["languageSpoken"],
      religion: datasnapshot["religion"],
      ethnicity: datasnapshot["ethnicity"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid" : uid,
      "imageProfile" : imageProfile,
      "email" : email,
      "password" : password,
      "name" : name,
      "age" : age,
      "gender" : gender,
      "phoneNo" : phoneNo,
      "city" : city,
      "country" : country,
      "profileHeanding" : profileHeanding,
      "lookingForInaPartner" : lookingForInaPartner,
      "publishedDateTime" : publishedDateTime,
      "height" : height,
      "weight" : weight,
      "bodyType" : bodyType,
      "drink" : drink,
      "smoke" : smoke,
      "martialStatus" : martialStatus,
      "haveChildren" : haveChildren,
      "noOfChildren" : noOfChildren,
      "professional" : professional,
      "employmentStatus" : employmentStatus,
      "income" : income,
      "livingSituation" : livingSituation,
      "willingToRelocate" : willingToRelocate,
      "relationshipYouAreLookingFor" : relationshipYouAreLookingFor,
      "nationality" : nationality,
      "education" : education,
      "languageSpoken" : languageSpoken,
      "religion" : religion,
      "ethnicity" : ethnicity,
    };
  }

}