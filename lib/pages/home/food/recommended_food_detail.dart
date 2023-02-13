import 'package:flutter/material.dart';
import 'package:food_app3/controllers/Recommended_product_controller.dart';
import 'package:food_app3/controllers/popular_product_controller.dart';
import 'package:food_app3/routes/route_helper.dart';
import 'package:food_app3/utils/app_contants.dart';
import 'package:food_app3/utils/colors.dart';
import 'package:food_app3/utils/dimensions.dart';
import 'package:food_app3/widgets/app_icon.dart';
import 'package:food_app3/widgets/big_text.dart';
import 'package:food_app3/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';

class RecommendedFoodDetails extends StatelessWidget {
   final int  pageId;
   final String page;

  RecommendedFoodDetails({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartContorller>());
    return Scaffold(
      backgroundColor: Colors.white,
        body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,   // it automarically creats a back menu button to remove that we use this property
                toolbarHeight: 70,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,//Title can take any type of the widget
                  children: [
                    GestureDetector(
                      onTap: (){
                       if(page== "cartpage"){
                         Get.toNamed(RouteHelper.getCartPage());
                       }else{
                         Get.toNamed(RouteHelper.getInitial());
                       }
                      },
                        child: AppIcon(icon: Icons.clear)),
                   // AppIcon(icon: Icons.shopping_cart_outlined),

                    GetBuilder<PopularProductController>(builder: (controller){
                      return GestureDetector(
                        onTap: (){
                          if(controller.totalItems>=1)
                            Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            controller.totalItems>=1?
                            Positioned(
                                right: 0,
                                top: 0,
                                child:AppIcon(icon: Icons.circle,size: 20,iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,)
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

                bottom: PreferredSize(                       // To add a bottom bar below the image
                  preferredSize: Size.fromHeight(30),
                  child: Container(
                    child: Center(child: BigText(text: product.name!,size: Dimensions.font26,)),
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 5,bottom: 10),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius30),
                        topRight: Radius.circular(Dimensions.radius30),
                      ),
                    ),
                  )
                ),
                expandedHeight: 300.0,                         // To ass the image into the CustomScrollWidget
                pinned: true,   // To leave some space at the top
                backgroundColor: AppColors.yellowColor,    // To have space as a background color yellow
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                  fit:BoxFit.cover
                  ),
                  ),
                ),


              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      child: ExpandableTextWidget(text: product.description!,
                      ),
                      margin: EdgeInsets.only(left:Dimensions.width20,right: Dimensions.width20,top: Dimensions.heigth10),
              ),
                  ],
                )
                ),
            ],
          ),

        bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20*2.5,
                  right: Dimensions.width20*2.5,
                  top: Dimensions.heigth10,
                  bottom: Dimensions.heigth10,

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                        },
                      child: AppIcon(
                        size: Dimensions.icon24,
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,),
                    ),

                    BigText(text: " \$${product.price!} x  ${controller.intCartItems} ",color: AppColors.mainBlackColor,size: Dimensions.font26,),

                    GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child:  AppIcon(
                        size: Dimensions.icon24,
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,),
                    )
                  ],
                ),
              ),
              Container(                               // as used in popular food detail
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.only(top:Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions
                    .width20),
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
                      padding: EdgeInsets.only(top: Dimensions.heigth20,bottom: Dimensions.heigth20,
                          left: Dimensions.width20,right: Dimensions.width20),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),

                      child: Icon(Icons.favorite,color: AppColors.mainColor,),

                    ),
                    GestureDetector(
                      onTap: (){
                        controller.addItem(product);
                      },

                      child: Container(
                          padding: EdgeInsets.only(top: Dimensions.heigth20,bottom: Dimensions.heigth20,
                              left: Dimensions.width20,right: Dimensions.width20),
                          child: BigText(text: "\$ ${product.price} | Add to cart",color: Colors.white,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor,
                          )
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        })
    );
  }
}
