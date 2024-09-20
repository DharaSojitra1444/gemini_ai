
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_textstyle.dart';

Widget buttonView({
  @required String? title,
  Color? backGroundColor,
  Color? textColor,
  double? borderRadius,
  double? rightMargin,
  double? leftMargin,
  double? topMargin,
  double? bottomMargin,
  double? textSize,
  double? buttonHeight,
  Color? borderColor,
  FontWeight? textWeight,
  Function()? onPressed,
  bool? loader,
}) {
  return GestureDetector(
    onTap: loader == true ? null : onPressed,
    child: Container(
      alignment: Alignment.center,
      height: buttonHeight ?? 45,
      margin: EdgeInsets.only(left: leftMargin ?? 0, right: rightMargin ?? 0, bottom: bottomMargin ?? 0, top: topMargin ?? 0 ),
      decoration: BoxDecoration(
        color: backGroundColor ?? AppColors.primaryColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        border: Border.all(
          color: borderColor ?? AppColors.transparentColor,width: 0.8
        ),
      ),
      child: loader == true
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(color: AppColors.whiteColor, strokeWidth: 2))
          : Text(
              "$title",
              textAlign: TextAlign.center,
              style: AppTextStyle.semiBold.copyWith(
                fontSize: textSize ?? 16,
                color: textColor ?? AppColors.whiteColor,
                fontWeight: textWeight ?? FontWeight.w600,
              ),
            ),
    ),
  );
}
