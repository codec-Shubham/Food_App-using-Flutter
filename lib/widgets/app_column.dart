import 'package:flutter/material.dart';
import 'package:food_app3/widgets/small_text.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
   final String text;             // to make text Dynamic

  const AppColumn({Key? key, required this.text}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26),
        SizedBox(height: Dimensions.heigth10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap( // to display something horizontally again and again
                children: List.generate(5, (index) =>
                    Icon(Icons.star, color: AppColors.mainColor,
                      size: 15,)) // using this we generate children dynamically
            ),

            SmallText(text: "4.5"),

            SmallText(text: "1287"),

            SmallText(text: "Comments"),
          ],
        ),
        SizedBox(height: Dimensions.heigth20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp,
                iconColor: AppColors.iconColor1, text: "Normal"),

            IconAndTextWidget(icon: Icons.location_on,
                iconColor: AppColors.mainColor, text: "1.7Km"),

            IconAndTextWidget(icon: Icons.access_time_rounded,
                iconColor: AppColors.iconColor2, text: "32min"),
          ],
        ),
      ],
    );
  }
}
