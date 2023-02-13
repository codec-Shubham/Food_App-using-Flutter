  import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  late TextOverflow overFlow;
  SmallText({Key? Key, this.color = const Color(0xFF332d2b),
    this.height=1.2,
    required this.text,
    this.size=10,
   }) :super(key: Key);  //constructor to provide values to parameter

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(  // to specify color we use style property
        color: color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        //fontStyle: FontStyle.italic,
        fontSize: size,
        height: height,

      ),

    );
  }
}
