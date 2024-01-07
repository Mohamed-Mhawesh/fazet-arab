import 'package:f_a/controllers/quiz_contoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constant/routes.dart';
import 'components/answer.dart';


class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key}) : super(key: key);

  final ScrollController _controllerOne = ScrollController();

  @override
  Widget build(BuildContext context) {
    QuizController controller = Get.put(QuizController());
    Size size = MediaQuery.of(context).size;
    return GetBuilder<QuizController>(builder: (controller) {
      if (controller.isLoading) {
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
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.4,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xff609CFD),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(45),
                              bottomLeft: Radius.circular(45))),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
                            child: LinearPercentIndicator(barRadius: const Radius.circular(20) ,

                              animation: true,
                              animationDuration: controller.indexOfQuestion>5?15000:20000,
                              onAnimationEnd: controller.indexOfQuestion!=9?controller.skipQuestion:controller.sendResultData,
                              lineHeight: 10.h,
                              percent: 1,
                              backgroundColor: const Color(0xff609CFD),
                              progressColor: const Color(0xffFEC901)
                              ,),
                          ),
                          Center(
                            child: Container(
                              height: size.height * 0.32,
                              width: size.width * 0.90,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xff90BAFE)),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 44.h,
                                      width: 44.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 3,
                                              color: const Color(0xffFEC901))),
                                      child: Center(
                                        child: Text(
                                          '''${controller.indexOfQuestion+1}/10''',
                                          style: GoogleFonts.cairo(
                                              fontSize: 14.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 12.h),
                                    child: Text(
                                      controller.questionsList[controller.indexOfQuestion].title,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.cairo(
                                          fontSize: 20.sp, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Scrollbar(
                          controller: _controllerOne,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              SizedBox(
                                height: size.height * 0.6,
                                child: ListView.builder(
                                    itemCount: controller
                                        .questionsList[controller.indexOfQuestion]
                                        .answers
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Answer(
                                        size: size,
                                        text: controller
                                            .questionsList[
                                                controller.indexOfQuestion]
                                            .answers[index]
                                            .title,
                                        isCorrect: controller
                                            .questionsList[
                                                controller.indexOfQuestion]
                                            .answers[index]
                                            .isCorrect,
                                        index: index,
                                        onTap: !controller.isAnswered? (){

                                          controller.check(index, controller
                                            .questionsList[
                                        controller.indexOfQuestion]
                                            .answers[index]
                                            .isCorrect);}:(){},
                                      );
                                    }),
                              ),

                            ],
                          ),
                        ),
                      ),
                    )
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


