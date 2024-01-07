import 'package:f_a/constant/routes.dart';
import 'package:f_a/middleware/middle_ware.dart';
import 'package:f_a/view/advertisement_screen.dart';
import 'package:f_a/view/create_account_screen.dart';
import 'package:f_a/view/home_screen.dart';
import 'package:f_a/view/login_screen.dart';
import 'package:f_a/view/on_boarding_screen.dart';
import 'package:f_a/view/phone_number_screen.dart';
import 'package:f_a/view/privacy_policy_screen.dart';
import 'package:f_a/view/quiz_screen.dart';
import 'package:f_a/view/reset_password_screen.dart';
import 'package:f_a/view/splash_screen.dart';
import 'package:f_a/view/update_profile_screen.dart';
import 'package:f_a/view/update_screen.dart';
import 'package:f_a/view/watch_ad_screen.dart';
import 'package:f_a/view/welcome_screen.dart';
import 'package:get/get.dart';

import 'view/result_screen.dart';




List<GetPage<dynamic>>? routes=[
  GetPage(name: "/", page: ()=> SplashScreen(),),
  GetPage(name: AppRoute.loginScreen, page: ()=>const LoginScreen(),),
  GetPage(name: AppRoute.welcomeScreen, page: ()=>const WelcomeScreen(),),
  GetPage(name: AppRoute.createAccountScreen, page: ()=>const CreateAccountScreen(),),
  GetPage(name: AppRoute.phoneNumberScreen, page: ()=>const PhoneNumberScreen(),),
  GetPage(name: AppRoute.homeScreen, page: ()=> HomeScreen(),transition: Transition.leftToRight,transitionDuration: Duration(milliseconds: 500),),
  GetPage(name: AppRoute.advertisementScreen, page: ()=> AdvertisementScreen(),),
  GetPage(name: AppRoute.quizScreen, page: ()=> QuizScreen(),),
  GetPage(name: AppRoute.watchAdScreen, page: ()=>  WatchAdScreen(),transition: Transition.rightToLeft,transitionDuration: Duration(milliseconds: 500)),
  GetPage(name: AppRoute.resultScreen, page: ()=>  ResultScreen(),),
  GetPage(name: AppRoute.resetPasswordScreen, page: ()=>  ResetPasswordScreen(),),
  GetPage(name: AppRoute.updateScreen, page: ()=>  UpdateScreen(),),
  GetPage(name: AppRoute.updateProfileScreen, page: ()=>  UpdateProfileScreen(),),
  GetPage(name: AppRoute.privacyPolicyScreen, page: ()=>  PrivacyPolicyScreen(),),
  GetPage(name: AppRoute.onBoardingScreen, page: ()=>const OnBoardingScreen()
      ,middlewares: [MiddleWare()]),
];
