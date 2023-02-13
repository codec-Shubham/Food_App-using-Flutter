import 'package:food_app3/data/api/api_client.dart';
import 'package:food_app3/utils/app_contants.dart';
import 'package:get/get.dart';


class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);  // calling the client  from repo
  }

}