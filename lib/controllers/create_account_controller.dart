import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:f_a/constant/routes.dart';
import 'package:f_a/services/app_services.dart';
import 'package:f_a/services/create_account_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CreateAccountController extends GetxController {
  bool passwordShow = true;
  bool isEnterData = false;
  bool isLoading = false;
  bool isReSendEmail = false;
  String chosenPCountry = "البلد";
  bool isChoseCountry = true; // for validate chosenPCountry
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  GlobalKey<FormState> verifyCodeFormState = GlobalKey<FormState>();
  AutovalidateMode? autoValidateMode = AutovalidateMode.onUserInteraction;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController passwordController;
  late TextEditingController invitationCodeController;
  late TextEditingController verifyCodeController;
  String checkUsernameMessage = "";
  String checkPhoneMessage = "";
  AppServices appServices = Get.find();
  EmailOTP myAuth = EmailOTP();
  String displayName = "";
  String email = "";
  bool useGoogleAccount = false;
  Timer? timer;
  Duration duration = const Duration();
  String minutes = "0";
  String seconds = "0";
  int secondsInt = 0;
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  bool reSendEmailShow = false;
  showHidePassword() {
    passwordShow = !passwordShow;
    update();
  }

  doAfterEnterData() async {
    await checkUsername();
    await checkPhone(emailController.text);

    isLoading = true;
    update();
    FormState? formData = formState.currentState;
    if (formData!.validate()) {
      if (chosenPCountry == "البلد") {
        isChoseCountry = false;
        update();
      } else {
        if (useGoogleAccount) {
          await signUp();
          update();
        } else {
          await sendEmail();
          reSendEmailTimer();
          // int verifyCode=100000+ random.nextInt(900000);
          // appServices.sharedPreferences.setString("verifyCode", "$verifyCode");
          isEnterData = true;
          update();
        }
      }

      update();
    }
    isLoading = false;
    update();
  }

  sendEmail() async {
    myAuth.setConfig(
        appEmail: "me@rohitchouhan.com",
        appName: "Fazet Arab",
        userEmail: emailController.text,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
    update();
  }

  createAccount() async {
    var formData = verifyCodeFormState.currentState;
    if (formData!.validate()) {
      await signUp();
      update();
    } else {
      printError();
      update();
    }
  }

  checkUsername() async {
    // isLoading = true;
    update();
    // if (userOtp == correctOtp) {
    try {
      var checkUsernameData = await CreateAccountService.checkUsername(
        userNameController.text,
      );

      if (checkUsernameData != null) {
        checkUsernameMessage = checkUsernameData["message"];

        update();
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } finally {}
  }

  checkPhone(email) async {
    // isLoading = true;
    update();
    // if (userOtp == correctOtp) {
    try {
      var checkPhoneData = await CreateAccountService.checkPhone(
        email,
      );

      if (checkPhoneData != null) {
        checkPhoneMessage = checkPhoneData["message"];
        if (checkPhoneMessage == "this phone number is already exist") {
          Get.defaultDialog(
            onWillPop: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();

              if (await googleSignIn.isSignedIn()) {
                await googleSignIn.disconnect();
              }
              Get.back();
              return Future.value(false);
            },
            barrierDismissible: false,
            title: "مسجل",
            titleStyle: GoogleFonts.cairo(fontSize: 16.sp),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    "هذا الحساب موجود بالفعل يرجى اختيار حساب آخر",
                    style: GoogleFonts.cairo(fontSize: 18.sp),
                  )),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () async {
                      GoogleSignIn googleSignIn = GoogleSignIn();

                      if (await googleSignIn.isSignedIn()) {
                        await googleSignIn.disconnect();
                      }
                      Get.back();
                      await useGoogleInformation();
                    },
                    child: Container(
                      height: 48.h,
                      width: 130.w,
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
                          "إختيار حساب آخر",
                          style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () async {
                      GoogleSignIn googleSignIn = GoogleSignIn();

                      if (await googleSignIn.isSignedIn()) {
                        await googleSignIn.disconnect();
                      }
                      Get.back();
                    },
                    child: Container(
                      height: 48.h,
                      width: 130.w,
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
                          "إلغاء",
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
            ),
          );
          useGoogleAccount = false;
        }
        update();
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } finally {}
  }


  Future useGoogleInformation() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    await getUserDataFromGoogle();

    useGoogleAccount = true;
    await checkUsername();
    await checkPhone(email);
    if (checkPhoneMessage != "this phone number is already exist") {
      emailController.text = email;
      userNameController.text = displayName;
      passwordController.text = "goooogle";
    }

    update();
  }

  getUserDataFromGoogle() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      displayName = user.displayName ?? '';
      email = user.email ?? '';
    }
  }


  reSendEmailTimer() {
    duration = const Duration(seconds: 80);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      const addSeconds = -1;

      secondsInt = duration.inSeconds + addSeconds;
      if (secondsInt < 0) {
        reSendEmailShow = true;
        update();

        timer!.cancel();
      } else {
        duration = Duration(seconds: secondsInt);
        seconds = twoDigits(duration.inSeconds.remainder(60));
        minutes = twoDigits(duration.inMinutes.remainder(60));
        update();
      }
    });
    update();
  }


  signUp() async {
    isLoading = true;
    update();
    // if (userOtp == correctOtp) {
    try {
      var data = await CreateAccountService.signup(
        userNameController.text,
        emailController.text,
        useGoogleAccount ? "goooogle" : passwordController.text,
        firstNameController.text,
        lastNameController.text,
        chosenPCountry,
        invitationCodeController.text,
        useGoogleAccount ? "1" : "0",
      );

      if (data != null) {
        if (data["message"] == "success") {
          await appServices.sharedPreferences.setString("token", data["token"]);
          await appServices.sharedPreferences
              .setString("userId", data["user_id"].toString());
          await appServices.sharedPreferences
              .setString("firstName", data["first_name"]);
          await appServices.sharedPreferences
              .setString("lastName", data["last_name"]);
          await appServices.sharedPreferences
              .setString("userName", data["username"]);
          await appServices.sharedPreferences
              .setString("phone", data["phone"].toString());
          await appServices.sharedPreferences
              .setString("points", data["points"].toString());
          await appServices.sharedPreferences
              .setString("country", data["country"]);
          await appServices.sharedPreferences
              .setString("inviteCode", data["invite_code"]);
          await appServices.sharedPreferences
              .setString("isAdmin", data["is_admin"].toString());
          await appServices.sharedPreferences
              .setString("isActive", data["is_active"].toString());
          await appServices.sharedPreferences
              .setString("password", passwordController.text);
          appServices.sharedPreferences.setString("isLoggedIn", "true");
          Get.offAllNamed(AppRoute.homeScreen);
        } else if (data["message"] == "This username is already exist") {
          isEnterData = false;
          checkUsernameMessage = data["message"];
          update();
        } else if (data["message"] == "This phone number is already exist") {
          isEnterData = false;
          checkPhoneMessage = data["message"];
          update();
        }
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    invitationCodeController = TextEditingController();
    verifyCodeController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    invitationCodeController.dispose();
    verifyCodeController.dispose();
    super.dispose();
  }

}
