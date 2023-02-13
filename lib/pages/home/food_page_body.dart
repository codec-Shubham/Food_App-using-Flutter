import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_app3/controllers/Recommended_product_controller.dart';
import 'package:food_app3/controllers/popular_product_controller.dart';
import 'package:food_app3/models/product_model.dart';
import 'package:food_app3/pages/home/food/popular_food_detail.dart';
import 'package:food_app3/routes/route_helper.dart';
import 'package:food_app3/utils/app_contants.dart';
import 'package:food_app3/utils/colors.dart';
import 'package:food_app3/utils/dimensions.dart';
import 'package:food_app3/widgets/app_column.dart';
import 'package:food_app3/widgets/big_text.dart';
import 'package:food_app3/widgets/icon_and_text_widget.dart';
import 'package:food_app3/widgets/small_text.dart';
import 'package:food_app3/utils/dimensions.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  @override
  _FoodPAgeBodyState createState() => _FoodPAgeBodyState();
}

class _FoodPAgeBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
      viewportFraction: 0.85); // this is to show the portion of the next slide
  var _currentPageValue = 0.0;
  var _scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        //print(_currentPageValue.toString());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          // to pass server values i will warp container inside the GetBuilder(attaching this with ui)
          return popularProducts.isLoaded ? Container(
                  // wrapping this container with column to crate a dots indicator and showing the loading progress
                  height: Dimensions.pageView,
            child: PageView.builder(
                        controller: pageController,
                        itemCount: popularProducts.popularProductList.length,
                        // getting the count from server
                        itemBuilder: (context, position) //
                            {
                          return _buildPageItem(position, popularProducts.popularProductList[position]); // function to return slider view
                        }),

                ): CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        // Dots Section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius20)),
            ),
          );
        }),

        //Popular text
        SizedBox(height: Dimensions.height24),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black38),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food Pricing",
                ),
              )
            ],
          ),
        ),


       //Recommended food

        // list of food and images
        GetBuilder<RecommendedProductController>(builder: (recommendProduct) {
          return recommendProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendProduct.recommendedProductList.length,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.heigth10),
                        child: Row(
                          children: [
                            //Image Section
                            Container(
                              margin: EdgeInsets.only(top: Dimensions.heigth10),
                              width: Dimensions.listViewImgSize,
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.radius20),
                                  color: Colors.white30,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendProduct.recommendedProductList[index].img),
                                  )),
                            ),

                            SizedBox(width: Dimensions.width10),
                            // Text Container
                            Expanded(
                              // Wrapped into Expanded so that it can take all the space
                              child: Container(
                                height: Dimensions.listViewTextContSize + 1.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: recommendProduct.recommendedProductList[index].name!),
                                      SizedBox(height: Dimensions.heigth10),
                                      SmallText(
                                          text: recommendProduct.recommendedProductList[index].name),
                                      SizedBox(height: Dimensions.heigth10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              iconColor: AppColors.iconColor1,
                                              text: "Normal"),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              iconColor: AppColors.mainColor,
                                              text: "1.7Km"),
                                          IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              iconColor: AppColors.iconColor2,
                                              text: "32min"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity(); //returns an instance. It has three coordinates x,y,z
    if (index == _currentPageValue.floor()) {
      // we need to use the accurate value as 0 or 1 thats why we use floor function
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, height * (1 - _scaleFactor), 0);
    }

    return Transform(           // Wrapping stack with a transform widget to view the slider changes
      transform: matrix,
      child: Stack(
        // child container takes all space of parent container so, i use stack
        children: [
          GestureDetector(
            onTap: (){
              //Get.to(()=>PopularFoodDetail());
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
            },
            child: Container(
              // container that holds page view   (parent container)
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                    fit: BoxFit.cover, // to fit the image in the page view
                    image: NetworkImage(
                      AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!,
                    ),
                  )),
            ),
          ),
          Align(
            //  since child container setup at top to align it along parent container we wrap it with a widget called align
            alignment: Alignment.bottomCenter,
            child: Container(
              // container that holds page view   (child container that overlaps)
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5), //here 0 denoted +x axis and 5 denotes +yaxis
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: AppColumn(
                    text: popularProduct.name!), // loading the names of the items from the server
              ),
            ),
          ),
        ],
      ),
    );
  }
}
