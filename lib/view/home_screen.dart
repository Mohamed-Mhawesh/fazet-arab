import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';

import '../constant/routes.dart';
import '../controllers/home_controller.dart';
import 'components/button.dart';
import 'components/drawer_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomeController controller = Get.put(HomeController());

    return GetBuilder<HomeController>(builder: (controller) {
      if (controller.isLoading) {
        return  Scaffold(
            body: Center(
              child: SizedBox(
                  width: size.width*0.5,
                  child: Lottie.asset("assets/images/loading.json")),
            ));
      } else {
        // print(size.height);
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            endDrawer: Drawer(
              width: size.width * 0.7,
              backgroundColor: const Color(0xffF6F6F6),
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    Container(
                      height: size.height*0.2,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                      child: Image.asset("assets/icons/fazetarab.png"),
                    ),
                    DrawerItem(size: size,iconName: "home",itemText:"الصفحة الرئيسية",onTap: (){},),
                    DrawerItem(size: size,iconName: "edit-profile",itemText:"تعديل الحساب",onTap: (){Get.offAllNamed(AppRoute.updateProfileScreen);}),
                    DrawerItem(size: size,iconName: "share",itemText:"مشاركة التطبيق",onTap: (){controller.getInviteMessage();}),
                    DrawerItem(size: size,iconName: "privacy",itemText:"سياسة الخصوصية",onTap: ()async{
                      await controller.getPrivacyPolicyUrl();
                      controller.launchInBrowser(Uri.parse(controller.privacyPolicyUrl));
                    }),
                    DrawerItem(size: size,iconName: "terms",itemText:"الشروط والأحكام",onTap: ()async{
                      await controller.getPrivacyPolicyUrl();
                      controller.launchInBrowser(Uri.parse(controller.privacyPolicyUrl));
                    }),
                    DrawerItem(size: size,iconName: "contact-us",itemText:"تواصل معنا",onTap: ()async{
                     await controller.getContactUsText();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20)),
                              content: SizedBox(
                                height: size.height * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Center(
                                      child: SizedBox(
                                          height: size.height * 0.1,
                                          width: size.width * 0.5,
                                          child: Image.asset(
                                              "assets/icons/fazetarab.png")),
                                    ),
                                    Text(
                                      controller.contactUsText,style: GoogleFonts.cairo(fontSize: 18.sp,
                                        color: const Color(0xff3A3B6B),
                                        fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: size.height*0.01),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
                    DrawerItem(size: size,iconName: "logout",itemText:"تسجيل الخروج",onTap: (){controller.logout();}),

                  ],
                ),
              ),
            ),
            body: Container(
              height: size.height,
              width: double.infinity,
              color: const Color(0xfff6f6f6),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.07,
                    margin: EdgeInsets.only(top: 2.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("مرحبًا 👋",
                                style: GoogleFonts.cairo(
                                    height: 1.2,
                                    fontSize: 16.sp,
                                    color: const Color(0xff609CFD))),
                            Text(
                              controller.userName,
                              style: GoogleFonts.cairo(
                                  height: 1.2,
                                  fontSize: 16.sp,
                                  color: const Color(0xff3A3B6B)),
                            )
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: Container(
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            width: size.width * 0.12,
                            child: Image.asset("assets/icons/menu.png"),
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        GetBuilder<HomeController>(builder: (controller) {
                          return Center(
                            child: SizedBox(
                              height: 190.h,
                              child: CarouselSlider.builder(
                                  itemCount:
                                      controller.advertisementList.isNotEmpty
                                          ? controller.advertisementList.length
                                          : 0,
                                  itemBuilder: (context, index, realIndex) {
                                    final myImage = controller
                                            .advertisementList.isEmpty
                                        ? "https://cdn.kursors.lv/2021/01/nothing-logo.jpg"
                                        : "https://fazetarab.com/${controller
                                            .advertisementList[index].path}";

                                    return buildImage(
                                      size,
                                      myImage,
                                      index,
                                      () {},
                                    );
                                  },
                                  options: CarouselOptions(
                                      autoPlayInterval:
                                          const Duration(seconds: 5),
                                      height: 200.h,
                                      viewportFraction: 0.98,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        controller
                                            .changeCurrentCarousalIndex(index);
                                      },
                                      enlargeCenterPage: true)),
                            ),
                          );
                        }),
                        GetBuilder<HomeController>(builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: controller.advertisementList.map((url) {
                              int index =
                                  controller.advertisementList.indexOf(url);
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color:
                                      controller.currentCarouselIndex == index
                                          ? const Color(0xff609CFD)
                                          : const Color(0xff609CFD).withOpacity(0.4),
                                ),
                                width: controller.currentCarouselIndex == index
                                    ? 20.w
                                    : 6.w,
                                height: 6.h,
                                margin: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 3.w,
                                ),
                              );
                            }).toList(),
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 152.h,
                              width: size.width * 0.46,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xff66CC64),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xff000000)
                                          .withOpacity(0.3),
                                      offset: const Offset(0, 2),
                                      blurRadius: 4)
                                ],
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            const Color(0xffffffff).withOpacity(0.3),
                                      ),
                                      child: Image.asset(
                                          "assets/icons/my_points.png"),
                                    ),
                                    Text("نقاطي",
                                        style: GoogleFonts.cairo(
                                            fontSize: 16.sp,
                                            color: Colors.white)),
                                    Container(
                                      height: 28.h,
                                      width: size.width * 0.24,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffffffff)
                                              .withOpacity(0.3)),
                                      child: Center(
                                          child: Text(
                                              "${controller.points} نقطة",
                                              style: GoogleFonts.cairo(
                                                  fontSize: 14.sp,
                                                  color: Colors.white))),
                                    )
                                  ]),
                            ),
                            Container(
                              height: 152.h,
                              width: size.width * 0.46,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xffFFAC5E),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xff000000)
                                          .withOpacity(0.3),
                                      offset: const Offset(0, 2),
                                      blurRadius: 4)
                                ],
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            const Color(0xffffffff).withOpacity(0.3),
                                      ),
                                      child: Image.asset(
                                          "assets/icons/attempts.png"),
                                    ),
                                    Text(
                                      "المحاولات المتبقية",
                                      style: GoogleFonts.cairo(
                                          fontSize: 16.sp, color: Colors.white),
                                    ),
                                    Container(
                                      height: 28.h,
                                      width: size.width * 0.24,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffffffff)
                                              .withOpacity(0.3)),
                                      child: Center(
                                          child: Text(
                                              "${controller.attempts} محاولة",
                                              style: GoogleFonts.cairo(
                                                  fontSize: 14.sp,
                                                  color: Colors.white))),
                                    )
                                  ]),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        content: GetBuilder<HomeController>(
                                          builder: (controller) {
                                            return SizedBox(
                                              height:controller.points>=1000? size.height * 0.55:size.height * 0.45,
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
                                                      SizedBox(height: size.height*0.01),
                                                      Text(
                                                        "يمكنك استبدال نقاطك عند الوصول إلى 1000 نقطة",textAlign: TextAlign.center,style: GoogleFonts.cairo(height: 1.2.h,fontSize: 14.sp,
                                                        color: const Color(0xff606268),
                                                      ),
                                                      ),

                                                      SizedBox(height: size.height*0.01),
                                                    ],
                                                  ),

                                                  Column(
                                                    children: [
                                                      SizedBox(height: size.height*0.01),
                                                      Visibility
                                                        (
                                                        visible: controller.points>=1000,
                                                        child: Text(
                                                          " سيتم التواصل معك عن طريق تطبيق واتساب،  تأكد من إدخالك لرقم فعّال",textAlign: TextAlign.center,style: GoogleFonts.cairo(height: 1.2.h,fontSize: 12.sp,
                                                          color: const Color(0xff609CFD),
                                                        ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: controller.points>=1000,
                                                        child: Directionality(
                                                          textDirection: TextDirection.ltr,
                                                          child: IntlPhoneField(decoration: InputDecoration(

                                                            border: OutlineInputBorder(
                                                              borderSide: const BorderSide(),
                                                              borderRadius: BorderRadius.circular(20)
                                                            ),
                                                          ),


                                                            initialCountryCode: 'SA',
                                                            showCountryFlag: false,
                                                            style: const TextStyle(),
                                                            onChanged: (phone) {
                                                            controller.userPhoneNumber=phone.completeNumber;
                                                              print(controller.userPhoneNumber);
                                                            },),
                                                        ),
                                                      ),
                                                      SizedBox(height: size.height*0.01),
                                                      Visibility(
                                                          visible: controller.transferLoading,
                                                          child: const CircularProgressIndicator()),
                                                      Visibility(
                                                        visible: controller.canTransferPoints(),
                                                        child: InkWell(
                                                          onTap: () async{
                                                          await controller.transferPoints();
                                                          Get.offAllNamed(AppRoute.homeScreen);

                                                            print("${(controller.points ~/ 1000) *1000}");},
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
                                                                "استبدال",
                                                                style: GoogleFonts.cairo(
                                                                    fontSize: 16.sp,
                                                                    color: Colors.white,
                                                                    fontWeight:
                                                                    FontWeight.w600),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: size.height*0.01),
                                                      InkWell(
                                                        onTap: () {
                                                          Get.back();
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
                                                              "رجوع",
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
                                            );
                                          }
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: size.height * 0.07,
                                width: size.width * 0.46,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xffB48DD3),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xff000000)
                                            .withOpacity(0.3),
                                        offset: const Offset(0, 2),
                                        blurRadius: 4)
                                  ],
                                ),
                                child: Center(
                                    child: Row(
                                  children: [
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Container(
                                      width: size.width * 0.1,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            const Color(0xffffffff).withOpacity(0.3),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                            width: size.width * 0.07,
                                            child: Image.asset(
                                                "assets/icons/replace.png")),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text(
                                      "استبدال نقاطي",
                                      style: GoogleFonts.cairo(
                                          fontSize: 14.sp, color: Colors.white),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                            //  Text("يمكنك استبدال النقاط بعد الحصول على 1000 نقطة",style:GoogleFonts.cairo(fontSize: 12.sp,color: Color(0xff3A3B6B)) ,)
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if(controller.watchAdAttempts>0){
                                      Get.toNamed(AppRoute.watchAdScreen);
                                    }else{showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20)),
                                              content: SizedBox(
                                                height: size.height * 0.4,
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
                                                                    "assets/icons/video.png")),
                                                          ),
                                                        ),
                                                        Text(
                                                          "يمكنك الحصول على نقاط مقابل 5 إعلانات فقط يوميًا",style: GoogleFonts.cairo(fontSize: 18.sp,
                                                            color: const Color(0xff3A3B6B),
                                                            fontWeight: FontWeight.w600),
                                                        ),
                                                        SizedBox(height: size.height*0.01),
                                                        InkWell(
                                                          onTap: () {
                                                            Get.toNamed(AppRoute.watchAdScreen);
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
                                                                "حسنًا",
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
                                          });}},
                                    child: Container(
                                      height: size.height * 0.07,
                                      width: size.width * 0.46,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xff709FBA),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color(0xff000000)
                                                  .withOpacity(0.3),
                                              offset: const Offset(0, 2),
                                              blurRadius: 4)
                                        ],
                                      ),
                                      child: Center(
                                          child: Row(
                                        children: [
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Container(
                                            width: size.width * 0.1,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(0xffffffff)
                                                  .withOpacity(0.3),
                                            ),
                                            child: Center(
                                              child: SizedBox(
                                                  width: size.width * 0.07,
                                                  child: Image.asset(
                                                      "assets/icons/video.png")),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Text(
                                            "مشاهدة إعلان",
                                            style: GoogleFonts.cairo(
                                                fontSize: 14.sp,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                  Text("للحصول على 1 نقطة",
                                      style: GoogleFonts.cairo(
                                          fontSize: 12.sp,
                                          color: const Color(0xff3A3B6B)))
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: (){controller.getInviteMessage();},
                                    child: Container(
                                      height: size.height * 0.07,
                                      width: size.width * 0.46,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xff709FBA),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color(0xff000000)
                                                  .withOpacity(0.3),
                                              offset: const Offset(0, 2),
                                              blurRadius: 4)
                                        ],
                                      ),
                                      child: Center(
                                          child: Row(
                                        children: [
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Container(
                                            width: size.width * 0.1,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(0xffffffff)
                                                  .withOpacity(0.3),
                                            ),
                                            child: Center(
                                              child: SizedBox(
                                                  width: size.width * 0.07,
                                                  child: Image.asset(
                                                      "assets/icons/share.png")),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Text(
                                            "دعوة صديق",
                                            style: GoogleFonts.cairo(
                                                fontSize: 14.sp,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                  Text("للحصول على 2 نقطة",
                                      style: GoogleFonts.cairo(
                                          fontSize: 12.sp,
                                          color: const Color(0xff3A3B6B)))
                                ],
                              ),
                            ]),
                        SizedBox(
                          height: 8.h,
                        ),
                        Center(
                          child: Button(
                            size: size,
                            onTap: () {
                              if(controller.attempts>0){
                              Get.toNamed(AppRoute.quizScreen,
                                  arguments: {"user_id": controller.userId});
                            }else{showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      content: SizedBox(
                                        height: size.height * 0.4,
                                        child: Column(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                SizedBox(
                                                  height: size.height * 0.2,
                                                  width: size.width * 0.5,

                                                  child: Center(
                                                    child: SizedBox(
                                                        height: size.height * 0.2,
                                                        width: size.width * 0.5,
                                                        child: Image.asset(
                                                            "assets/icons/fazetarab.png")),
                                                  ),
                                                ),
                                                Text(
                                                  "لا يمكنك إجراء أكثر من إختبارين يوميًا",style: GoogleFonts.cairo(fontSize: 18.sp,
                                                    color: const Color(0xff3A3B6B),
                                                    fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(height: size.height*0.01),
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
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
                                                        "حسنًا",
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
                                  });}
                              },
                            text: "بدء الإختبار",
                            bottomMargin: 8.h,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ]),
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



Widget buildImage(Size size, String image, int index, void Function()? onTap) {
  return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: const Color(0xff000000).withOpacity(0.3),
              offset: const Offset(0, 2),
              blurRadius: 4)
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.01,
        vertical: size.height * 0.01,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          )));
  //}
}
