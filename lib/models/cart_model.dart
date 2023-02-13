//here i edited the popular model and add some new priducts

import 'package:food_app3/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel(
      {
        this.id,
        this.name,
        this.price,
        this.img,
        this.isExist,
        this.quantity,
        this.time,
        this.product,
    });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    isExist = json['isExist'];
    quantity = json['quantity'];
    time  = json['time'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String,dynamic> toJson(){
   return{
     "id":this.id,
     "name":this.name,
     "price":this.price,
     "img":this.img,
     "quantity":this.quantity,
     "isExist":this.isExist,
     "time":this.time,
     "product":this.product!.tojson(),
   };
  }


}