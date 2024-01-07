import 'package:f_a/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 3,
            width: 100.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color(0xff609CFD),
                const Color(0xffC4C4C4).withOpacity(0)
              ]),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoute.createAccountScreen);
            },
            child: Text('إنشاء حساب',
                style: GoogleFonts.cairo(
                    color: const Color(0xff3A3B6B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
          Container(
            height: 3,
            width: 100.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xffC4C4C4).withOpacity(0),
                  const Color(0xff609CFD)
                ])),
          ),
        ],
      ),
    );
  }
}
