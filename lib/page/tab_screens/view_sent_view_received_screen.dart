

import 'package:flutter/material.dart';
import 'package:flutter_dating_app/controller/profile_controller.dart';
import 'package:flutter_dating_app/utils/dimensions.dart';
import 'package:flutter_dating_app/widget/custom_text_widget.dart';

class ViewSentViewReceivedScreen extends StatefulWidget {
  const ViewSentViewReceivedScreen({super.key});


  @override
  State<ViewSentViewReceivedScreen> createState() => _ViewSentViewReceivedScreen();
}

class _ViewSentViewReceivedScreen extends State<ViewSentViewReceivedScreen> {
  bool isViewSentClicked = true;
  var profileController = ProfileController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      profileController.viewList;
    });
    profileController.getViewListKeys(isViewSentClicked);
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
                  isViewSentClicked = true;
                });
                profileController.getViewListKeys(isViewSentClicked);
              },
              child: CustomTextWidget(
                text: "Görüntüler",
                textColor: isViewSentClicked? Colors.white : Colors.grey,
                fontWeight: isViewSentClicked ? FontWeight.bold : FontWeight.normal,
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
                  isViewSentClicked = false;
                });
                profileController.getViewListKeys(isViewSentClicked);
              },
              child: CustomTextWidget(
                text: "Görüntü",
                textColor: isViewSentClicked == false? Colors.white : Colors.grey,
                fontWeight: isViewSentClicked ? FontWeight.bold : FontWeight.normal,
                fontSize: Dimensions.height10*1.4,
              )
              
            ),
          ],
        ),
      ),
      
      body: profileController.viewList.isEmpty 
        ? Center(
          child: Icon(Icons.person_off_sharp,color: Colors.white,size: Dimensions.height10*6),
        ) 
        : GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(Dimensions.height10),
          children: 
            List.generate(profileController.viewList.length,(index) {
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
                            image: NetworkImage(profileController.viewList[index]["imageProfile"]),
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
                                  text: "${profileController.viewList[index]["name"].toString()} ⦿ ${profileController.viewList[index]["age"].toString()}",
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
                                      text: "${profileController.viewList[index]["city"].toString()} , ${profileController.viewList[index]["country"].toString()}",
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