import 'package:f_a/controllers/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingSlider extends GetView<OnBoardingController> {
  const OnBoardingSlider({
  super.key,
  required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (index) =>
          controller.changeIndex(index),
      itemCount: controller.onBoardingScreens.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            // vertical: size.height * 0.05,
              horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: size.height * 0.272,
                width: size.width * 0.696,
                child: Image.asset(controller
                    .onBoardingScreens[index].img),
              ),
              // SizedBox(
              //   height: size.height*0.06,
              // ),
              Text(
                controller.onBoardingScreens[index].title,
                style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.bold),
              ),
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
              Text(
                textAlign: TextAlign.center,
                controller
                    .onBoardingScreens[index].subTitle,
                style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
        );
      },
    );
  }
}
