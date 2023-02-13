import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app3/utils/colors.dart';
import 'package:food_app3/utils/dimensions.dart';
import 'package:get/get.dart';
import '../../../controllers/Recommended_product_controller.dart';
import '../../../controllers/popular_product_controller.dart';
import '../../../routes/route_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  
  //two varibales for the animation
  late Animation<double> animation;
  late AnimationController controller;


  Future<void>_loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  
  //initialization of the variables
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    _loadResources();
    controller =   AnimationController(vsync: this, duration:Duration(seconds:2))..forward();
    animation =  CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      Duration(seconds: 3),
        () =>Get.offNamed(RouteHelper.getInitial())
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(child: Image.asset("assets/images/Applogo7.png",width: Dimensions.spalshImg))),
        ],
      ),
    );
  }
}

