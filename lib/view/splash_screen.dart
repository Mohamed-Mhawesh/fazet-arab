import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body:Stack(
          children: [
            SizedBox(
                height: size.height,
                width: double.infinity,
                child: Image.asset("assets/images/splash.png",fit: BoxFit.fill)),
            Center(
                child: SizedBox(
                    width: size.width * 0.6,
                    child: Image.asset("assets/icons/fazetarab.png"))),
          ],
        ),
      ),
    );
  }
}
