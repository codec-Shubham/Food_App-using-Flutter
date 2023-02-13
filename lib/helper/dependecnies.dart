import 'package:food_app3/controllers/cart_controller.dart';
import 'package:food_app3/controllers/popular_product_controller.dart';
import 'package:food_app3/data/api/repository/cart_repo.dart';
import 'package:food_app3/data/api/repository/popular_product_repo.dart';
import 'package:food_app3/utils/app_contants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/Recommended_product_controller.dart';
import '../data/api/api_client.dart';
import 'package:http/http.dart' as http;
import '../data/api/repository/recommended_product_repo.dart';

Future<void> init()async {// here i am using method type future

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);  // localStorage
  // api client
  Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL));

  //repos
  Get.lazyPut(()=>PopularProductRepo(apiClient: Get.find()));  // it automatically find the APiClient
  Get.lazyPut(()=>RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=>CartRepo(sharedPreferences:Get.find()));

  //controllers
  Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartContorller(cartRepo: Get.find()),);



}