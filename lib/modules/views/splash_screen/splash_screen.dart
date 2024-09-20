import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyle.dart';
import '../../../routes.dart';
import '../../widgets/custom_textfield.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.size.height,
        width: Get.size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage(AppAssets
                    .backImage) /*NetworkImage(
                    "https://i.pinimg.com/564x/c5/61/57/c56157e053e3a1dbaad3682a6c01e9d8.jpg")*/
                ,
                fit: BoxFit.cover,
                opacity: 8,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.63), BlendMode.darken))),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: Get.size.height / 12,
                ),
                Image.asset(
                  AppAssets.logo,
                  height: Get.size.height / 17,
                ),
                SizedBox(
                  height: Get.size.height / 8,
                ),
                Text(
                  "Welcome back 🎉",
                  style: AppTextStyle.medium.copyWith(color: AppColors.whiteColor.withOpacity(0.75), fontSize: 27),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Please enter required details!",
                  style: AppTextStyle.regular.copyWith(color: AppColors.whiteColor.withOpacity(0.5), fontSize: 13),
                ),
                const SizedBox(
                  height: 40,
                ),
                customTextField(
                    labelText: "Email",
                    textEditingController: TextEditingController(),
                    borderRadius: 50,
                    topFieldPadding: 16,
                    textFieldBackgroundColor: AppColors.transparentColor,
                    textColor: AppColors.whiteColor,
                    borderSideColor: AppColors.whiteColor.withOpacity(0.6)),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.chatScreen);
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff7669EC),
                          Color(0xff66BAD0),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Center(
                      child: Text("Continue", style: AppTextStyle.bold.copyWith(color: AppColors.whiteColor, fontSize: 15)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 25),
                  child: Text.rich(
                    TextSpan(
                        text: "Don't have an account?  ",
                        style: AppTextStyle.regular.copyWith(fontSize: 13, color: AppColors.whiteColor.withOpacity(0.6)),
                        children: <TextSpan>[
                          TextSpan(
                              text: "SignUp",
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              style: AppTextStyle.semiBold.copyWith(fontSize: 13.5, color: AppColors.whiteColor.withOpacity(0.85))),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: AppColors.whiteColor.withOpacity(0.3),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Or",
                          style: AppTextStyle.regular.copyWith(
                            fontSize: 14,
                            color: AppColors.whiteColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        color: AppColors.whiteColor.withOpacity(0.3),
                      )),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.chatScreen);
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 30),
                    width: Get.size.width,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Image(
                              image: AssetImage(AppAssets.googleIcon),
                              height: 20,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Continue with Google",
                          textAlign: TextAlign.start,
                          style: AppTextStyle.bold.copyWith(color: AppColors.blackColor.withOpacity(0.85), fontSize: 13.5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
