import 'package:f_a/constant/routes.dart';
import 'package:f_a/view/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'components/blue_button.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(0xffF6F6F6),
          child: Center(
            child: Stack(
              children: [
                // SizedBox(
                //     height: size.height,
                //     width: double.infinity,
                //     child: Image.asset("assets/images/splash.png",fit: BoxFit.fill)),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: size.height*0.66,
                        width: size.width * 0.8,
                        child: Image.asset("assets/icons/fazetarab.png"),
                      ),


                      BlueButton(
                        size: size,
                        onTap: () async {
                          GoogleSignIn googleSignIn = GoogleSignIn();

                          if(await googleSignIn.isSignedIn()){
                            googleSignIn.disconnect();
                          }
                          Get.toNamed(AppRoute.loginScreen);
                        },
                        text: "تسجيل الدخول",
                        withIcon: false,
                      ),
                      SizedBox(
                        height: size.height * 0.060,
                      ),
                      BlueButton(
                        size: size,
                        onTap: ()async {
                          GoogleSignIn googleSignIn = GoogleSignIn();

                          if(await googleSignIn.isSignedIn()){
                          googleSignIn.disconnect();
                          }
                          Get.toNamed(AppRoute.createAccountScreen);
                        },
                        text: "انشاء حساب",
                        withIcon: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
