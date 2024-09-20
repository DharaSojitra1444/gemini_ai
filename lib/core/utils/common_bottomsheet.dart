import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geminai/modules/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_textstyle.dart';

class CommonBottomSheet {
  final homeController = Get.put(HomeController());

  addButtonBottomSheet({required String navigateBy}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: AppColors.lightBlackColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: Get.context!,
        builder: (context) {
          return SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.greyColor,
                      ),
                      width: 60,
                      height: 2.2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        pickImageOptionBottomSheet(navigateBy: navigateBy);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                                height: 32,
                                width: 32,
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: AppColors.lightGreenColor, shape: BoxShape.circle),
                                child: Image.asset(AppAssets.ocrIcons, color: AppColors.blackColor)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "OCR",
                              style: AppTextStyle.bold.copyWith(fontSize: 14, color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  pickImageOptionBottomSheet({required String navigateBy}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: AppColors.lightBlackColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: Get.context!,
        builder: (context) {
          return SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.greyColor,
                      ),
                      width: 60,
                      height: 2.3,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        homeController.readTextFromImage(imageSource: ImageSource.camera, navigateBy: navigateBy);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: Row(
                          children: [
                            Container(
                                height: 32,
                                width: 32,
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: AppColors.lightGreenColor, shape: BoxShape.circle),
                                child: Image.asset(AppAssets.cameraIcons, color: AppColors.blackColor)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Camera",
                              style: AppTextStyle.bold.copyWith(fontSize: 14, color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        homeController.readTextFromImage(imageSource: ImageSource.gallery, navigateBy: navigateBy);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: Row(
                          children: [
                            Container(
                                height: 32,
                                width: 32,
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: AppColors.skyBlueColor, shape: BoxShape.circle),
                                child: Image.asset(AppAssets.galleryIcons, color: AppColors.blackColor)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Pick Photo",
                              style: AppTextStyle.bold.copyWith(fontSize: 14, color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
