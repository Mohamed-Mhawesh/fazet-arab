import 'dart:convert';

import 'package:f_a/constant/routes.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future login(
    phone,
    password,
  ) async {
    try {
      var response =
          await http.post(Uri.parse('${AppRoute.domainLink}/login'), body: {
        'password': password,
        'phone': phone,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var stringObject = jsonDecode(response.body);
// print(stringObject);
//         var user = userFromJson(stringObject);
//         print("successful signup");

        print("stringObject====$stringObject");
        return stringObject;
      } else {
        print("signUp failed with error:${response.statusCode}");
      }
    } catch (e) {
      print("request Error: ${e.toString()}");
    }
  }

  static Future loginWithGoogle(
      phone,
      ) async {
    try {
      var response =
      await http.post(Uri.parse('${AppRoute.domainLink}/login/google'), body: {
        'password': "goooogle",
        'phone': phone,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var stringObject = jsonDecode(response.body);
// print(stringObject);
//         var user = userFromJson(stringObject);
//         print("successful signup");

        print("stringObject====$stringObject");
        return stringObject;
      } else {
        print("login failed with error:${response.statusCode}");
      }
    } catch (e) {
      print("request Error: ${e.toString()}");
    }
  }


  static Future resetPassword(
    phone,
    password,
    String token
  ) async {
    try {
      var response = await http
          .post(Uri.parse('${AppRoute.domainLink}/resetPassword'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
        'password': password,
        'phone': phone,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var stringObject = jsonDecode(response.body);
// print(stringObject);
//         var user = userFromJson(stringObject);
//         print("successful signup");

        print("stringObject====$stringObject");
        return stringObject;
      } else {
        print("signUp failed with error:${response.statusCode}");
      }
    } catch (e) {
      print("request Error: ${e.toString()}");
    }
  }

  static Future checkPhone(
      phone,
      ) async {
    try {
      var checkPhoneResponse = await http
          .post(Uri.parse('${AppRoute.domainLink}/checkPhone'), body: {
        'phone':phone,
      });

      if (checkPhoneResponse.statusCode == 200 ||
          checkPhoneResponse.statusCode == 201) {
        var stringObject = jsonDecode(checkPhoneResponse.body);

        print("checkPhone====$stringObject");
        return stringObject;
      } else {
        print("signUp failed with error:${checkPhoneResponse.statusCode}");
      }
    } catch (e) {
      print("request Error: ${e.toString()}");
    }
  }
}
