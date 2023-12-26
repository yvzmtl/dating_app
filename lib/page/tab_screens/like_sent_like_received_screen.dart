

import 'package:flutter/material.dart';
import 'package:flutter_dating_app/controller/profile_controller.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';
import 'package:flutter_dating_app/widget/custom_text_widget.dart';

class LikeSentLikeReceivedScreen extends StatefulWidget {
  const LikeSentLikeReceivedScreen({super.key});


  @override
  State<LikeSentLikeReceivedScreen> createState() => _LikeSentLikeReceivedScreenState();
}

class _LikeSentLikeReceivedScreenState extends State<LikeSentLikeReceivedScreen> {
  bool isLikeSentClicked = true;
  var profileController = ProfileController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      profileController.likeList;
    });
    profileController.getLikeListKeys(isLikeSentClicked);
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
                  isLikeSentClicked = true;
                });
                profileController.getLikeListKeys(isLikeSentClicked);
              },
              child: CustomTextWidget(
                text: "Beğenilerim",
                textColor: isLikeSentClicked? Colors.white : Colors.grey,
                fontWeight: isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
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
                  isLikeSentClicked = false;
                });
                profileController.getLikeListKeys(isLikeSentClicked);
              },
              child: CustomTextWidget(
                text: "Beğenenler",
                textColor: isLikeSentClicked == false? Colors.white : Colors.grey,
                fontWeight: isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
                fontSize: Dimensions.height10*1.4,
              )
              
            ),
          ],
        ),
      ),
      
      body: profileController.likeList.isEmpty 
        ? Center(
          child: Icon(Icons.person_off_sharp,color: Colors.white,size: Dimensions.height10*6),
        ) 
        : GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(Dimensions.height10),
          children: 
            List.generate(profileController.likeList.length,(index) {
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
                            image: NetworkImage(profileController.likeList[index]["imageProfile"]),
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
                                  text: "${profileController.likeList[index]["name"].toString()} ⦿ ${profileController.likeList[index]["age"].toString()}",
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
                                      text: "${profileController.likeList[index]["city"].toString()} , ${profileController.likeList[index]["country"].toString()}",
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