import 'package:geminai/modules/views/dashboard_screen/dashboard_screen.dart';
import 'package:geminai/modules/views/home_screen/audio_search_screen.dart';
import 'package:geminai/modules/views/home_screen/home_screen.dart';
import 'package:geminai/modules/views/setting_screen/setting%20_screen.dart';
import 'package:get/get.dart';
import 'modules/views/chat_screen/chat_screen.dart';
import 'modules/views/login_screen.dart';
import 'modules/views/splash_screen/intro_screen.dart';
import 'modules/views/splash_screen/splash_screen.dart';

class Routes {
  // static String introScreen = '/IntroScreen';
  static String homeScreen = '/HomeScreen';
  static String dashBoardScreen = '/DashboardScreen';
  static String splashScreen = '/SplashScreen';

  // static String logInScreen = '/LogInScreen';
  static String chatScreen = '/ChatScreen';
  static String settingScreen = '/SettingScreen';
  static String audioSearchScreen = '/AudioSearchScreen';
}

final getPages = [
  // GetPage(
  //   name: Routes.introScreen,
  //   page: () => const IntroScreen(),
  // ),
  GetPage(
    name: Routes.homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: Routes.dashBoardScreen,
    page: () => const DashBoardScreen(pageIndex: 0),
  ),
  GetPage(
    name: Routes.splashScreen,
    page: () => const SplashScreen(),
  ),
  // GetPage(
  //   name: Routes.logInScreen,
  //   page: () => const LogInScreen(),
  // ),
  GetPage(
    name: Routes.chatScreen,
    page: () => const ChatScreen(),
  ),
  GetPage(
    name: Routes.settingScreen,
    page: () => const SettingScreen(),
  ),
];
