import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant/routes.dart';

class HomeServices{
  static Future mainRequest(
      String userId,String token) async {
    try {
      var response = await http
          .post(Uri.parse('${AppRoute.domainLink}/home'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        "user_id": userId,
      });
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var homeObject = jsonDecode(response.body);

        var advertisement = homeObject["advertisement"];
        var attempt = homeObject["attempt"];
        var points = homeObject["points"];
        var addAttempts = homeObject["ad_attempt"];




        print("banner ads data ==== $advertisement");
        print("home attempt data ==== $attempt");
        print("home points data ==== $points");
        print("home ad attempts data ==== $addAttempts");

        return [advertisement, attempt,points,addAttempts];
      } else {
        print("Home failed with error${response.statusCode}");
      }
    } catch (e) {
      print("advertisement request Error: ${e.toString()}");
    }
  }
  static Future watchAdRequest(String token)async{
    try {
      var response = await http
          .get(Uri.parse('${AppRoute.domainLink}/watchAd'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },);
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var adsObject = jsonDecode(response.body);

        var advertisement = adsObject["ad"];





        print("ad data ==== $advertisement");


        return advertisement;
      } else {
        print("watch ad failed with error${response.statusCode}");
      }
    } catch (e) {
      print("watch ad request Error: ${e.toString()}");
    }

  }

  static Future completeWatchingAdRequest(
      String userId,int ad,String token) async {
    try {
      var response = await http
          .post(Uri.parse('${AppRoute.domainLink}/watched'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        "user_id": userId,
        "ad":ad.toString(),
      });
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var homeObject = jsonDecode(response.body);


        return homeObject;
      } else {
        print("complete watching Ad failed with error${response.statusCode}");
      }
    } catch (e) {
      print("complete watching Ad request Error: ${e.toString()}");
    }
  }
  static Future transferRequest(
      String userId,int points,String token,String phone) async {
    try {
      var response = await http
          .post(Uri.parse('${AppRoute.domainLink}/transferRequest'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        "user_id": userId,
        "points":points.toString(),
        "phone":phone,
      });
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var transferResponse = jsonDecode(response.body);
        String transferMessage= transferResponse["message"];


        return transferMessage;
      } else {
        print("transfer failed with error${response.statusCode}");
      }
    } catch (e) {
      print("transfer request Error: ${e.toString()}");
    }
  }
  static Future inviteFriendRequest(String token,String userId)async{
    try {
      var response = await http
          .post(Uri.parse('${AppRoute.domainLink}/inviteMessage'), headers: {
        'Accept': 'application/json',
         'Authorization': 'Bearer $token'
      },
      body: {"user_id": userId,}
      );
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var inviteObject = jsonDecode(response.body);

        var inviteMessage = inviteObject["message"];





        print("invite data ==== $inviteMessage");


        return inviteMessage;
      } else {
        print("Invite friend failed with error${response.statusCode}");
      }
    } catch (e) {
      print("Invite friend request Error: ${e.toString()}");
    }

  }
  static Future contactUsRequest(String token)async{
    try {
      var response = await http
          .get(Uri.parse('${AppRoute.domainLink}/contactUs'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },);
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var contactUsObject = jsonDecode(response.body);


         var contactUsPhone = contactUsObject["phone"];




        return contactUsPhone;
      } else {
        print("contact us failed with error${response.statusCode}");
      }
    } catch (e) {
      print("contact us request Error: ${e.toString()}");
    }

  }
  static Future privacyPolicyRequest()async{
    try {
      var response = await http
          .get(Uri.parse('${AppRoute.domainLink}/privacyPolicy'), headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token'
      },);
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var privacyPolicyObject = jsonDecode(response.body);


        var privacyPolicyUrl = privacyPolicyObject["message"];
        print("privacyPolicyUrl=$privacyPolicyUrl");




        return privacyPolicyUrl;
      } else {
        print("privacyPolicy failed with error${response.statusCode}");
      }
    } catch (e) {
      print("privacyPolicy request Error: ${e.toString()}");
    }

  }
}
