import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BlueButton extends StatelessWidget {
   const BlueButton({
    Key? key,
    required this.size, required this.onTap, required this.text, required this.withIcon,

  }) : super(key: key);
final void Function()? onTap;
final String text;
final bool withIcon;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
          decoration: BoxDecoration(
              color:const Color(0xff609cfd),
              borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:const Color(0xff000000).withOpacity(0.4),
              offset:const Offset(0,2),
              blurRadius: 4

            )
          ]
          ),

          width: size.width * 0.771,
          height: 56.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,

                style:  GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: size.width * 0.056,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: size.width*0.01,),
            withIcon?
            Icon(Icons.arrow_back_ios_new,color: Colors.white,size:  size
                .height * 0.04,)
                :const Text("")
            ],
          )),
    );
  }
}
