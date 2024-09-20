import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/constants/app_colors.dart';

void showLoadingDialog() {
  Future.delayed(
    Duration.zero,
    () {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: AppColors.blackColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                    // CupertinoActivityIndicator(
                    //   radius: 10,
                    //   color: AppColors.primaryColor,
                    // ),
                    CircularProgressIndicator(
                  strokeWidth: 3.0,
                  backgroundColor: AppColors.lightGreyColor.withOpacity(0.5),
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

void hideLoadingDialog() {
  Get.back();
}
