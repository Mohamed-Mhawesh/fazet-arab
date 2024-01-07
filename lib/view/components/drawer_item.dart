import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
  super.key,
  required this.size, required this.iconName, required this.itemText, required this.onTap,
  });

  final Size size;
  final String iconName;
  final String itemText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
        margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
        decoration: BoxDecoration(
            boxShadow: const [  BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(0, 2)),
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(2, 0)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff609CFD)),
              width: size.width * 0.1,
              height: size.height * 0.06,
              child: Center(
                child: SizedBox(
                    width: size.width*0.06,
                    child: Image.asset("assets/icons/$iconName.png")),
              ),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              itemText,
              style: GoogleFonts.cairo(fontSize: 16.sp),
            )
          ],
        ),
      ),
    );
  }
}