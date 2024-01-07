
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


import '../controllers/watch_ad_controller.dart';

class WatchAdScreen extends StatelessWidget {
  const WatchAdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WatchAdController controller = Get.put(WatchAdController());
    Size size = MediaQuery.of(context).size;
    return GetBuilder<WatchAdController>(builder: (controller) {
      if (controller.isLoading) {
        return Scaffold(
          body: Center(
            child: SizedBox(
                width: size.width * 0.5,
                child: Lottie.asset("assets/images/loading.json")),
          )
        );
      } else {
        return SafeArea(
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
                      child:

                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: controller.advertisement.path == "null"
                            ? Center(
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
                            child: FloatingActionButton(onPressed:controller.completeWatchingAd ,
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

                            )

                            // InkWell(
                            //   onTap: () {
                            //     controller.completeWatchingAd();
                            //   },
                            //   child:
                            // )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }


}
