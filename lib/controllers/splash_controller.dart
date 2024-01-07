import 'package:f_a/constant/routes.dart';
import 'package:f_a/services/app_services.dart';
import 'package:f_a/services/check_update_services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashController extends GetxController {
 String? version;
 String userId = "";
 String userToken = "";
 String link="";
 AppServices appServices= Get.find();
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
 checkUpdate() async {
   // isLoading = true;
   update();
   // if (userOtp == correctOtp) {
   try {
     var checkUpdateData = await CheckUpdateServices.checkUpdate();

     if (checkUpdateData != null) {
       version = checkUpdateData["version"];
       link = checkUpdateData["link"];
       print(version);
       if (packageInfo.version==version){
         appServices.sharedPreferences.setString("isUpToDate", "true");
         print("+++++++++++++++ true +++++++++++++++");
       }else
       { appServices.sharedPreferences.setString("isUpToDate", "false");
       print("--------------false----------------");}
       update();
     } else {
       printError(info: 'error in data', logFunction: () {});
     }
   } finally {


     Future.delayed(const Duration(seconds: 4), () {
       Get.offNamed(AppRoute.onBoardingScreen);

     });
     update();
   }
 }
 // getUserDetails() async {
 //   userId = await (appServices.sharedPreferences.getString("userId"))!;
 //   userToken = await (appServices.sharedPreferences.getString("token"))!;
 //
 //   print("user id= $userId");
 // }
  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

      packageInfo = info;
      printInfo(
        info: "$packageInfo",printFunction: (){}
      );

update();
  }


checkIsUpToDate(){
    if (packageInfo.version==version){
      appServices.sharedPreferences.setString("isUpToDate", "true");
      print("+++++++++++++++ true +++++++++++++++");
    }else
      { appServices.sharedPreferences.setString("isUpToDate", "false");
      print("--------------false----------------");}
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
  void onReady() {


    super.onReady();
  }

  @override
  void onInit()  async{
    // await getUserDetails();
    checkUpdate();
    initPackageInfo();

    super.onInit();
  }
}
