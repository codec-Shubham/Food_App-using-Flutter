import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app3/base/no_data_page.dart';
import 'package:food_app3/controllers/cart_controller.dart';
import 'package:food_app3/routes/route_helper.dart';
import 'package:food_app3/utils/app_contants.dart';
import 'package:food_app3/utils/dimensions.dart';
import 'package:food_app3/widgets/app_icon.dart';
import 'package:food_app3/widgets/big_text.dart';
import 'package:food_app3/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/cart_model.dart';
import '../../../utils/colors.dart';

class CartHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartContorller>().getCartHistoryList().reversed.toList();

    Map<String, int > cartItemsPerOrder = Map();
    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!,(value)=>++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }
    }
    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;

    return Scaffold(
        body: Column(
        children: [
          Container(
            height: Dimensions.heigth20*5,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height30*2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Your Cart History",color: Colors.white),
                AppIcon(icon: Icons.shopping_cart_outlined,iconColor: AppColors.mainColor,backgroundColor: AppColors.yellowColor,),
              ],
            ),
          ),
         GetBuilder<CartContorller>(builder: (_cartController){
           return _cartController.getCartHistoryList().length>0? Expanded(
             child: Container(
                 margin: EdgeInsets.only(
                   top: Dimensions.heigth20,
                   left: Dimensions.width20,
                   right: Dimensions.width20,
                 ),

                 child: MediaQuery.removePadding(
                   removeTop: true,
                   context: context, child: ListView(
                   children: [
                     for(int i=0;i<itemsPerOrder.length;i++)
                       Container(
                         height: Dimensions.height30*4,
                         margin: EdgeInsets.only(bottom: Dimensions.heigth20),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             ((){   // Immediately Invoked Function we can place it anywhere
                               DateTime parseDate =  DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
                               var inputDate = DateTime.parse(parseDate.toString());
                               var outputFormat = DateFormat("MM/dd/yyyy  hh:mm a");
                               var outputDate = outputFormat.format(inputDate);
                               return BigText(text:outputDate);
                             }()),

                             SizedBox(height: Dimensions.heigth10),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Wrap(
                                   direction: Axis.horizontal,
                                   children: List.generate(itemsPerOrder[i], (index){
                                     if(listCounter<getCartHistoryList.length){
                                       listCounter++;
                                     }
                                     return index<=2?Container(
                                       height: Dimensions.heigth20*4,
                                       width: Dimensions.width20*6.8,
                                       margin: EdgeInsets.only(right: Dimensions.width10),
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                           image: DecorationImage(
                                               fit: BoxFit.cover,
                                               image: NetworkImage(
                                                   AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!
                                               )
                                           )
                                       ),
                                     ):Container();
                                   }),
                                 ),
                                 Container(
                                   height: Dimensions.heigth20*4,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       SmallText(text: "Total",color: AppColors.mainColor),
                                       BigText(text: itemsPerOrder[i].toString()+" Items ",color: AppColors.mainBlackColor),
                                       GestureDetector(
                                         onTap: (){
                                           var ordertime = cartItemsPerOrderToList();
                                           Map<int, CartModel> moreOrder = {};
                                           for(int j=0;j<getCartHistoryList.length;j++){
                                             if(getCartHistoryList[j].time == ordertime[i]){
                                               moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                   CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                               );
                                             }
                                           }
                                           Get.find<CartContorller>().setItems = moreOrder;
                                           Get.find<CartContorller>().addToCartList();
                                           Get.toNamed(RouteHelper.getCartPage());
                                         },
                                         child: Container(
                                           padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.heigth10/2),
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                             border: Border.all(width: 1,color: AppColors.mainColor),
                                           ),
                                           child: SmallText(text: "one more",color: AppColors.mainColor),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ],
                             )
                           ],
                         ),
                       )
                   ],
                 ),)
             ),
           )
               :Container(
               height: MediaQuery.of(context).size.height/1.5,
               child: NoDataPage(text: "You didn't buy anything so far"));
         })
        ],
      )
    );
  }
}
