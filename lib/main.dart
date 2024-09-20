import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:geminai/routes.dart';
import 'package:get/get.dart';
import 'core/constants/app_colors.dart';

// SharedPreferences? pref;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OpenAI.apiKey = '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';
  // pref = await SharedPreferences.getInstance();
  //
  // Supabase.initialize(
  //   url: 'YOUR_SUPABASE_URL',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNzA4OTcyMjAwLAogICJleHAiOiAxODY2ODI1MDAwCn0.4xc4_QRH71P5nqJceQoRRcse-gCm8hskSxcucmO1eIo',
  //   // authCallbackUrlHostname: 'login-callback',
  // );

  runApp(const MyApp());
}

// final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyBehavior(),
      title: 'GeminAi',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.dashBoardScreen,
      // initialRoute: Routes.introScreen,
      getPages: getPages,
      theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          iconTheme: const IconThemeData(color: AppColors.whiteColor),
          useMaterial3: false,
          fontFamily: "OpenSans"),

      // home: const (),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
