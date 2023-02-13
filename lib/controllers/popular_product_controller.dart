import 'package:flutter/material.dart';
import 'package:food_app3/controllers/cart_controller.dart';
import 'package:food_app3/data/api/repository/popular_product_repo.dart';
import 'package:food_app3/models/cart_model.dart';
import 'package:food_app3/utils/colors.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;   // for else part  using get we can use it outside this class a s this is a public var

  late CartContorller _cart ;

  bool _isLosded = false;                 // for showing loading in the ui
  bool get isLoaded => _isLosded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _intCartItems = 0;
  int get intCartItems => _intCartItems + _quantity;

  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){   // if response is successful it returns 200
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);  // here we need to convert the json data coming from server into some model
      _isLosded = true;

     update();
    }
    else{
      throw Exception("Failed to load");
    }
  }

  // increasing and decreasing quantity in cart
  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity =checkQuantity( _quantity+1);
    }else{
      _quantity = checkQuantity( _quantity-1);

    }
    update();                                     // to tell the ui to update the increment and decrement value
  }

  // to set minimun quantity to 0 and maximum quantity to 20
  int checkQuantity(int quantity){
    if((_intCartItems+quantity)<0){
      Get.snackbar("Item Count", "You can't reduce more!",   //this is used to display a message to user
        backgroundColor: AppColors.mainColor,
      colorText: Colors.white,
      );
      if(_intCartItems>0){
        _quantity = -_intCartItems;
        return _quantity;

      }
      return 0;
    }else if((_intCartItems+quantity)>20){
      Get.snackbar("Item Count", "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }

  }

  void initProduct(ProductModel product,CartContorller cart){
    _quantity=0;
    _intCartItems=0;
    _cart = cart;
    var exist  = false;
    exist = cart.existInCart(product);
    if(exist){
      _intCartItems = _cart.getQuantity(product);
    }

    // get from storage _intCartItems

  }

  void addItem(ProductModel product){
      _cart.addItem(product, _quantity);
      _quantity =0;
      _intCartItems = _cart.getQuantity(product);
      update();
  }

  int get totalItems{
    return _cart.totalItems;}

  List<CartModel> get getItems{
    return _cart.getItems;

  }


}


