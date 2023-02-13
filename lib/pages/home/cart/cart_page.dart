import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app3/base/no_data_page.dart';
import 'package:food_app3/controllers/Recommended_product_controller.dart';
import 'package:food_app3/controllers/cart_controller.dart';
import 'package:food_app3/controllers/popular_product_controller.dart';
import 'package:food_app3/pages/home/food/popular_food_detail.dart';
import 'package:food_app3/pages/home/main_food_page.dart';
import 'package:food_app3/routes/route_helper.dart';
import 'package:food_app3/utils/app_contants.dart';
import 'package:food_app3/utils/colors.dart';
import 'package:food_app3/utils/dimensions.dart';
import 'package:food_app3/widgets/app_icon.dart';
import 'package:food_app3/widgets/big_text.dart';
import 'package:food_app3/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.heigth20*3,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios,iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.icon24,
                    ),


                  SizedBox(width: Dimensions.width20*11),

                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.icon24,
                    ),
                  ),

                  AppIcon(icon: Icons.shopping_cart_outlined,iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.icon24,
                  ),

                ],
              )
          ),

       GetBuilder<CartContorller>(builder: (_cartController){
         return _cartController.getItems.length>0? Positioned(
             top: Dimensions.heigth20*5,
             left: Dimensions.width20,
             right: Dimensions.width20,
             bottom: 0,
             child: Container(
               margin: EdgeInsets.only(top: Dimensions.height15),
               //  color: Colors.red,

               child:MediaQuery.removePadding(
                 context: context,
                 removeTop: true,
                 child: GetBuilder<CartContorller>(builder: (cartController){
                   var _cartList = cartController.getItems;
                   return ListView.builder(   // because it takes automatic padding from the top so I need to wrap it in a widget
                       itemCount: _cartList.length,
                       itemBuilder: (_,index){
                         return Container(
                           height: Dimensions.heigth20*5,
                           width: double.maxFinite,
                           child: Row(
                             children: [
                               GestureDetector(
                                 onTap: () {
                                   var popularIndex = Get.find<PopularProductController>()
                                       .popularProductList.indexOf(_cartList[index].product!);   // to get the index
                                   if(popularIndex>=0){
                                     Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                   }

                                   else{
                                     var recommendedIndex = Get.find<RecommendedProductController>()
                                         .recommendedProductList.indexOf(_cartList[index].product!);
                                     Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                   }

                                 },
                                 child: Container(
                                   margin: EdgeInsets.only(bottom: Dimensions.heigth10),
                                   width: Dimensions.heigth20*5,
                                   height: Dimensions.heigth20*5,
                                   decoration: BoxDecoration(
                                     image: DecorationImage(

                                       image: NetworkImage(
                                           AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                       ),
                                       fit: BoxFit.cover,
                                     ),
                                     borderRadius: BorderRadius.circular(Dimensions.radius20),

                                   ),
                                 ),
                               ),
                               SizedBox(width: Dimensions.width10,),
                               Expanded(
                                   child: Container(
                                     // color: Colors.blue,
                                     height: Dimensions.heigth20*5,
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                         BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                         SmallText(text: "Spicy"),

                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             BigText(text: cartController.getItems[index].price!.toString(),color: Colors.redAccent,),

                                             // copiter from previous page
                                             Container(
                                               padding: EdgeInsets.only(
                                                   top: Dimensions.heigth10,
                                                   bottom: Dimensions.heigth10,
                                                   left: Dimensions.width10,
                                                   right: Dimensions.width10),
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                 color: Colors.white,
                                               ),
                                               child: Row(

                                                 children: [
                                                   GestureDetector(
                                                       onTap: (){
                                                         cartController.addItem(_cartList[index].product!, -1);
                                                       },
                                                       child: Icon(Icons.remove, color: AppColors.signColor,)
                                                   ),

                                                   SizedBox(width: Dimensions.width10 / 2),

                                                   BigText(text: _cartList[index].quantity.toString()), //popularProduct.intCartItems.toString()),

                                                   SizedBox(width: Dimensions.width10/2),

                                                   GestureDetector(
                                                       onTap: (){
                                                         cartController.addItem(_cartList[index].product!, 1);
                                                       },
                                                       child: Icon(Icons.add, color: AppColors.signColor)),
                                                 ],
                                               ),
                                             ),
                                           ],
                                         )
                                       ],
                                     ),
                                   )
                               )
                             ],
                           ),
                         );
                       });
                 }
                 ),
               ),
             )
         ):NoDataPage(text: "Your Cart is Empty");
       })
        ],
      ),
        bottomNavigationBar: GetBuilder<CartContorller>(builder: (cartController){
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius30),
                topRight: Radius.circular(Dimensions.radius30),
              ),
              color: AppColors.buttonBackgroundColor,

            ),
            child: cartController.getItems.length>0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.heigth20,
                      bottom: Dimensions.heigth20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [

                      SizedBox(width: Dimensions.width10 / 2),

                      BigText(text: " \$ "+cartController.totalAmount.toString()),

                      SizedBox(width: Dimensions.width10 / 2),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    cartController.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.heigth20,
                        bottom: Dimensions.heigth20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    child: BigText(text: "Check out", color: Colors.white,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ):Container(),
          );

        })
    );
  }
}
