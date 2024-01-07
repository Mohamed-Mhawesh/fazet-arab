import 'dart:async';
import 'package:f_a/constant/routes.dart';
import 'package:f_a/models/advertisement_model.dart';
import 'package:f_a/models/question_model.dart';
import 'package:f_a/services/quiz_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import '../services/app_services.dart';

class QuizController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isLoading = false;
  AppServices appServices = Get.find();
  List<Question> questionsList = [];
  List<Advertisement> advertisementsList = [];
  VideoPlayerController videoController = VideoPlayerController.network("");
  int indexOfQuestion = 0;
  bool isAnswered = false;
  int checkedIndex = -1;
  int points = 0;
  String userId = "";
  String userToken = "";
  int userPoints = 0;

  //////////
  bool isAdLoading = false;
  bool isAdLoaded = false;
  double linearPercentIndicatorValue = 0.0;
  int indexOfAd = 0;
  bool canSkipAd = false;

  getUserDetails() async {
    //get user info from sharedPreferences
    userId = await (appServices.sharedPreferences.getString("userId"))!;
    userToken = await (appServices.sharedPreferences.getString("token"))!;
    userPoints =
        int.parse(await (appServices.sharedPreferences.getString("points"))!);

    print("user id= $userId");
    print("user points= $userPoints");
  }

  getQuizData() async {
    try {
      isLoading = true;
      update();

      //get questions and ads that appear between each question

      var quizData = await QuizServices.quizRequest(userId, userToken);
      print("questions data : ${quizData[0]}");
      print("ads data : ${quizData[1]}");
      print("user id= $userId");
      for (Map<String, dynamic> i in quizData[0]) {
        print(i);

        questionsList.add(Question.fromJson(i));
      }
      print("questionsList length=${questionsList.length}");
      for (Map<String, dynamic> i in quizData[1]) {
        print(i);

        advertisementsList.add(Advertisement.fromJson(i));
      }
    } catch (e) {
      print("quiz error : $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  check(index, isCorrect) {
    //When the user chooses the answer, we verify its correctness and then add a point if it is correct.
    print(
        "/////////////////////////////////check/////////////////////////////");
    if (indexOfQuestion != 9) {
      print(questionsList[indexOfQuestion + 1].answers[0].isCorrect);
      print(questionsList[indexOfQuestion + 1].answers[0].title);
      print(questionsList[indexOfQuestion + 1].answers[1].isCorrect);
      print(questionsList[indexOfQuestion + 1].answers[1].title);
      print(questionsList[indexOfQuestion + 1].answers[2].isCorrect);
      print(questionsList[indexOfQuestion + 1].answers[2].title);
      print(questionsList[indexOfQuestion + 1].answers[3].isCorrect);
      print(questionsList[indexOfQuestion + 1].answers[3].title);
    }

    isAnswered = true;
    checkedIndex = index;
    if (isCorrect == 1) {
      points += 1;
    }
    update();
    print("points = $points");
    print("indexOfQuestion = $indexOfQuestion");
    // If this question is not the last, we move to displaying the ad screen, and if it is the last question, we move to the result screen.
    Future.delayed(const Duration(seconds: 3), () {
      if (indexOfQuestion != 9) {
        Get.toNamed(AppRoute.advertisementScreen);
        if (advertisementsList[indexOfAd].isImg == 0) {
          videoController = VideoPlayerController.network(
              'https://fazetarab.com/${advertisementsList[indexOfAd].path}')
            ..initialize().then((_) {
              videoController.play();

              update();
            });
        }
        Future.delayed(const Duration(seconds: 1), () {
          indexOfQuestion += 1;
          update();
          print("new indexOfQuestion = $indexOfQuestion");
        });
      }
      if (indexOfQuestion == 9) {
        sendResultData();
      }
    });
  }

  getAnswerColor(index, isCorrect) {
    if (isAnswered && checkedIndex == index && isCorrect == 1) {
      return const Color(0xff6ED158);
    } else if (isAnswered && checkedIndex == index && isCorrect != 1) {
      return const Color(0xffFF0000);
    } else {
      return Colors.white;
    }
  }

  sendResultData() async {
    // Users who have more than 799 points must answer at least 8 questions in order to add the points to their points balance.
    if (userPoints > 799) {
      if (points > 7) {
        try {
          var sendResultResponseMessage =
              await QuizServices.sendResultRequest(userId, points, userToken);
          if (sendResultResponseMessage == "success") {
            Get.toNamed(AppRoute.resultScreen);
          }
        } catch (e) {
          print("send result error : $e");
        }
      } else {
        print("oops");
        Get.toNamed(AppRoute.resultScreen);
      }
    } else {
      if (points > 5) {
        try {
          var sendResultResponseMessage =
              await QuizServices.sendResultRequest(userId, points, userToken);
          if (sendResultResponseMessage == "success") {
            Get.toNamed(AppRoute.resultScreen);
          }
        } catch (e) {
          print("send result error : $e");
        }
      } else {
        print("oops");
        Get.toNamed(AppRoute.resultScreen);
      }
    }
  }

  buildIAd(Size size) {
    if (advertisementsList[indexOfAd].isImg == 1) {
      return Image.network(
          "https://fazetarab.com/${advertisementsList[indexOfAd].path}",
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
    } else if (advertisementsList[indexOfAd].isImg == 0) {
      return VideoPlayer(videoController);
    }
  }

  watchAd() {
    // After the allotted time for viewing the ad has passed, we allow the user to skip the ad.
    canSkipAd = true;
    isAnswered = false;
    checkedIndex = -1;
    update();
  }

  goToNextQuestion() {
    videoController.pause();
    Get.toNamed(AppRoute.quizScreen);
    canSkipAd = false;
    if (indexOfAd != 8) {
      indexOfAd += 1;
    }
    update();
  }

  skipQuestion() {
    // If the user does not answer the question, we skip the question at the end of the allotted time.
    if (!isAnswered) {
      print(
          "/////////////////////////////////skip/////////////////////////////");
      Get.toNamed(AppRoute.advertisementScreen);
      Future.delayed(const Duration(seconds: 1), () {
        indexOfQuestion += 1;
        update();
      });
    }
  }

  runAdTimer() {
    Future.delayed(const Duration(seconds: 10), () {
      canSkipAd = true;
    });
  }

  @override
  void onInit() async {
    await getUserDetails();
    getQuizData();
    super.onInit();
  }
}
