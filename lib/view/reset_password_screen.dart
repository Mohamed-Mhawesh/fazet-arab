import 'package:f_a/controllers/reset_password_controller.dart';
import 'package:f_a/services/app_services.dart';
import 'package:f_a/view/components/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../function/valid_input.dart';
import 'components/auth_header.dart';
import 'components/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => ResetPasswordController());
    AppServices appServices=Get.find();
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
                      text: 'استرجاع الحساب',
                      onpress: () {
                        Get.back();
                      },
                    ),
                    GetBuilder<ResetPasswordController>(builder: (controller) {
                      return Form(
                        key: controller.formState,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 32, left: 32),
                                child: CustomTextField(
                                  valid: (val) {
                                    return validInput(val!, 8, 30, "", "");
                                  },
                                  onChanged: (val) {
                                    appServices.sharedPreferences.setString
                                      ("password",  val);
                                  },
                                  isPasswordField: true,
                                  kbType: TextInputType.visiblePassword,
                                  labelText: "كلمة السر الجديدة",
                                  passShow: controller.passwordShow,
                                  onPressed: () {
                                    controller.showHidePassword();
                                  },
                                  controller: controller.passwordController,
                                )),
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 32, left: 32),
                                child: CustomTextField(
                                  valid: (val) {
                                    return validInput(val!, 8, 30, "confirmPassword", "");
                                  },
                                  onChanged: (val) {},
                                  isPasswordField: true,
                                  kbType: TextInputType.visiblePassword,
                                  labelText: "اعد كتابة كلمة السر الجديدة",
                                  passShow: controller.confirmPasswordShow,
                                  onPressed: () {
                                    controller.showHideConfirmPassword();
                                  },
                                  controller: controller.confirmPasswordController,
                                )),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Center(
                                child: controller.isLoading
                                    ? const CircularProgressIndicator()
                                    : BlueButton(
                                    size: size,
                                    onTap: () {
                                      controller.goToLogin();
                                    },
                                    text: 'تغيير كلمة السر',
                                    withIcon: false),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
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
