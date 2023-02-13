import 'package:flutter/material.dart';
import 'package:food_app3/pages/home/food_page_body.dart';
import 'package:food_app3/utils/colors.dart';
import 'package:food_app3/utils/dimensions.dart';
import 'package:food_app3/widgets/big_text.dart';
import 'package:food_app3/widgets/small_text.dart';
import 'package:food_app3/pages/home/food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
   // print("Height"+ MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Column(
        children: [

          //showing the header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height24,bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "India",color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: "Shimla",color: Colors.black54),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.width70+10,
                      height: Dimensions.height45-3,
                      child: Icon(Icons.search,color: Colors.white,size: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // showing the body
          Expanded(child: SingleChildScrollView(   // Wrapping into Expanded to prevent from overflow
            child: FoodPageBody(),
          ))

        ],
      ),
    );
  }
}
