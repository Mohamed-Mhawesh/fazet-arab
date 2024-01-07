import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.size,required this.onpress, required this.text,
  }) : super(key: key);
final onpress;
final String text;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:size.width*0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(icon:const Icon(Icons.arrow_back,size: 40,),
                onPressed:onpress,),
              Container(
                padding:  EdgeInsets.only(top: size.height*0.02),
                width: size.width*0.7,
                child: Image.asset("assets/images/login.png"),
              ),

              // Image.asset("assets/images/arrow-back.png"),

            ],
          ),
          Container(
            padding: EdgeInsets.only(right:size.width*0.06,top: size
                .height*0.03,bottom: size.height*0.01),
            child: Text(text,style: GoogleFonts.cairo(fontSize: size
                .width*0.055,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}
