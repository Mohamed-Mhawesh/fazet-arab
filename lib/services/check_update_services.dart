import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant/routes.dart';


class CheckUpdateServices {
  static Future checkUpdate()async{
    try {
      var response = await http
          .get(Uri.parse('${AppRoute.domainLink}/checkUpdate'), headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token'
      },);
      //print('bearer $userToken');

      if (response.statusCode == 200|| response.statusCode == 201) {
        var checkUpdateObject = jsonDecode(response.body);







        print("checkUpdateObject==== $checkUpdateObject");


        return checkUpdateObject;
      } else {
        print("watch ad failed with error${response.statusCode}");
      }
    } catch (e) {
      print("watch ad request Error: ${e.toString()}");
    }

  }

}
