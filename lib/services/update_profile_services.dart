import 'dart:convert';

import 'package:f_a/constant/routes.dart';
import 'package:http/http.dart' as http;

class UpdateProfileService {
  static Future updateProfile(
      id,
      password,
      firstname,
      lastname,
      country,
      String token
      ) async {
    try {
      var updateProfileResponse =
      await http.post(Uri.parse('${AppRoute.domainLink}/updateProfile'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'first_name': firstname,
        'last_name': lastname,
        'password': password,
        'id': id,
        'country': country,
      });

      if (updateProfileResponse.statusCode == 200 ||
          updateProfileResponse.statusCode == 201) {
        var stringObject = jsonDecode(updateProfileResponse.body);
// print(stringObject);
//         var user = userFromJson(stringObject);
//         print("successful signup");
        print("stringobject====$stringObject");
        return stringObject;
      } else {
        print("signUp failed with error:${updateProfileResponse.statusCode}");
      }
    } catch (e) {
      print("request Error: ${e.toString()}");
    }
  }

}
