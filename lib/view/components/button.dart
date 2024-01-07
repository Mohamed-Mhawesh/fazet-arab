import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../quiz_screen.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.size,
    required this.onTap,
    required this.text,
    required this.bottomMargin,
  }) : super(key: key);

  final Size size;
  final Function() onTap;
  final String text;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.60,
        margin: EdgeInsets.only(bottom: bottomMargin ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff609CFD),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff000000).withOpacity(0.3),
                offset: const Offset(0, 2),
                blurRadius: 4)
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.cairo(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
