import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/on_boarding_controller.dart';


import 'components/on_boarding/button.dart';

import 'components/on_boarding/dots_controller.dart';
import 'components/on_boarding/on_boarding_slider.dart';
import 'components/on_boarding/skip_and_back.dart';
class OnBoardingScreen extends StatelessWidget {

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child:  Container(
            color: const Color(0xffF6F6F6),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: SkipAndBack(size: size),
                ),
                Expanded(
                  flex: 9,
                  child: OnBoardingSlider(size: size),
                ),
                OnBoardingDotsController(size: size),
                OnBoardingButton(size: size),
              ],
            ),
          ),

      ),
    );
  }
}

