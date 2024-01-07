import 'package:f_a/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/quiz_contoller.dart';

class AdvertisementScreen extends StatelessWidget {
  const AdvertisementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizController controller = Get.find();
    Size size = MediaQuery.of(context).size;
    return GetBuilder<QuizController>(builder: (controller) {
      if (controller.isAdLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return WillPopScope(
          onWillPop: ()async{
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(20)),
                    content: SizedBox(
                      height: size.height * 0.5,
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Container(
                                height: size.height * 0.12,
                                width: size.width * 0.26,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff609CFD),
                                ),
                                child: Center(
                                  child: SizedBox(
                                      height: size.height * 0.1,
                                      width: size.width * 0.5,
                                      child: Image.asset(
                                          "assets/icons/transfer.png")),
                                ),
                              ),
                              Text(
                                "هل أنت متأكد من أنك تريد المغادرة؟",textAlign: TextAlign.center,style: GoogleFonts.cairo(fontSize: 18.sp,
                                  color: const Color(0xff3A3B6B),
                                  fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: size.height*0.01),
                            ],
                          ),
                          Text(
                            "في حال مغادرتك ستخسر محاولة من محاولاتك وكامل النقاط التي حصلت عليها في هذه المحاولة",textAlign: TextAlign.center,style: GoogleFonts.cairo(height: 1.2.h,fontSize: 14.sp,
                            color: const Color(0xff606268),
                          ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: size.height*0.01),
                              InkWell(
                                onTap: () {Get.back();},
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.60,
                                  margin: EdgeInsets.only(
                                      bottom: 4.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff609CFD),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0xff000000).withOpacity(0.3),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4)
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "البقاء",
                                      style: GoogleFonts.cairo(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height*0.01),
                              InkWell(
                                onTap: () {
                                  controller.videoController.dispose();

                                  Get.offAllNamed(AppRoute.homeScreen);
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.60,
                                  margin: EdgeInsets.only(
                                      bottom: 4.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.h,
                                        color:
                                        const Color(0xff609CFD)),
                                    borderRadius:
                                    BorderRadius.circular(
                                        20),
                                    // color: Color(0xff609CFD),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: const Color(0xff000000).withOpacity(0.3),
                                    //       offset: const Offset(0, 2),
                                    //       blurRadius: 4)
                                    // ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "مغادرة",
                                      style: GoogleFonts.cairo(
                                          fontSize: 16.sp,
                                          color: Colors.blue,
                                          fontWeight:
                                          FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  );
                });
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              body: Container(
                height: size.height,
                width: double.infinity,
                color: const Color(0xfff6f6f6),
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.4,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xff609CFD),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(45),
                              bottomLeft: Radius.circular(45))),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                             horizontal: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color:
                                const Color(0xff000000).withOpacity(0.3),
                                offset: const Offset(0, 2),
                                blurRadius: 4)
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: controller
                              .advertisementsList[
                          controller.indexOfAd]
                              .path ==
                              "null"
                              ?Center(
                            child: SizedBox(
                                width: size.width * 0.5,
                                child: Lottie.asset("assets/images/loading.json")),
                          )

                              : controller.buildIAd(size),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.05,
                      margin: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                              visible: controller.canSkipAd,
                              child: FloatingActionButton(onPressed:controller.goToNextQuestion ,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                backgroundColor: const Color(0xffFEC901),child: Center(
                                child: Text(
                                  "تم",
                                  style: GoogleFonts.cairo(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              )),
                          LinearPercentIndicator(

                            barRadius: const Radius.circular(20),
                            padding: EdgeInsets.zero,
                            animation: true,
                            animationDuration: 10000,
                            onAnimationEnd: () {
                              controller.watchAd();
                            },
                            lineHeight: 10.h,
                            width: size.width * 0.7,
                            percent: 1,
                            backgroundColor: const Color(0xff609CFD),
                            progressColor: const Color(0xffFEC901),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
