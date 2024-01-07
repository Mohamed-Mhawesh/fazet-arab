
import 'package:f_a/constant/routes.dart';
import 'package:f_a/controllers/update_profile_controller.dart';
import 'package:f_a/function/valid_input.dart';
import 'package:f_a/services/app_services.dart';
import 'package:f_a/view/components/blue_button.dart';
import 'package:f_a/view/components/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/custom_text_field.dart';
import 'components/auth_header.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => UpdateProfileController());
    AppServices appServices = Get.find();
    String? username = appServices.sharedPreferences.getString("userName");
    String? phone = appServices.sharedPreferences.getString("phone");
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
                      text: 'تعديل الحساب',
                      onpress: () {
                        Get.offAllNamed(AppRoute.homeScreen);
                      },
                    ),
                    GetBuilder<UpdateProfileController>(builder: (controller) {
                      return Form(
                              key: controller.formState,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 32, left: 32),
                                    child: CustomTextField(
                                      valid: (val) {return ;},
                                      onChanged: (val) {
                                       //val=username!;
                                      },
                                      enabled: false,
                                      autoValidateMode:
                                          controller.autoValidateMode,
                                      kbType: TextInputType.text,
                                      labelText: "$username",
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
                                        countryName: controller
                                            .chosenPCountry,
                                        onCountryChanged: (c) {
                                          controller.chosenPCountry = c;
                                          controller.isChoseCountry = true;
                                        }, isChoseCountry: controller.isChoseCountry,),
                                    // CustomTextField(kbType: TextInputType
                                    //     .text, labelText: "البلد",
                                    //   isPasswordField: false, passShow: controller.passShow,),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 32, left: 32),
                                    child: CustomTextField(
                                      valid: (val) {return ;},
                                      onChanged: (val) {
                                      },
                                      autoValidateMode:
                                          controller.autoValidateMode,
                                      kbType: TextInputType.phone,
                                      labelText: "$phone",
                                      isPasswordField: false,
                                      enabled: false,
                                      passShow: controller.passwordShow,
                                      controller: controller.phoneController,
                                    ),
                                  ),
                                  Visibility(
                                    visible: controller.withGoogle=="0" ,
                                    child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 32, left: 32),
                                        child: CustomTextField(
                                          valid: (val) {
                                            return validInput(
                                                val!, 8, 20, "password", "");
                                          },
                                          onChanged: (val){

                                          },
                                          autoValidateMode:
                                              controller.autoValidateMode,
                                          isPasswordField: true,
                                          kbType: TextInputType.visiblePassword,
                                          labelText: "كلمة المرور",
                                          passShow: controller.passwordShow,
                                          onPressed: () {
                                            controller.showHidePassword();
                                          },
                                          controller:
                                              controller.passwordController,
                                        )),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: Center(
                                      child: controller
                                          .isLoading?const CircularProgressIndicator():BlueButton(
                                          size: size,
                                          onTap: () {
                                            controller.afterEditData();
                                          },
                                          text: 'تعديل',
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
