import 'package:flutter/cupertino.dart';
import 'package:food_app3/pages/home/cart/cart_page.dart';
import 'package:food_app3/pages/home/food/popular_food_detail.dart';
import 'package:food_app3/pages/home/food/recommended_food_detail.dart';
import 'package:food_app3/pages/home/home_page.dart';
import 'package:food_app3/pages/home/main_food_page.dart';
import 'package:food_app3/pages/home/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getSpalshPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId,String page)=>'$popularFood?pageId=$pageId&page=$page';   // to pass the parameter we can use this method
  static String getRecommendedFood(int pageId,String page)=>'$recommendedFood?pageId=$pageId&page=$page';   // to pass the parameter we can use this method
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [          // Creating a list of routing pages
    //inital page

    GetPage(name: splashPage, page: ()=>SplashScreen()),

    GetPage(name: initial, page: ()=>HomePage()),

    //Popular Food Page
    GetPage(name: popularFood, page:(){     // function for popular food page
      var pageId = Get.parameters['pageId'];   // Grabbing the passed parameter
      var page = Get.parameters['page'];
      return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
    },
    transition: Transition.fadeIn,
    ),

    //Recommended Food Page
    GetPage(name: recommendedFood, page:(){     // function for popular food page
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetails(pageId: int.parse(pageId!),page:page!);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name: cartPage,page: (){
      return CartPage();
    },
    transition: Transition.fadeIn,
    )

  ];

}