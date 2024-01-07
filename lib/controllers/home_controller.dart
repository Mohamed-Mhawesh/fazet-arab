import 'dart:math';

import 'package:f_a/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:launch_review/launch_review.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/routes.dart';
import '../models/advertisement_model.dart';
import '../services/app_services.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  bool transferLoading = false;
  int currentCarouselIndex = 0;
  String userId = "";
  String userName = "";
  String userToken = "";
  int attempts = 0;
  int points = 0;
  int watchAdAttempts = 0;
  String inviteMessage = "";
  AppServices appServices = Get.find();
  List<Advertisement> advertisementList = [];
  String contactUsText = "";
  String privacyPolicyUrl = "";
  String userPhoneNumber = "";
  bool isRatedApp = false;

  changeCurrentCarousalIndex(index) {
    currentCarouselIndex = index;
    update();
  }

  getUserDetails() async {
    //get user info from sharedPreferences
    userId = await (appServices.sharedPreferences.getString("userId"))!;
    userName = await (appServices.sharedPreferences.getString("userName"))!;
    userToken = await (appServices.sharedPreferences.getString("token"))!;

    print("user id= $userId");
    print("username= $userName");
  }

  getHomeDetails() async {
    await getUserDetails();

    try {
      isLoading = true;
      update();

      //get Home Screen details(carousal slider advertisements,attempts,points,watch Ads attempts)
      var homeData = await HomeServices.mainRequest(userId, userToken);
      for (Map<String, dynamic> i in homeData[0]) {
        // print(i);

        advertisementList.add(Advertisement.fromJson(i));
      }
      attempts = homeData[1];
      points = homeData[2];
      appServices.sharedPreferences.setString("points", "$points");
      watchAdAttempts = homeData[3];

      // show Rate App Dialog
      if (DateTime.now().weekday == Random().nextInt(7)) {
        Get.defaultDialog(
            title: "قيّم فزعة عرب",
            titleStyle: GoogleFonts.cairo(fontSize: 16.sp),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                        width: 150.w,
                        child: Lottie.asset("assets/images/rate.json")),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Center(
                      child: Text(
                    "يُسعدنا أن تُقدّم تقييمك لتجربتك في التطبيق",
                    style: GoogleFonts.cairo(fontSize: 14.sp),
                  )),
                  SizedBox(
                    height: 8.h,
                  ),
                  InkWell(
                    onTap: () {
                      LaunchReview.launch(
                          androidAppId: "com.fazetarab.fazet_arab");
                    },
                    child: Container(
                      height: 48.h,
                      width: 96.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff609CFD),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.3),
                              offset: const Offset(0, 2),
                              blurRadius: 4)
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "تقييم",
                          style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
      }
    } catch (e) {
      print("home error : $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  bool canTransferPoints() {
    // check if user can transfer his points with a gift
    if (points >= 1000 && !transferLoading) {
      return true;
    } else {
      return false;
    }
  }

  transferPoints() async {
    try {
      transferLoading = true;
      update();
      var response = await HomeServices.transferRequest(
          userId, (points ~/ 1000) * 1000, userToken, userPhoneNumber);
      print("transfer message=  ${response["message"]}");
      if (response["message"] == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    } finally {
      transferLoading = false;
      update();
    }
  }

  getInviteMessage() async {
    //get a text that includes invite message and share it by another app like whatsapp,messenger,...
    try {
      inviteMessage = await HomeServices.inviteFriendRequest(userToken, userId);
      if (inviteMessage != "") {
        Share.share(inviteMessage);
      }
    } catch (e) {
      print(e);
    } finally {}
  }

  getContactUsText() async {
    //get a text that includes info to contact with app admins
    try {
      contactUsText = await HomeServices.contactUsRequest(userToken);
      update();
    } catch (e) {
      print(e);
    } finally {}
  }

  getPrivacyPolicyUrl() async {
    // get privacy policy url
    try {
      privacyPolicyUrl = await HomeServices.privacyPolicyRequest();
      update();
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  logout() async {

    //logout from app and empty user info from sharedPreferences
    GoogleSignIn googleSignIn = GoogleSignIn();

    if (await googleSignIn.isSignedIn()) {
      googleSignIn.disconnect();
    }
    await appServices.sharedPreferences.setString("token", "");
    await appServices.sharedPreferences.setString("userId", "");
    await appServices.sharedPreferences.setString("firstName", "");
    await appServices.sharedPreferences.setString("lastName", "");
    await appServices.sharedPreferences.setString("userName", "");
    await appServices.sharedPreferences.setString("phone", "");
    await appServices.sharedPreferences.setString("points", "");
    await appServices.sharedPreferences.setString("country", "");
    await appServices.sharedPreferences.setString("inviteCode", "");
    await appServices.sharedPreferences.setString("isAdmin", "");
    await appServices.sharedPreferences.setString("isActive", "");
    await appServices.sharedPreferences.setString("password", "");
    appServices.sharedPreferences.setString("isLoggedIn", "false");
    Get.offAllNamed(AppRoute.welcomeScreen);
  }

  @override
  void onInit() {
    getHomeDetails();
    super.onInit();
  }
}
