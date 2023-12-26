

import 'package:flutter/material.dart';
import 'package:flutter_dating_app/controller/profile_controller.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';
import 'package:flutter_dating_app/widget/custom_text_widget.dart';

class FavoriteSentFavoriteReceivedScreen extends StatefulWidget {
  const FavoriteSentFavoriteReceivedScreen({super.key});


  @override
  State<FavoriteSentFavoriteReceivedScreen> createState() => _FavoriteSentFavoriteReceivedScreenState();
}

class _FavoriteSentFavoriteReceivedScreenState extends State<FavoriteSentFavoriteReceivedScreen> {
  bool isFavoriteSentClicked = true;
  var profileController = ProfileController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      profileController.favoriteList;
    });
    profileController.getFavoriteListKeys(isFavoriteSentClicked);
     
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                
                setState(() {
                  isFavoriteSentClicked = true;
                });
                profileController.getFavoriteListKeys(isFavoriteSentClicked);
              },
              child: CustomTextWidget(
                text: "Favorilerim",
                textColor: isFavoriteSentClicked? Colors.white : Colors.grey,
                fontWeight: isFavoriteSentClicked ? FontWeight.bold : FontWeight.normal,
                fontSize: Dimensions.height10*1.4,
              )
              
            ),

            CustomTextWidget(
              text: "  |  ",
              textColor: Colors.grey
            ),

            TextButton(
              onPressed: (){
                 setState(() {
                  isFavoriteSentClicked = false;
                });
                profileController.getFavoriteListKeys(isFavoriteSentClicked);
              },
              child: CustomTextWidget(
                text: "Favoriye Alanlar",
                textColor: isFavoriteSentClicked == false? Colors.white : Colors.grey,
                fontWeight: isFavoriteSentClicked ? FontWeight.bold : FontWeight.normal,
                fontSize: Dimensions.height10*1.4,
              )
              
            ),
          ],
        ),
      ),
      
      body: profileController.favoriteList.isEmpty 
        ? Center(
          child: Icon(Icons.person_off_sharp,color: Colors.white,size: Dimensions.height10*6),
        ) 
        : GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(Dimensions.height10),
          children: 
            List.generate(profileController.favoriteList.length,(index) {
              return GridTile(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.height10*0.2),
                  child: Card(
                    color: Colors.blue.shade200,
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(profileController.favoriteList[index]["imageProfile"]),
                            fit: BoxFit.cover)
                        ),
                        child: Padding(padding: EdgeInsets.all(Dimensions.height10*0.8),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),

                              //name - age
                              // Expanded(
                                // child:
                                 CustomTextWidget(
                                  text: "${profileController.favoriteList[index]["name"].toString()} ⦿ ${profileController.favoriteList[index]["age"].toString()}",
                                  textColor: Colors.grey,
                                  fontSize: Dimensions.height10*1.6,
                                  fontWeight: FontWeight.bold,
                                ),
                              // ),

                              SizedBox(height: Dimensions.height5),

                              // city - country
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey,
                                    size: Dimensions.height10*1.4,
                                  ),
                                  Expanded(
                                    child: CustomTextWidget(
                                      text: "${profileController.favoriteList[index]["city"].toString()} , ${profileController.favoriteList[index]["country"].toString()}",
                                      textColor: Colors.grey,
                                      fontSize: Dimensions.height10*1.2,
                                      fontWeight: FontWeight.bold,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),),
                      ),
                    ),
                  ),
                  ),
                 );
             })
          
          )
    );
  }
}