import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geminai/core/constants/app_assets.dart';
import 'package:geminai/core/constants/app_textstyle.dart';
import 'package:geminai/modules/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/constants/app_colors.dart';
import '../../../routes.dart';
import '../../controllers/home_controller.dart';
import '../history_screen/history_screen.dart';
import '../home_screen/home_screen.dart';
import '../image_screen/image_screen.dart';

class DashBoardScreen extends StatefulWidget {
  final int? pageIndex;

  const DashBoardScreen({super.key, required this.pageIndex});

  @override
  State<DashBoardScreen> createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> with SingleTickerProviderStateMixin {
  final homeController = Get.put(HomeController());
  TabController? _tabController;

  bool? isActive;
  List<Widget> pages = [
    const HomeScreen(),
    const ImageScreen(),
    const HistoryScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final colorizeColors = [
    AppColors.whiteColor,
    AppColors.primaryColor,
    AppColors.primaryColor2,
  ];

  final colorizeTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontFamily: 'Rowdies',
  );

  @override
  Widget build(BuildContext context) {
    debugPrint('Current screen --> $runtimeType');
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            titlePadding: EdgeInsets.zero,
            backgroundColor: AppColors.lightBlackColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.07),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
              padding: const EdgeInsets.all(12),
              child: Text(
                "Exit App",
                style: AppTextStyle.bold.copyWith(fontSize: 16),
              ),
            ),
            // contentPadding: EdgeInsets.zero,
            content: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Text(
                "Are you sure you want to exit?",
                textAlign: TextAlign.center,
                maxLines: 3,
                style: AppTextStyle.regular,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: buttonView(
                        leftMargin: 8,
                        bottomMargin: 8,
                        title: "Cancel",
                        onPressed: () => Navigator.pop(context),
                        borderRadius: 8,
                        buttonHeight: 40,
                        backGroundColor: AppColors.transparentColor,
                        borderColor: AppColors.greyColor,
                        textSize: 14,
                        textWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: buttonView(
                      rightMargin: 8,
                      bottomMargin: 8,
                      title: "Exit",
                      borderRadius: 8,
                      buttonHeight: 40,
                      textSize: 14,
                      textWeight: FontWeight.w500,
                      onPressed: () => SystemNavigator.pop(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.blackColor,
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: AppColors.blackColor,
            title: Row(
              children: [
                Image.asset(
                  AppAssets.appLogoImg,
                  height: 28,
                  width: 25,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  width: 6,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'GeminAI',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ],
            ),
            //Text("GeminAI", style: AppTextStyle.regular.copyWith(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.whiteColor)),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.settingScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 12, top: 5, bottom: 5),
                  child: Image.asset(
                    AppAssets.settingIcon,
                    height: 20,
                    width: 20,
                    color: AppColors.whiteColor,
                  ),
                ),
              )
            ],
          ),
          body: Obx(() {
            return pages[homeController.selectTabIndex.value];
          }),
          bottomNavigationBar: SafeArea(
            bottom: true,
            child: Container(
              padding: const EdgeInsets.only(top: 8),
              height: 62,
              decoration: const BoxDecoration(
                color: AppColors.blackColor,
              ),
              child: TabBar(
                overlayColor: MaterialStateProperty.all(Colors.black),
                controller: _tabController,
                labelColor: AppColors.whiteColor,
                unselectedLabelColor: AppColors.greyColor,
                dividerColor: AppColors.blackColor,
                indicator: const BoxDecoration(),
                onTap: (index) {
                  homeController.messageCtr.value.clear();
                  homeController.selectTabIndex.value = index;
                  // dashBoardProvider.changeIndex(index);
                },
                tabs: [
                  Tab(icon: tabViewIcon(name: "Chat", icon: AppAssets.chatIcon, tabIndex: 0)),
                  Tab(icon: tabViewIcon(name: "Image", icon: AppAssets.imageIcon, tabIndex: 1)),
                  Tab(icon: tabViewIcon(name: "History", icon: AppAssets.historyIcon, tabIndex: 2)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  tabViewIcon({required String icon, required String name, required int tabIndex}) {
    return Obx(() {
      return Column(
        children: [
          ImageIcon(
            AssetImage(icon),
            size: tabIndex == 2 ? 18 : 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              name,
              style: AppTextStyle.regular
                  .copyWith(fontSize: 11, color: homeController.selectTabIndex.value == tabIndex ? AppColors.whiteColor : AppColors.greyColor),
            ),
          ),
        ],
      );
    });
  }
}
