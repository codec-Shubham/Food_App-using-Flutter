import 'package:flutter/material.dart';
import 'package:food_app3/controllers/cart_controller.dart';
import 'package:food_app3/controllers/popular_product_controller.dart';
import 'package:food_app3/data/api/repository/popular_product_repo.dart';
import 'package:food_app3/pages/home/cart/cart_page.dart';
import 'package:food_app3/pages/home/food/recommended_food_detail.dart';
import 'package:food_app3/pages/home/food_page_body.dart';
import 'package:food_app3/pages/home/main_food_page.dart';
import 'package:food_app3/pages/home/splash/splash_page.dart';
import 'package:food_app3/routes/route_helper.dart';
import 'package:get/get.dart';
import "package:food_app3/helper/dependecnies.dart" as dep;
import 'controllers/Recommended_product_controller.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  // it will make sure that dependencies are loaded correctly
  await dep.init();  // here I try lo load dependencies before app starts

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartContorller>().getCartData();

    // as there is a error that controller not found then we need to use this scenerio
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
         return GetMaterialApp(       // In dimensions file it is not able to get the height if the device so we need to use the GetMaterialApp function
           debugShowCheckedModeBanner: false,
           title: 'Flutter Demo',
           // home:  SplashScreen(),
           initialRoute: RouteHelper.getSpalshPage(),
           getPages: RouteHelper.routes,


         );
       });
    });
  }
}

