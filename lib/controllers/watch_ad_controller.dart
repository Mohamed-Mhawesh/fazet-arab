import 'package:f_a/constant/routes.dart';

import 'package:f_a/models/advertisement_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../services/app_services.dart';
import '../services/home_services.dart';

class WatchAdController extends GetxController {
  bool isLoading = false;
  AppServices appServices = Get.find();
  bool canSkipAd = false;
  Advertisement advertisement = Advertisement(
      id: 0,
      title: "title",
      path: "null",
      homeAd: 1,
      priority: 1,
      isImg: 1,
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  String userId = "";
  String userToken = "";
  VideoPlayerController videoController = VideoPlayerController.network("");

  getUserDetails() async {
    //get user info from sharedPreferences
    userId = await (appServices.sharedPreferences.getString("userId"))!;
    userToken = await (appServices.sharedPreferences.getString("token"))!;

    print("user id= $userId");
  }

  getAdData() async {
    try {
      isLoading = true;
      update();
      var adsData = await HomeServices.watchAdRequest(userToken);
      //w print(adsData);

      advertisement = Advertisement.fromJson(adsData[0]);

      if (advertisement.isImg == 0) {
        videoController = VideoPlayerController.network(
            'https://fazetarab.com/${advertisement.path}')
          ..initialize().then((_) {
            videoController.play();
            runAdTimer();
            update();
          });
      }
      update();
    } catch (e) {
      print("watch ad error : $e");
    } finally {
      if (advertisement.isImg == 1) {
        runAdTimer();
      }
      isLoading = false;
      update();
    }
  }

  buildIAd(Size size) {
    if (advertisement.isImg == 1) {
      return Image.network("https://fazetarab.com/${advertisement.path}",
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return child;
      }, loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: SizedBox(
                width: size.width * 0.5,
                child: Lottie.asset("assets/images/loading.json")),
          );
        }
      });
    } else if (advertisement.isImg == 0) {
      return VideoPlayer(videoController);
    }
  }

  completeWatchingAd() async {
    try {
      isLoading = true;
      update();
      var completeWatchingData = await HomeServices.completeWatchingAdRequest(
          userId, advertisement.id, userToken);
      if (completeWatchingData["message"] == "success") {
        Get.offAllNamed(AppRoute.homeScreen);
      }
    } catch (e) {
      print("complete watching Ad error");
    } finally {
      isLoading = false;
      update();
    }
  }

  runAdTimer() {
    Future.delayed(const Duration(seconds: 12), () {
      canSkipAd = true;
      update();
    });
  }

  @override
  void onInit() async {
    await getUserDetails();
    getAdData();
    super.onInit();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
