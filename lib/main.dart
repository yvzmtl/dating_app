import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/page/auth/login_page.dart';
import 'package:flutter_dating_app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'helper/dependencies.dart' as dep;
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Firebase.initializeApp().then((value) {
  //   Get.put(AuthController());
  // });

 
  await dep.init();
  // Get.put(AuthController());

  await Permission.notification.isDenied.then((value){
    if (value) {
      Permission.notification.request();
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dating App',
      theme: 
      ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColor.mainColorDark
      ),
      
      
      // ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}


