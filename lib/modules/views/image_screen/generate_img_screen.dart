import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geminai/core/constants/app_textstyle.dart';
import 'package:geminai/core/utils/toast.dart';
import 'package:geminai/modules/widgets/app_network_image.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loading_dialog.dart';

class GenerateImgScreen extends StatefulWidget {
  String? title;
   String? url;

  GenerateImgScreen({super.key, this.title, this.url});

  @override
  State<GenerateImgScreen> createState() => GenerateImgScreenState();
}

class GenerateImgScreenState extends State<GenerateImgScreen> {
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
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.blackColor,
        titleSpacing: -8,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: AppColors.whiteColor,
          ),
        ),
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
        //Text("GeminAI", style: AppTextStyle.regular.copyWith(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.whiteColor)),,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: AppColors.whiteColor.withOpacity(0.1),
                  child: AppNetworkImage(
                    image: widget.url,
                    isWebImage: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  //Expanded(child: Text(widget.title!, style: AppTextStyle.bold.copyWith(fontSize: 13.5),)),
                  Expanded(
                    child: AppTextField(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.transparentColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.transparentColor),
                      ),
                      controller: TextEditingController(
                        text: widget.title,
                      ),
                      // maxLines: 6,
                      readOnly: true,
                      maxLines: 1,
                      contentPadding: EdgeInsets.only(left: 15, right: 10),
                      hint: 'Type a prompt...',
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: (){
                      save();
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.whiteColor.withOpacity(0.09),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          AppAssets.downloadIcons,
                          height: 20,
                          width: 20,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                   onTap: () async {
                     await Share.shareUri(
                       Uri.parse(widget.url!),
                     );
                   } ,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.whiteColor.withOpacity(0.09),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          AppAssets.shareIcons,
                          height: 16,
                          width: 15,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            reGenerateButton()
          ],
        ),
      ),
    );
  }

  save() async {
    var response = await Dio().get(widget.url!, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: "GeminAI_${DateTime.now().microsecondsSinceEpoch}");
    if (result["isSuccess"]) {
      print("download sucessfully");
       showSuccessToast(toastMessage: "Download successfully");
    }
  }


  reGenerateButton() {
    return buttonView(
      textColor: AppColors.blackColor,
      textSize: 15,
      topMargin: 15,
      bottomMargin: 20,
      onPressed: () async {
        showLoadingDialog();
        OpenAIImageModel image = await OpenAI.instance.image.create(
          prompt: widget.title!,
          n: 1,
          size: OpenAIImageSize.size1024,
          responseFormat: OpenAIImageResponseFormat.url,
        );
        hideLoadingDialog();
        if (image.data.isNotEmpty) {
          print(image.data.first.url);
          widget.url = image.data.first.url;
          setState(() {});
        }
      },
      borderRadius: 10,
      title: "Re-Generate",
    );
  }
}
