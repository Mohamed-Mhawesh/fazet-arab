
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/routes.dart';
import '../services/app_services.dart';
import '../services/login_services.dart';

class ResetPasswordController extends GetxController {
  String checkPhoneMessage = "";
  bool isLoading =false;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  AppServices appServices = Get.find();
  bool passwordShow = true;
  bool confirmPasswordShow = true;
  String userId = "";
  String userToken = "";
  showHidePassword() {
    passwordShow = !passwordShow;
    update();
  }
  showHideConfirmPassword() {
    confirmPasswordShow = !confirmPasswordShow;
    update();
  }
  getUserDetails() async {
    userId = await (appServices.sharedPreferences.getString("userId"))!;
    userToken = await (appServices.sharedPreferences.getString("token"))!;


    print("user id= $userId");

  }
  goToLogin() {
    var formData = formState.currentState;
    if (formData!.validate()) {
      resetPassword();
      Get.offAllNamed(AppRoute.loginScreen);
      update();
    } else {
      printError();
      update();
    }
  }

  resetPassword() async {
    isLoading= true;
    update();
    try {
      var data = await LoginService.resetPassword(
        appServices.sharedPreferences.getString("phone"),
        passwordController.text,
        userToken
      );
      if (data != null) {
        if (data["message"] == "success") {
          Get.offAllNamed(AppRoute.loginScreen);
        }
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } catch (e) {
      printError(info: 'error : $e', logFunction: () {});
    }finally{
      isLoading=false;
      update();
    }
  }

  @override
  void onInit() async{
    await getUserDetails();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
