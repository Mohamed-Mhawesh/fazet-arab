import 'package:f_a/controllers/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class SkipAndBack extends StatelessWidget {
  const SkipAndBack({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
        init: OnBoardingController(),
        builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.currentIndex != 0
                    ? Container(
                        padding: EdgeInsets.only(
                            right: size.width * 0.01,
                            top: size.height * 0.0129),
                        child: IconButton(
                          icon:
                              Icon(Icons.arrow_back, size: size.height * 0.046),
                          onPressed: () {
                            controller.back();
                          },
                        ),
                      )
                    : const Text(''),
                controller.currentIndex != 2
                    ? InkWell(
                        onTap: () {
                          controller.skip();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: size.height * 0.0129,
                              left: size.width * 0.03),
                          child: Text(
                            "تخطي",
                            style:
                                GoogleFonts.cairo(fontSize: size.width * 0.055),
                          ),
                        ),
                      )
                    : const Text(''),
              ],
            ));
  }
}
