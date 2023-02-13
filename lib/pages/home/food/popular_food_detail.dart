import 'package:flutter/material.dart';
import 'package:food_app3/controllers/cart_controller.dart';
import 'package:food_app3/controllers/popular_product_controller.dart';
import 'package:food_app3/pages/home/main_food_page.dart';
import 'package:food_app3/routes/route_helper.dart';
import 'package:food_app3/utils/app_contants.dart';
import 'package:food_app3/utils/dimensions.dart';
import 'package:food_app3/widgets/app_column.dart';
import 'package:food_app3/widgets/app_icon.dart';
import 'package:food_app3/widgets/expandable_text_widget.dart';

import '../../../utils/colors.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/icon_and_text_widget.dart';
import '../../../widgets/small_text.dart';
import 'package:food_app3/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:food_app3/utils/app_contants.dart';

import '../cart/cart_page.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
   final String page;
  PopularFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartContorller>());   // to set new page quantity value to zero

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned(
              left: 0, // positions of the container
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodSize,
                decoration:  BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,             // making changes here
                        image: NetworkImage(
                            AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                        ),
                    ),
                ),
              ),
          ),
          //Showing  icons over image
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                     if(page == 'cartpage'){
                       Get.toNamed(RouteHelper.getCartPage());
                     }else{
                       Get.toNamed(RouteHelper.getInitial());
                     }
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)
                ),

               GetBuilder<PopularProductController>(builder: (controller){
                 return GestureDetector(
                   onTap: (){
                     if(controller.totalItems>=0)
                     Get.toNamed(RouteHelper.getCartPage());
                   },
                   child: Stack(
                     children: [
                       AppIcon(icon: Icons.shopping_cart_outlined),
                       controller.totalItems>=1?
                     Positioned(
                       right: 0,
                         top: 0,
                         child: AppIcon(icon: Icons.circle,size: 20,iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,)
                     ) :
                     Container(),
                       Get.find<PopularProductController>().totalItems>=1?
                       Positioned(
                           right: 5,
                           top: 3,
                           child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                             size: 12,color: Colors.white,

                           ),
                       ) :
                       Container(),
                     ],
                   ),
                 );
               })

              ],
            ),
          ),

          // Introduction of page
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodSize - 86,
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.heigth10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.heigth10),
                    BigText(text: "Introduce", size: Dimensions.font20),
                    SizedBox(height: Dimensions.heigth10),
                    //Expandebale Text Widget
                    Expanded(
                      // Single child wrapped with Expanded widget to overcome the overflow
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                            text: product.description!,
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
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
        child: Row(
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
                  GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(Icons.remove, color: AppColors.signColor,)
                  ),

                  SizedBox(width: Dimensions.width10 / 2),

                  BigText(text: popularProduct.intCartItems.toString()),

                  SizedBox(width: Dimensions.width10 / 2),

                  GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(true);

                      },
                      child: Icon(Icons.add, color: AppColors.signColor)),
                ],
              ),
            ),
            Container(

                padding: EdgeInsets.only(
                    top: Dimensions.heigth20,
                    bottom: Dimensions.heigth20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),

                child: GestureDetector(
                    onTap: (){
                      popularProduct.addItem(product);
                    },
                    child: BigText(text: "\$ ${product.price!} | Add to cart", color: Colors.white,)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ))
          ],
        ),
      );

    })
    );
  }
}
