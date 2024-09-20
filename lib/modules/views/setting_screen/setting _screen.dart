import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geminai/core/constants/app_assets.dart';
import 'package:geminai/modules/widgets/custom_button.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyle.dart';
import '../../widgets/app_network_image.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        titleSpacing: -5,

        leading: IconButton(
          splashColor:  Colors.transparent,
         highlightColor: Colors.transparent,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.whiteColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        title: Text("Settings", style: AppTextStyle.regular.copyWith(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.whiteColor)),
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: AppColors.blackColor,
      //   title: Text("Settings", style: AppTextStyle.regular.copyWith(color: AppColors.blackColor, fontSize: 22)),
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new,
      //       color: AppColors.blackColor,
      //       size: 20,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context, true);
      //     },
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // getStorage!.read("user")['url'] != null
                      //     ? ClipRRect(
                      //         borderRadius: BorderRadius.circular(100),
                      //         child: SizedBox(
                      //           height: 110,
                      //           width: 110,
                      //           child: AppImageAsset(
                      //             image: getStorage!.read("user")['url'],
                      //             isWebImage: true,
                      //             webHeight: 110,
                      //             width: 110,
                      //           ),
                      //         ))
                      //     :
                      Container(
                          height: 110,
                          width: 110,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor.withOpacity(0.08),
                              border: Border.all(color: AppColors.primaryColor.withOpacity(0.2))),
                          child:  AppNetworkImage(
                            image: AppAssets.userIcons,
                            color: AppColors.primaryColor.withOpacity(0.3),
                          )),
                      Container(
                          height: 28,
                          width: 28,
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                          padding: EdgeInsets.all(5),
                          child: AppNetworkImage(
                            image: AppAssets.editIcon,
                            color: AppColors.blackColor,
                            height: 20,
                            width: 20,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "Kimberly",
                style: AppTextStyle.bold.copyWith(
                  fontSize: 16,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            // Have a good day!
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
              child: Text(
                "kimber@ypmail.com",
                style: AppTextStyle.regular.copyWith(fontSize: 12, color: AppColors.lightGreyColor),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                  color: AppColors.lightBlackColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                 // border: Border.all(color: AppColors.greyColor.withOpacity(0.1))
              ),
              child: Column(children: [
                settingTiles(
                  name: "Contact Us", image: AppAssets.emailIcons
                ),
                settingTiles(name: "Privacy & Policy", image: AppAssets.privacyIcons),
                settingTiles(
                  name: "History",
                  image: AppAssets.historyIcon,
                ),
                settingTiles(name: "FeedBack", image: AppAssets.feedbackIcons),
                settingTiles(name: "Help", image: AppAssets.helpIcons),
                settingTiles(
                  name: "Logout",
                  image: AppAssets.logOutIcons,
                ),
              ]),
            ),
            // settingTiles(name: "Privacy & Permissions", image: AppImages.privacyIcons),
            // settingTiles(
            //     name: "Signature",
            //     image: AppImages.signIcon,
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) => EditSignScreen(),
            //         ),
            //       );
            //     }),
            // settingTiles(
            //     name: "History",
            //     image: AppImages.historyIcon,
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) => HistoryScreen(),
            //         ),
            //       );
            //     }),
            // settingTiles(name: "Feedback", image: AppImages.feedbackIcons),
            // settingTiles(name: "Help", image: AppImages.helpIcons),
            // // settingTiles(name: "About", image: AppImages.aboutIcons),
            // settingTiles(
            //     name: "Log out",
            //     image: AppImages.logOutIcons,
            //     onTap: () {
            //       logOutDialog();
            //     }),
          ],
        ),
      ),
    );
  }

  settingTiles({String? name, String? image, GestureTapCallback? onTap}) {
    return InkWell(
      overlayColor: MaterialStateProperty.all<Color>(Colors.white),
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        image! ?? AppAssets.emailIcons,
                        height: 18,
                        width: 18,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        name!,
                        style: AppTextStyle.bold.copyWith(
                          fontSize: 13.5,
                          color: AppColors.whiteColor.withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                   Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                    color: AppColors.whiteColor.withOpacity(0.8),
                  )
                ],
              ),
            ),
            if(name != "Logout")
            Container(
              height: 0.8,
              width: double.infinity,
              color: AppColors.lightGreyColor.withOpacity(0.15),
            )
          ],
        ),
      ),
    );
  }

  logOutDialog() {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.only(left: 50, right: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor.withOpacity(0.12)),
                      child: Image.asset(
                        AppAssets.appLogoImg,
                        scale: 2,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Logout",
                      style: AppTextStyle.regular.copyWith(color: AppColors.blackColor, fontSize: 16, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Are you sure, do you want to logout?",
                      style: AppTextStyle.medium.copyWith(color: AppColors.lightGreyColor, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: buttonView(
                            textSize: 14,
                            buttonHeight: 45,
                            textWeight: FontWeight.w600,
                            backGroundColor: AppColors.lightGreyColor.withOpacity(0.18),
                            textColor: AppColors.blackColor,
                            onPressed: () {
                              Get.back();
                            },
                            title: 'No',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: buttonView(
                            textSize: 14,
                            buttonHeight: 45,
                            textWeight: FontWeight.w600,
                            title: "Yes",
                            onPressed: () async {
                              // Navigator.of(context, rootNavigator: true)
                              //     .pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
