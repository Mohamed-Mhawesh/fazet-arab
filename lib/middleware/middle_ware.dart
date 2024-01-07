import 'package:f_a/constant/routes.dart';
import 'package:f_a/services/app_services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MiddleWare extends GetMiddleware{
  @override
  int? get  priority => 1;
AppServices appServices =Get.find();
  @override
  RouteSettings? redirect(String? route){
    print("in Middle ware file ${appServices.sharedPreferences.getString
      ("isLoggedIn")}" ) ;
     if(appServices.sharedPreferences.getString("isUpToDate")=="true"){
      if(appServices.sharedPreferences.getString("isNotFirstTime")=="true"){
        if(appServices.sharedPreferences.getString("isLoggedIn")=="true"){
          return const RouteSettings(name: AppRoute.homeScreen);
        }
        return const RouteSettings(name: AppRoute.welcomeScreen);

      }

    }
   else{return const RouteSettings(name: AppRoute.updateScreen);

     }
   return null;

  }
}