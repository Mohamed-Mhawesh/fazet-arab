import 'package:f_a/constant/routes.dart';
import 'package:f_a/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/on_boarding_model.dart';
import '../services/home_services.dart';

class OnBoardingController extends GetxController {
  List<onBoardingScreenModel> onBoardingScreens = [
    onBoardingScreenModel(
        img: "assets/images/on_boarding1.png",
        title: 'اختبر معلوماتك العامة',
        subTitle:
            "يمكنك من خلال تطبيق فزعة عرب اختبار معلوماتك العامة وخوض تجربة مليئة بالمتعة والفائدة"),
    onBoardingScreenModel(
        img: "assets/images/on_boarding2.png",
        title: 'كُن من الرابحين',
        subTitle:
            "اجمع نقاطك واستبدلها بجوائز رائعة مُقدمة من تطبيق فزعة عرب"),
    // onBoardingScreenModel(
    //     img: "assets/images/on_boarding3.png",
    //     title: 'نافس أصدقائك',
    //     subTitle: "عِش شعور المنافسة وأجوائها مع أصدقائك وكُن من المتميزين"),
  ];
  PageController? pageController;
  int currentIndex = 0;
  String privacyPolicyUrl="";
AppServices appServices =Get.find();
  void changeIndex(index) {
    currentIndex = index;
    update();
  }

  void back() {
    pageController!.animateToPage(currentIndex - 1,
        duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }

  void next() {
    if (currentIndex == onBoardingScreens.length - 1) {
getPrivacyPolicyUrl();

     // Get.offAllNamed(AppRoute.welcomeScreen);
Get.toNamed(AppRoute.privacyPolicyScreen);}
    pageController!.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }
  onAcceptPress(){
    appServices.sharedPreferences.setString("isNotFirstTime", "true");
    Get.offAllNamed(AppRoute.welcomeScreen);
  }

  void skip() {
    getPrivacyPolicyUrl();
   // appServices.sharedPreferences.setString("isNotFirstTime", "true");
   // Get.offAllNamed(AppRoute.welcomeScreen);
    Get.toNamed(AppRoute.privacyPolicyScreen);
  }
  getPrivacyPolicyUrl()async{
    try{

      privacyPolicyUrl=await HomeServices.privacyPolicyRequest();
      update();
    }finally{}
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pageController!.dispose();
    super.onClose();
  }
}
