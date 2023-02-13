import 'package:food_app3/data/api/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import '../data/api/repository/recommended_product_repo.dart';
import '../models/product_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;   // for else part


  bool _isLosded = false;                 // for showing loading in the ui
  bool get isLoaded => _isLosded;

  Future<void> getRecommendedProductList() async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200){   // if response is successful it returns 200
     // print("Got Recommended");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);  // here we need to convert the json data coming from server into some model
      _isLosded = true;
      update();
    }
    else{
      throw Exception("Failed to load");

    }
  }
}