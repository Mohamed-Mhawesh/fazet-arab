import 'package:f_a/constant/routes.dart';
import 'package:f_a/services/app_services.dart';
import 'package:f_a/services/login_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  bool passwordShow = true;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String phoneMessage = "";
  String passwordMessage = "";
  AppServices appServices = Get.find();

  showHidePassword() {
    passwordShow = !passwordShow;
    update();
  }

  login() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      await signIn();
      Get.offAllNamed(AppRoute.homeScreen);
      appServices.sharedPreferences.setString("isLoggedIn", "true");
      update();
    } else {
      printError();
      update();
    }
  }

  signIn() async {
    isLoading = true;
    update();
    try {
      var data = await LoginService.login(
        emailController.text,
        passwordController.text,
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
              .setString("withGoogle", data["with_google"].toString());
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

          phoneMessage = "";
          passwordMessage = "";
        } else if (data["message"] == "Phone number does not exist") {
          phoneMessage = data["message"];
          update();
          printInfo(info: "loginMessage $phoneMessage");
        } else if (data["message"] == "Password not matched") {
          phoneMessage = "";
          passwordMessage = data["message"];
          update();
        }
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } catch (e) {
      printError(info: 'error : $e', logFunction: () {});
    } finally {
      isLoading = false;
      update();
    }
  }

  signInWithGoogleAccount() async {
    isLoading = true;
    update();
    try {
      var data = await LoginService.loginWithGoogle(
        email,
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
              .setString("withGoogle", data["with_google"].toString());
          await appServices.sharedPreferences
              .setString("country", data["country"]);
          await appServices.sharedPreferences
              .setString("inviteCode", data["invite_code"]);
          await appServices.sharedPreferences
              .setString("isAdmin", data["is_admin"].toString());
          await appServices.sharedPreferences
              .setString("isActive", data["is_active"].toString());

          phoneMessage = "";
          passwordMessage = "";
        } else if (data["message"] == "Phone number does not exist") {
          phoneMessage = data["message"];
          update();
          printInfo(info: "loginMessage $phoneMessage");
        } else if (data["message"] == "Password not matched") {
          phoneMessage = "";
          passwordMessage = data["message"];
          update();
        }
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } catch (e) {
      printError(info: 'error : $e', logFunction: () {});
    } finally {
      isLoading = false;
      update();
    }
  }

  checkPhone() async {
    // isLoading = true;
    update();
    // if (userOtp == correctOtp) {
    try {
      var checkPhoneData = await LoginService.checkPhone(
        email,
      );

      if (checkPhoneData != null) {
        if (checkPhoneData["message"] == "this phone number is valid to use") {
          GoogleSignIn googleSignIn = GoogleSignIn();

          if (await googleSignIn.isSignedIn()) {
            googleSignIn.disconnect();
          }
          Get.defaultDialog(
            title: "غير مسجل",
            titleStyle: GoogleFonts.cairo(fontSize: 16.sp),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    "ليس لديك حساب في فزعة عرب انشئ حسابك الآن",
                    style: GoogleFonts.cairo(fontSize: 18.sp),
                  )),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offNamed(AppRoute.createAccountScreen);
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
                          "إنشاء حساب",
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
        } else {
          await signInWithGoogleAccount();
          Get.offAllNamed(AppRoute.homeScreen);
          appServices.sharedPreferences.setString("isLoggedIn", "true");
          update();
        }

        update();
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } finally {}
  }

  Future signInWithGoogle() async {
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
    getUserDataFromGoogle();
    checkPhone();
  }

  String email = "";
  getUserDataFromGoogle() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      email = user.email ?? '';
    }
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
