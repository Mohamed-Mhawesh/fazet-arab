import 'dart:convert';

import 'package:f_a/constant/routes.dart';
import 'package:http/http.dart' as http;

class CreateAccountService {


  static Future signup(
    username,
    phone,
    password,
    firstname,
    lastname,
    country,
withInviteCode,
      withGoogle,
  ) async {
    try {
      var registerResponse =
          await http.post(Uri.parse('${AppRoute.domainLink}/register'), body: {
        'first_name': firstname,
        'last_name': lastname,
        'username': username,
        'password': password,
        'phone': phone,
        'country': country,
        'with_invite_code':withInviteCode,
        'with_google':withGoogle
      });

      if (registerResponse.statusCode == 200 ||
          registerResponse.statusCode == 201) {
        var stringObject = jsonDecode(registerResponse.body);
// print(stringObject);
//         var user = userFromJson(stringObject);
//         print("successful signup");
        print("stringobject====$stringObject");
        return stringObject;
      } else {
        print("signUp failed with error:${registerResponse.statusCode}");
      }
    } catch (e) {
      print("request Error: ${e.toString()}");
    }
  }

  static Future checkUsername(
    username,
  ) async {
    try {
      var checkUsernameResponse = await http
          .post(Uri.parse('${AppRoute.domainLink}/checkUsername'), body: {
        'username': username,
      });

      if (checkUsernameResponse.statusCode == 200 ||
          checkUsernameResponse.statusCode == 201) {
        var stringObject = jsonDecode(checkUsernameResponse.body);

        print("stringobject====$stringObject");
        return stringObject;
      } else {
        print("checkUsername failed with error:${checkUsernameResponse.statusCode}");
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

        print("stringobject====$stringObject");
        return stringObject;
      } else {
        print("signUp failed with error:${checkPhoneResponse.statusCode}");
      }
    } catch (e) {
      print("request Error: ${e.toString()}");
    }
  }
}
