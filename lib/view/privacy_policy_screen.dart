import 'package:f_a/controllers/on_boarding_controller.dart';
import 'package:f_a/view/components/blue_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<OnBoardingController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(10),
            height: size.height,
            width: double.infinity,
            color: const Color(0xfff6f6f6),
            child: Column(

              children: [
                Image.asset(
                  "assets/icons/fazetarab.png",
                ),
                SizedBox(height: 40.h,),
                 Center(
                  child: Text(
                    "عند المتابعة فانت توافق على : ",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
                Center(
                  child: InkWell(
                      onTap: () {
                        controller.launchInBrowser(
                            Uri.parse(controller.privacyPolicyUrl));
                      },
                      child:  Text(
                        "سياسة الخصوصية وشروط الاستخدام",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.sp,
                        ),
                      )),
                ),
                SizedBox(height: 40.h,),
                BlueButton(
                    size: size,
                    onTap: () {
                      controller.onAcceptPress();
                    },
                    text: "قبول",
                    withIcon: false)
              ],
            ),
          ),
        ),
      );
    });
  }
}
