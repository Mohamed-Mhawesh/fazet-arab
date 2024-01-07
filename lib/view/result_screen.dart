import 'package:f_a/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/quiz_contoller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizController controller = Get.find();
    Size size = MediaQuery.of(context).size;
    if(controller.userPoints>799){return WillPopScope(
      onWillPop: ()async{
        Get.offAllNamed(AppRoute.homeScreen);
        return false;
      },
      child: SafeArea(
          child: Scaffold(
            body: Container(
              height: size.height,
              width: double.infinity,
              color: const Color(0xfff6f6f6),
              child: controller.points>7?Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: size.height*0.1),
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/finish.png",

                      ),
                    ),
                    Center(child: Text("لقد حصلت على ${controller.points} نقاط",textAlign: TextAlign.center,  style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                        color: const Color(0xff3A3B6B)),),),
                    Center(child: Text("لقد أجبت على ${controller.points} من الأسئلة بشكل صحيح ",textAlign: TextAlign.center,  style: GoogleFonts.cairo(

                        fontSize: 16.sp,
                        color: const Color(0xff3A3B6B)),),)

                  ],
                ),
              ):Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(

                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: size.height*0.1),
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/finish1.png",

                      ),
                    ),
                    Center(child: Text("للأسف لم تحصل على أي نقطة",textAlign: TextAlign.center,  style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                        color: const Color(0xff3A3B6B)),),),
                    Center(child: Text("يجب أن تجيب على 8 أسئلة بشكل صحيح من أجل احتساب النقاط",textAlign: TextAlign.center,  style: GoogleFonts.cairo(

                        fontSize: 16.sp,
                        color: const Color(0xff3A3B6B))))

                  ],
                ),
              ),
            ),
          )),
    );}
   else {return WillPopScope(
      onWillPop: ()async{
     Get.offAllNamed(AppRoute.homeScreen);
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          height: size.height,
          width: double.infinity,
          color: const Color(0xfff6f6f6),
          child: controller.points>5?Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: size.height*0.1),
width: double.infinity,
                  child: Image.asset(
                    "assets/images/finish.png",

                  ),
                ),
                Center(child: Text("لقد حصلت على ${controller.points} نقاط",textAlign: TextAlign.center,  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: const Color(0xff3A3B6B)),),),
                Center(child: Text("لقد أجبت على ${controller.points} من الأسئلة بشكل صحيح ",textAlign: TextAlign.center,  style: GoogleFonts.cairo(

                    fontSize: 16.sp,
                    color: const Color(0xff3A3B6B)),),)

              ],
            ),
          ):Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(

              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: size.height*0.1),
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/finish1.png",

                  ),
                ),
                Center(child: Text("للأسف لم تحصل على أي نقطة",textAlign: TextAlign.center,  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: const Color(0xff3A3B6B)),),),
                Center(child: Text("يجب أن تجيب على أكثر من 5 أسئلة بشكل صحيح من أجل احتساب النقاط",textAlign: TextAlign.center,  style: GoogleFonts.cairo(

                    fontSize: 16.sp,
                    color: const Color(0xff3A3B6B))))

              ],
            ),
          ),
        ),
      )),
    );}
  }
}
