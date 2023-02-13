import 'package:flutter/cupertino.dart';
import 'package:food_app3/utils/dimensions.dart';

class BigText extends StatelessWidget {
    Color? color;
   final String text;
     double size;
  late TextOverflow overFlow;
  BigText({Key? Key, this.color = const Color(0xFF332d2b),required this.text,this.size=0,
    this.overFlow = TextOverflow.ellipsis}) :super(key: Key);  //constructor to provide values to parameter

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,  // is there are more than one line the we see an elipsis
      overflow: overFlow,
      style: TextStyle(  // to specify color we use style property
        color: color,
        fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
       // fontStyle: FontStyle.italic,
        fontSize: size == 0 ? Dimensions.font20:size,

      ),

    );
  }
}
