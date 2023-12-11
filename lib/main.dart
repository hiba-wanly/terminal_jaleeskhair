import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaleskhair/controller/dependency_injection.dart';
import 'package:jaleskhair/login/presentation/auth_login.dart';
import 'package:jaleskhair/login/presentation/login_page.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/userInterface/presentation/user_interface.dart';

Future<void> main() async{
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        // useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(selectionHandleColor: primarycolor)
      ),
      debugShowCheckedModeBanner: false,
      home:
      // LoginScreen()
      AuthLogin(),
    );
  }
}

