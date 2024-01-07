import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant/routes.dart';
class QuizServices{
  static Future quizRequest(String userId,String token)async{
    try {
      var response = await http
          .post(Uri.parse('${AppRoute.domainLink}/quiz'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: {"user_id": userId}
          );
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var quizObject = jsonDecode(response.body);
        print(quizObject);

        var questions = quizObject["questions"];
        var ads=quizObject["advertisement"];





        print("quiz data ==== $questions");
        print("quiz ads data ==== $ads");


        return [questions,ads];
      } else {
        print("quiz failed with error${response.statusCode}");
      }
    } catch (e) {
      print("quiz request Error: ${e.toString()}");
    }
  }
  static Future sendResultRequest(
      String userId,int points,String token) async {
    try {
      var response = await http
          .post(Uri.parse('${AppRoute.domainLink}/result'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        "user_id": userId,
        "points": points.toString(),
      });
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var resultObject = jsonDecode(response.body);

       var resultMessage=resultObject["message"];




        print("result request message ==== $resultMessage");


        return resultMessage;
      } else {
        print("result request failed with error${response.statusCode}");
      }
    } catch (e) {
      print("result request Error: ${e.toString()}");
    }
  }
}