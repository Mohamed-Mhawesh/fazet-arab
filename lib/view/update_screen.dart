import 'package:f_a/controllers/splash_controller.dart';
import 'package:f_a/view/components/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(builder: (controller) {
      return SafeArea(
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.all(10.w),
              height: size.height,
              width: double.infinity,
              color: const Color(0xfff6f6f6), 
              child: Column(
                children: [
                  Container(
                  //  padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
                    width: double.infinity,
                    height: size.height*0.6,
                    child: Image.asset(
                      "assets/icons/fazetarab.png",
                    ),
                  ),
                  Center(
                    child: Text("يتوفر تحديث جديد للتطبيق",style: GoogleFonts
                          .cairo(fontSize: 20.sp,fontWeight: FontWeight.bold,color:Color(0xff609cfd) ),),
                  ),
                  Center(
                    child: Text(
                        "أصبحت هذه النسخة من التطبيق قديمة يرجى تحميل أحدث نسخة",style: GoogleFonts
                        .cairo(fontSize: 18.sp,),textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 20.h,),
                  BlueButton(size: size, onTap: (){   controller.launchInBrowser(
                      Uri.parse(controller.link));},  text: "تحديث", withIcon:
                  false)
                ],
              ),
            ),
          ));
    });
  }
}
