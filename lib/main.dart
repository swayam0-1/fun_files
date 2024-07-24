import 'package:flutter/material.dart';
import 'package:fun_files/constant.dart';
import 'package:fun_files/controller/auth_controller.dart';
import 'package:fun_files/views/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform,
  ).then((value){
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fun Files',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
     home: LoginScreen(),
      debugShowCheckedModeBanner: false,


    );
  }
}
