import 'package:f_a/constant/routes.dart';
import 'package:f_a/services/app_services.dart';
import 'package:f_a/services/update_profile_services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  bool passwordShow = true;
  String chosenPCountry = "البلد";
  String withGoogle = "0";
  bool isChoseCountry = true;// for validate chosenPCountry
  bool isLoading=false;
  String userId = "";
  String userToken = "";
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  AutovalidateMode? autoValidateMode = AutovalidateMode.onUserInteraction;
  late TextEditingController firstNameController;
  late TextEditingController userNameController;
  late TextEditingController lastNameController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  AppServices appServices = Get.find();

  showHidePassword() {
    passwordShow = !passwordShow;
    update();
  }

  getCurrentUserInfo() {
    firstNameController.text =
        appServices.sharedPreferences.getString("firstName").toString();

    lastNameController.text =
        appServices.sharedPreferences.getString("lastName").toString();

    passwordController.text =
        appServices.sharedPreferences.getString("password").toString();

    chosenPCountry =
        appServices.sharedPreferences.getString("country").toString();

    withGoogle =
        appServices.sharedPreferences.getString("withGoogle").toString();

    update();
  }
  getUserDetails() async {
    userId = await (appServices.sharedPreferences.getString("userId"))!;
    userToken = await (appServices.sharedPreferences.getString("token"))!;

    print("user id= $userId");
  }
  afterEditData() {
    var formData = formState.currentState;
    if (formData!.validate()) {
      if (chosenPCountry == "البلد") {
        isChoseCountry = false;
        update();
      } else {
        updateProfile();
        update();
      }
    }
  }

  updateProfile() async {
     isLoading = true;
    update();
    // if (userOtp == correctOtp) {
    try {
      var data = await UpdateProfileService.updateProfile(
        appServices.sharedPreferences.getString("userId"),
        passwordController.text,
        firstNameController.text,
        lastNameController.text,
        chosenPCountry,
        userToken
      );

      if (data["message"] == "success") {
        await appServices.sharedPreferences
            .setString("firstName", firstNameController.text);
        await appServices.sharedPreferences
            .setString("lastName", lastNameController.text);
        await appServices.sharedPreferences
            .setString("country", chosenPCountry);
        await appServices.sharedPreferences
            .setString("password", passwordController.text);

        Get.offAllNamed(AppRoute.homeScreen);
        update();
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } finally {
      isLoading=false;
      update();
    }
  }

  @override
  void onInit() async{
    super.onInit();
    await getUserDetails();
    passwordController = TextEditingController();
    userNameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    getCurrentUserInfo();


  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    userNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();


  }
}
