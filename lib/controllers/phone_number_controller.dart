
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constant/routes.dart';
import '../services/app_services.dart';
import '../services/create_account_service.dart';
class PhoneNumberController extends GetxController{
  bool isLoading=false;
  bool isEnterData=false;
String checkPhoneMessage="";
  EmailOTP myAuth = EmailOTP();
  late TextEditingController verifyCodeController;
  late TextEditingController emailController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  GlobalKey<FormState> verifyCodeFormState = GlobalKey<FormState>();
AppServices appServices = Get.find();
//final Random random=Random();
goToVerifyCode()async{
  isLoading=true;
  update();
  var formData = formState.currentState;
  if (formData!.validate()) {
    await sendEmail();
    // int verifyCode=100000+ random.nextInt(900000);
    // appServices.sharedPreferences.setString("verifyCode", "$verifyCode");

    appServices.sharedPreferences.setString("phone", emailController.text);
    isEnterData=true;
    update();
  } else {
// autoValidateMode = AutovalidateMode.onUserInteraction;
    printError();
    update();
  }
  isLoading=false;
  update();
}
  sendEmail()async{
    myAuth.setConfig(
        appEmail: "me@rohitchouhan.com",
        appName: "Fazet Arab",
        userEmail: emailController.text,
        otpLength: 6,
        otpType: OTPType.digitsOnly
    );
    if (await myAuth.sendOTP() == true) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(
      //   content: Text("OTP has been sent"),
      // ));
    } else {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(
      //   content: Text("Oops, OTP send failed"),
      // ));
    }
  }

  goToResetPassword(){
    var formData = verifyCodeFormState.currentState;
    if (formData!.validate()) {
      Get.offNamed(AppRoute.resetPasswordScreen);
      update();
    } else {
// autoValidateMode = AutovalidateMode.onUserInteraction;
      printError();
      update();
    }
  }

  checkPhone() async {
    // isLoading = true;
    update();
    // if (userOtp == correctOtp) {
    try {
      var checkPhoneData = await CreateAccountService.checkPhone(
        emailController.text,
      );

      if (checkPhoneData != null) {
        checkPhoneMessage = checkPhoneData["message"];

        update();
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } finally {}
  }


  @override
  void onInit() {
    emailController= TextEditingController();
    verifyCodeController= TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    emailController.dispose();
    verifyCodeController.dispose();
    super.dispose();
  }
}