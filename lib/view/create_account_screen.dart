import 'package:f_a/controllers/create_account_controller.dart';
import 'package:f_a/function/valid_input.dart';
import 'package:f_a/services/app_services.dart';
import 'package:f_a/view/components/blue_button.dart';
import 'package:f_a/view/components/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/custom_text_field.dart';
import 'components/auth_header.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => CreateAccountController());
    AppServices appServices = Get.find();

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
                      text: 'إنشاء حساب',
                      onpress: () {
                        Get.back();
                      },
                    ),
                    GetBuilder<CreateAccountController>(builder: (controller) {
                      return controller.isEnterData
                          ? Form(
                              key: controller.verifyCodeFormState,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32),
                                    child: Text(
                                      "",
                                      style: GoogleFonts.cairo(
                                          color: const Color(0xff3A3B6B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 32, left: 32),
                                    child: CustomTextField(
                                      valid: (val) {
                                        // return validInput(
                                        //     val!, 6, 6, "verifyCode", "");
                                      },
                                      onChanged: (val) {},
                                      kbType: TextInputType.phone,
                                      labelText: "رمز التحقق ",
                                      isPasswordField: false,
                                      passShow: true,
                                      controller:
                                          controller.verifyCodeController,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: Center(
                                      child: controller.isLoading
                                          ? const CircularProgressIndicator()
                                          : BlueButton(
                                              size: size,
                                              onTap: () async {
                                                if (await controller.myAuth
                                                        .verifyOTP(
                                                            otp: controller
                                                                .verifyCodeController
                                                                .text) ==
                                                    true) {
                                                  controller.createAccount();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content:
                                                        Text("OTP is verified"),
                                                  ));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content:
                                                        Text("Invalid OTP"),
                                                  ));
                                                }
                                              },
                                              text: 'التحقق',
                                              withIcon: false),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      child: Text(
                                        'يمكنك إعادة طلب رمز التحقق بعد مرور 80 ثانية ',
                                        style: GoogleFonts.cairo(
                                            color: const Color(0xff3A3B6B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: controller.reSendEmailShow
                                        ? Visibility(
                                      visible: !controller.isReSendEmail,
                                          child: InkWell(
                                      onTap: () {
                                          controller.isReSendEmail=true;
                                          controller.sendEmail();
                                      },
                                      child: Text(
                                          'إعادة طلب رمز التحقق',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.cairo(
                                              color:
                                              const Color(0xff609cfd),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                        )
                                        : Text(
                                      '${controller.minutes}:${controller.seconds}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.cairo(
                                          color: const Color(0xff609cfd),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Form(
                              key: controller.formState,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 32, left: 32),
                                    child: CustomTextField(
                                      valid: (val) {
                                        return usernameValidInput(val!, 3, 20,
                                            controller.checkUsernameMessage);
                                      },
                                      onChanged: (val) {
                                        controller.checkUsername();
                                      },
                                      autoValidateMode:
                                          controller.autoValidateMode,
                                      kbType: TextInputType.text,
                                      labelText: "اسم المستخدم",
                                      isPasswordField: false,
                                      passShow: controller.passwordShow,
                                      controller: controller.userNameController,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 32, left: 32),
                                    child: CustomTextField(
                                      valid: (val) {
                                        return validInput(
                                            val!, 3, 20, "firstName", "");
                                      },
                                      autoValidateMode:
                                          controller.autoValidateMode,
                                      kbType: TextInputType.text,
                                      labelText: "الاسم الأول",
                                      isPasswordField: false,
                                      passShow: controller.passwordShow,
                                      controller:
                                          controller.firstNameController,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 32, left: 32),
                                    child: CustomTextField(
                                      valid: (val) {
                                        return validInput(
                                            val!, 3, 20, "lastName", "");
                                      },
                                      autoValidateMode:
                                          controller.autoValidateMode,
                                      kbType: TextInputType.text,
                                      labelText: "الاسم الأخير",
                                      isPasswordField: false,
                                      passShow: controller.passwordShow,
                                      controller: controller.lastNameController,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 32, left: 32),
                                    child: CountryPicker(
                                      countryName: controller.chosenPCountry,
                                      onCountryChanged: (c) {
                                        controller.chosenPCountry = c;
                                        controller.isChoseCountry = true;
                                      },
                                      isChoseCountry: controller.isChoseCountry,
                                    ),
                                    // CustomTextField(kbType: TextInputType
                                    //     .text, labelText: "البلد",
                                    //   isPasswordField: false, passShow: controller.passShow,),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 32, left: 32),
                                    child: CustomTextField(
                                      valid: (val) {
                                        return validInput(
                                            val!, 5, 100, "email", controller.checkPhoneMessage);
                                      },
                                      // {
                                      //   return phoneValidInput(val!, 10, 30,
                                      //       controller.checkPhoneMessage);
                                      // },
                                      onChanged: (val) {
                                     controller.checkPhone(controller.emailController.text);
                                      },
                                      //enabled: controller.useGoogleAccount?false:true,
                                      autoValidateMode:
                                          controller.autoValidateMode,
                                      kbType: TextInputType.emailAddress,
                                      labelText: "البريد الإلكتروني",
                                      isPasswordField: false,
                                      passShow: controller.passwordShow,
                                      controller: controller.emailController,
                                    ),
                                  ),
                                  controller.useGoogleAccount
                                      ? const Text('')
                                      : Container(
                                          padding: const EdgeInsets.only(
                                              top: 10, right: 32, left: 32),
                                          child: CustomTextField(
                                            valid: (val) {
                                              return validInput(
                                                  val!, 8, 20, "password", "");
                                            },
                                            onChanged: (val) {
                                              appServices.sharedPreferences
                                                  .setString("password", val);
                                            },
                                            autoValidateMode:
                                                controller.autoValidateMode,
                                            isPasswordField: true,
                                            kbType:
                                                TextInputType.visiblePassword,
                                            labelText: "كلمة المرور",
                                            passShow: controller.passwordShow,
                                            onPressed: () {
                                              controller.showHidePassword();
                                            },
                                            controller:
                                                controller.passwordController,
                                          )),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 32, left: 32),
                                    child: CustomTextField(
                                      valid: (val) {
                                        return validInput(
                                            val!,
                                            3,
                                            20,
                                            "invitation"
                                                "Code",
                                            "");
                                      },
                                      autoValidateMode:
                                          controller.autoValidateMode,
                                      kbType: TextInputType.text,
                                      labelText: "رمز الدعوة إن وجد",
                                      isPasswordField: false,
                                      passShow: controller.passwordShow,
                                      controller:
                                          controller.invitationCodeController,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32),
                                    child: Text(
                                      '*عند إدخالك رمز الدعوة ستحصل على نقطة',
                                      style: GoogleFonts.cairo(
                                          color: const Color(0xff3A3B6B),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: Center(
                                      child: controller.isLoading
                                          ? const CircularProgressIndicator()
                                          : BlueButton(
                                              size: size,
                                              onTap: () async {
                                                await controller
                                                    .doAfterEnterData();
                                              },
                                              text: 'إنشاء حساب',
                                              withIcon: false),
                                    ),
                                  ),
                                  controller.useGoogleAccount
                                      ? const Text('')
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 30),
                                          child: Center(
                                            child: BlueButton(
                                                size: size,
                                                onTap: () async {
                                                  await controller
                                                      .useGoogleInformation();
                                                },
                                                text: 'استخدام حساب Google',
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
