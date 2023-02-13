// Getx package mainly used for routing and state management

import 'package:get/get.dart';
class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;



  static double pageViewContainer = screenHeight/3.10;   // Because height is 683 and container height is 220 so 683/220 = 3
  static double pageViewTextContainer = screenHeight/5.69;
  static double pageView = screenHeight/2;

  // Dynamic Height padding and margin
  static double heigth10 = screenHeight/68.3;
  static double heigth20 = screenHeight/34.15;
  static double height15 = screenHeight/45.5;
  static double height30 = screenHeight/22.7;
  static double height45 = screenHeight/15.1;
  static double height24 = screenHeight/28.45;

  //Dynamic Width padding and margin
  static double width10 = screenWidth/68.3;
  static double width20 = screenWidth/34.15;
  static double width30 = screenWidth/22.7;   // 683/30
  static double width45 = screenWidth/15.1;
  static double width50 = screenWidth/13.66;
  static double width70 = screenWidth/9.757;


  // Dynamic size of font
  static double font20 = screenHeight/34.15;
  static double font26 = screenHeight/26.26;    // 683/26
  static double font16 = screenHeight/42.6;    // 683/16
  static double font13 = screenHeight/52.53;

  //Dynamic borderRadius
  static double radius20 = screenHeight/34.15;
  static double radius30 = screenHeight/22.7;
  static double radius15 = screenHeight/45.5;

  //Dynamic Icon Size
  static double icon24 = screenHeight/28.4;
  static double icon16 = screenHeight/42.68;



  //List View Size
  static double listViewImgSize = screenWidth/3.42;   // The width of the device is 411 so 411/width of image(120)
  static double listViewTextContSize = screenWidth/4.11;  // The height of the device 411 so 411/height of image(100)

  //Popular food
  static double popularFoodSize = screenHeight/1.95;  // 683/350

  // Bottom Height in poppular food detail
  static double  bottomHeightBar = screenHeight/5.69;




  //spalsh Screen size
  static double spalshImg = screenHeight/3.18;



}