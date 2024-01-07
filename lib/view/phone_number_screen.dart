import 'package:f_a/controllers/phone_number_controller.dart';
import 'package:f_a/function/valid_input.dart';
import 'package:f_a/view/components/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/auth_header.dart';
import 'components/custom_text_field.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Get.put(PhoneNumberController());
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
                      text: 'استرجاع الحساب',
                      onpress: () {
                        Get.back();
                      },
                    ),
                   GetBuilder<PhoneNumberController>(builder: ((controller) {
                     return controller.isEnterData
                         ?Form(
                       key: controller.verifyCodeFormState,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             padding: const EdgeInsets.symmetric(horizontal: 32),
                             child: Text(
                               'يمكنك إعادة طلب رمز التحقق بعد مرور 5 دقائق',
                               style: GoogleFonts.cairo(
                                   color: const Color(0xff3A3B6B),
                                   fontSize: 14,
                                   fontWeight: FontWeight.w500),
                             ),
                           ),
                           Container(
                             padding:
                             const EdgeInsets.only(top: 10, right: 32, left: 32),
                             child:CustomTextField(
                               valid: (val) {
                                 return validInput(val!, 6,6, "verifyCode",
                                     "");
                               },
                               onChanged: (val){
                               },
                               kbType: TextInputType.phone,
                               labelText: "رمز التحقق ",
                               isPasswordField: false,
                               passShow:true,
                               controller: controller.verifyCodeController,
                             ),
                           ),

                           Container(
                             padding: const EdgeInsets.symmetric(vertical: 30),
                             child: Center(
                               child: BlueButton(
                                   size: size,
                                   onTap: ()async {
                                     if (await controller.myAuth
                                         .verifyOTP(
                                     otp: controller
                                         .verifyCodeController
                                         .text) ==
                                     true) {
                                       controller.goToResetPassword();
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
                           SizedBox(
                             width: double.infinity,
                             child: Text(

                               'إعادة طلب رمز التحقق',
                               textAlign: TextAlign.center,
                               style: GoogleFonts.cairo(
                                   color: const Color(0xff3A3B6B),
                                   fontSize: 14,
                                   fontWeight: FontWeight.w500),
                             ),
                           ),


                         ],
                       ),
                     ): Form(
                       key: controller.formState,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             padding: const EdgeInsets.symmetric(horizontal: 32),
                             child: Text(
                               'ادخل بريدك الإلكتروني لنرسل لك رمز التحقق',
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
                                 return validInput(val!, 10, 30,
                                     "phoneToResetPassword", controller.checkPhoneMessage);
                               },
                               onChanged: (val){
                                 controller.checkPhone();
                               },
                               kbType: TextInputType.emailAddress,
                               labelText: "البريد الإلكتروني",
                               isPasswordField: false,
                               passShow: true,
                               controller: controller.emailController,
                             ),
                           ),
                           Container(
                             padding: const EdgeInsets.symmetric(vertical: 30),
                             child: Center(
                               child:  controller.isLoading?CircularProgressIndicator():BlueButton(
                                   size: size,
                                   onTap: () {
                                     controller.goToVerifyCode();
                                   },
                                   text: 'طلب رمز التحقق',
                                   withIcon: false),
                             ),
                           ),
                         ],
                       ),
                     );
                   }))
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
