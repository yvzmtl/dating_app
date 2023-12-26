
import 'package:flutter_dating_app/controller/auth_controller.dart';
import 'package:flutter_dating_app/controller/profile_controller.dart';
import 'package:get/get.dart';

Future<void> init() async {

  //shared preferences
  //SharedPreferences.setMockInitialValues({});
  // final sharedPreferences = await SharedPreferences.getInstance();
  // Get.lazyPut(() => sharedPreferences);



  



  //controller
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => ProfileController());
  // Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}