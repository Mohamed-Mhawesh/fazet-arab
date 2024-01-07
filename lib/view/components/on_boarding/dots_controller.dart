import 'package:f_a/controllers/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingDotsController extends StatelessWidget {
  const OnBoardingDotsController({
  super.key,
  required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
        init: OnBoardingController(),
        builder: (controller) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              controller.onBoardingScreens.length, ((index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: controller.currentIndex == index
                    ? const Color(0xff609CFD)
                    : const Color(0xff609CFD).withOpacity(0.4),
              ),
              width: controller.currentIndex == index
                  ? size.width * 0.056
                  : size.width * 0.018,
              height: size.height * 0.009,
              margin: EdgeInsets.only(right: size.width * 0.018),
            );
          })),
        ));
  }
}

