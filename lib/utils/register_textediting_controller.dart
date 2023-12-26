
import 'package:flutter/material.dart';

class ControllerValue {
  //personel info
  static TextEditingController emailTextController = TextEditingController(); //mail
  static TextEditingController passwordTextController = TextEditingController(); //şifre
  static TextEditingController genderTextController = TextEditingController(); //şifre
  static TextEditingController nameTextController = TextEditingController(); //ad soyad
  static TextEditingController ageTextController = TextEditingController(); //yaş
  static TextEditingController phoneTextController = TextEditingController(); //telefon
  static TextEditingController cityTextController = TextEditingController(); //şehir
  static TextEditingController countryTextController = TextEditingController(); //ülke
  static TextEditingController profileHeadingTextController = TextEditingController(); // profil açıklaması
  static TextEditingController lookingForInaPartnerTextController = TextEditingController(); //ortak aranıyor mu

  // dış görünüş
  static TextEditingController heightTextController = TextEditingController(); //boy
  static TextEditingController weightTextController = TextEditingController(); // kilo
  static TextEditingController bodyTypeTextController = TextEditingController(); // vücut tipi

  //hayat tarzı
  static TextEditingController drinkTextController = TextEditingController(); // içki içiyor mu
  static TextEditingController smokeTextController = TextEditingController(); // sigara içiyor mu
  static TextEditingController martialStatusTextController = TextEditingController(); // medeni durumu
  static TextEditingController haveChildrenTextController = TextEditingController(); // çocuk var mı
  static TextEditingController noOfChildrenTextController = TextEditingController(); // çocuk sayısı
  static TextEditingController professionalTextController = TextEditingController(); // mesleği
  static TextEditingController employmentStatusTextController = TextEditingController(); // çalışma durumu - tam zamanlı - yarı zamanlı
  static TextEditingController incomeTextController = TextEditingController(); //maaş
  static TextEditingController livingSituationTextController = TextEditingController(); // aile veya çocuklu yaşama durumu
  static TextEditingController willingToRelocateTextController = TextEditingController(); // başka şehre taşınma durumu
  static TextEditingController relationshipYouAreLookingForTextController = TextEditingController(); // aradığınız ilişki - evlilik, arkadaşlık vs.

  // kültürel değerler
  static TextEditingController nationalityTextController = TextEditingController(); // vatandaşlık
  static TextEditingController educationTextController = TextEditingController(); // eğitim
  static TextEditingController languageSpokenTextController = TextEditingController(); // konuşulan dil
  static TextEditingController religionTextController = TextEditingController(); // din
  static TextEditingController ethnicityTextController = TextEditingController(); // etnik köken - amerikan,avrupa vs.
}