import 'package:f_a/constant/routes.dart';
import 'package:f_a/function/valid_input.dart';
import 'package:f_a/view/components/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';
import 'components/custom_text_field.dart';
import 'components/auth_header.dart';
import 'components/login/create_account_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    Size size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xffF6F6F6),
      child: Stack(
        //alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/vector.png",
              color: const Color(0xff609CFD).withOpacity(0.4),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent.withOpacity(0),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      size: size,
                      text: 'تسجيل الدخول',
                      onpress: () {
                        Get.back();
                      },
                    ),
                    GetBuilder<LoginController>(builder: (controller) {
                      return Form(
                        key: controller.formState,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 10.h, right: 32.w, left: 32.w),
                              child: CustomTextField(
                                valid: (val) {
                                  return validInput(val!, 10, 30, "loginPhone",
                                      controller.phoneMessage);
                                },
                                onChanged: (val) {
                                  controller.signIn();
                                },
                                kbType: TextInputType.emailAddress,
                                labelText: "البريد الإلكتروني ",
                                isPasswordField: false,
                                passShow: controller.passwordShow,
                                controller: controller.emailController,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    top: 10.h, right: 32.w, left: 32.w),
                                child: CustomTextField(
                                  valid: (val) {
                                    return validInput(
                                        val!,
                                        8,
                                        30,
                                        "loginPassword",
                                        controller.passwordMessage);
                                  },
                                  onChanged: (val) {
                                    controller.signIn();
                                  },
                                  isPasswordField: true,
                                  kbType: TextInputType.visiblePassword,
                                  labelText: "كلمة المرور",
                                  passShow: controller.passwordShow,
                                  onPressed: () {
                                    controller.showHidePassword();
                                  },
                                  controller: controller.passwordController,
                                )),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoute.phoneNumberScreen);
                                },
                                child: Text(
                                  textAlign: TextAlign.end,
                                  'هل نسيت كلمة السر؟',
                                  style: GoogleFonts.cairo(
                                      color: const Color(0xff3A3B6B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 30.h),
                              child: controller.isLoading
                                  ? const CircularProgressIndicator()
                                  : BlueButton(
                                      size: size,
                                      onTap: () {
                                        controller.login();
                                      },
                                      text: 'تسجيل الدخول',
                                      withIcon: false),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30),
                              child: Center(
                                child: BlueButton(
                                    size: size,
                                    onTap: () async {
                                      await controller
                                          .signInWithGoogle();
                                    },
                                    text: 'الدخول باستخدام Google',
                                    withIcon: false),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const CreateAccountButton(),
                  const  SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
          //Image.asset("assets/images/logo.png"),
        ],
      ),
    );
  }
}
