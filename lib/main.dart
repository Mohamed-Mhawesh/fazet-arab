import 'package:f_a/services/app_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'routes.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  await initialServices();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff609CFD)
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child)
        { return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar', ''),
          title: 'فزعة عرب',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: SplashScreen(),

          getPages: routes,
        );});
  }
}

//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'FA',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       locale: const Locale('ar',''),
//       debugShowCheckedModeBanner: false,
//       home:  SplashScreen(),
//     );
//   }
// }
