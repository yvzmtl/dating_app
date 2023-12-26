
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/page/tab_screens/favorite_sent_favorite_received_screen.dart';
import 'package:flutter_dating_app/page/tab_screens/like_sent_like_received_screen.dart';
import 'package:flutter_dating_app/page/tab_screens/swiping_screen.dart';
import 'package:flutter_dating_app/page/tab_screens/user_details_screen.dart';
import 'package:flutter_dating_app/page/tab_screens/view_sent_view_received_screen.dart';
import 'package:flutter_dating_app/pushNotification/push_notification.dart';
import 'package:flutter_dating_app/utils/app_colors.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();


}

class _HomePageState extends State<HomePage> {


  int tabsIndex = 0;

  List tabScreenList = [
    SwipingScreen(),
    ViewSentViewReceivedScreen(),
    FavoriteSentFavoriteReceivedScreen(),
    LikeSentLikeReceivedScreen(),
    UserDetailsScreen(userID: FirebaseAuth.instance.currentUser!.uid)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.whenNotificationReceived(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap:(indexNumber){
          setState(() {
            tabsIndex = indexNumber;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.tabSelectedItemColorWhite,
        unselectedItemColor: AppColor.tabUnSelectedItemColorWhite ,
        backgroundColor: AppColor.tabBackgroundColorGrey,
        currentIndex: tabsIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: Dimensions.height10*3,), 
            label: "" ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye, size: Dimensions.height10*3,), 
            label: "" ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.star, size: Dimensions.height10*3,), 
            label: "" ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: Dimensions.height10*3,), 
            label: "" ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: Dimensions.height10*3,), 
            label: "" ),
        ],
      ),

      body: tabScreenList[tabsIndex],
      // Center(
      //   child: Text(
      //     "Hoşgeldiniz!",
      //     style: TextStyle(color: Colors.green,fontSize: 20),
      //   ),
      // ),
    );
  }
}