import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/cart_model.dart';
import '../../../utils/app_contants.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  //note shared preferences store data in string format

  List<String> cart = [];
  List<String> cartHistory=[];

  // method to convert object to json
  //to remove the history add a return below two statements and comment the lines and rrestart the app again to remove the history

  void addToCartList(List<CartModel> cartList){
   // sharedPreferences.remove(AppConstants.CART_LIST);
   // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    var time = DateTime.now().toString();
    cart=[];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

  sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  //  getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
     carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
     //print("Inside get cart list"+carts.toString());
    }
    List<CartModel> cartList = [];

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      //cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element)=>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;

  }


  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i=0;i<cart.length;i++){
      print("History List"+cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);

  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);

  }


}