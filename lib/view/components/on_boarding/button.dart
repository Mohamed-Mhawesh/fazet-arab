
import 'package:f_a/controllers/on_boarding_controller.dart';
import 'package:f_a/view/components/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({
  super.key,
  required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
        init: OnBoardingController(),
        builder: (controller) =>  Container(
          margin: EdgeInsets.symmetric(
              vertical: size.height * 0.072,
              horizontal: size.width * 0.1),
          child: BlueButton(
            size: size,
            onTap: () {
              controller.next();
            },
            text:
            controller.currentIndex != 2 ? "التالي" : "ابدأ",
            withIcon: true,
          ),
        ));
  }
}

