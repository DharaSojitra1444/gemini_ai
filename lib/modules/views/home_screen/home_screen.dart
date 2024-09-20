import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:geminai/core/constants/app_assets.dart';
import 'package:geminai/core/constants/app_colors.dart';
import 'package:geminai/core/constants/app_textstyle.dart';
import 'package:geminai/modules/controllers/home_controller.dart';
import 'package:geminai/modules/views/chat_screen/chat_screen.dart';
import 'package:geminai/modules/views/home_screen/audio_search_screen.dart';
import 'package:geminai/modules/views/home_screen/ocr_text_screen.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/common_bottomsheet.dart';
import '../../../routes.dart';
import '../../widgets/custom_textfield.dart';
import 'common_question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [suggestionsView(), commonQuestionText(), commonQuestionList(), commonQuestionListTile()],
              ),
            ),
          ),

          ///text-form field
          sendMessage()
        ],
      ),
    );
  }

  suggestionsView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 10, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Suggestions",
                style: AppTextStyle.bold.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 140,
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: homeController.suggestionList.length,
              itemBuilder: (context, index) {
                List<int> randomIndices = [];
                while (randomIndices.length < 2) {
                  int randomIndex = Random().nextInt(homeController.suggestionList[index]["list"].length);
                  if (!randomIndices.contains(randomIndex)) {
                    randomIndices.add(randomIndex);
                  }
                }
                return Padding(
                  padding: EdgeInsets.only(right: 12.0, left: index == 0 ? 16 : 0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    decoration: BoxDecoration(
                        color: AppColors.lightBlackColor,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        //  border: Border.all(color: const Color(0xff5E5E5E))),
                        border: Border.all(color: AppColors.greyColor.withOpacity(0.1))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  homeController.suggestionList[index]["title"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.bold
                                      .copyWith(fontSize: 14.5, fontWeight: FontWeight.w400, color: homeController.suggestionList[index]['color']
                                          // color: exploreProvider.tapIndex == index ? Colors.white : Colors.black,
                                          ),
                                ),
                              ),
                              if (index == 0)
                                Icon(
                                  Icons.close,
                                  color: homeController.suggestionList[index]['color'],
                                  size: 18,
                                )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < randomIndices.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    homeController.messageCtr.value.text = homeController.suggestionList[index]["listDec"][randomIndices[i]];
                                    FocusScope.of(context).requestFocus();
                                    homeController.messageCtr.refresh();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: i == randomIndices.length - 1 ? 0 : 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(color: AppColors.lightBlackColor2, borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      homeController.suggestionList[index]["list"][randomIndices[i]],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.regular.copyWith(
                                        fontSize: 11.5,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          //       decoration: BoxDecoration(color: AppColors.lightBlackColor2, borderRadius: BorderRadius.circular(8)),
                          //       child: Text(
                          //         homeController.suggestionList[index]["list"][randomIndex],
                          //         maxLines: 1,
                          //         overflow: TextOverflow.ellipsis,
                          //         style: AppTextStyle.regular.copyWith(
                          //           fontSize: 11.5,
                          //           // color: exploreProvider.tapIndex == index ? Colors.white : Colors.black,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 8,
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          //   decoration: BoxDecoration(color: AppColors.lightBlackColor2, borderRadius: BorderRadius.circular(8)),
                          //   child: Text(
                          //     homeController.suggestionList[index]["list"][randomIndex],
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: AppTextStyle.regular.copyWith(
                          //       fontSize: 11.5,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  commonTiles({String? name, bool? isLastIndex, GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          top: 13,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name!,
                    style: AppTextStyle.regular.copyWith(
                      fontSize: 14,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                  color: AppColors.whiteColor.withOpacity(0.9),
                )
              ],
            ),
            if (isLastIndex == false)
              Container(
                margin: const EdgeInsets.only(top: 13),
                height: 0.8,
                width: double.infinity,
                color: AppColors.lightGreyColor.withOpacity(0.25),
              )
          ],
        ),
      ),
    );
  }

  commonQuestionText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 25, left: 16),
      child: Text(
        "Common Questions",
        style: AppTextStyle.bold.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  commonQuestionList() {
    return SizedBox(
      height: 45,
      child: homeController.questionList.isEmpty
          ? const SizedBox()
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: homeController.questionList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10.0, top: 5, bottom: 5, left: index == 0 ? 16 : 0),
                  child: Obx(() {
                    return GestureDetector(
                      onTap: () {
                        homeController.selectIndex.value = index;
                      },
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: homeController.selectIndex.value == index ? AppColors.whiteColor : AppColors.transparentColor,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: homeController.selectIndex.value != index
                                      ? AppColors.lightGreyColor.withOpacity(0.4)
                                      : AppColors.transparentColor)),
                          child: Text(
                            homeController.questionList[index]["title"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.bold.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: homeController.selectIndex.value != index ? AppColors.greyColor : AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
    );
  }

  commonQuestionListTile() {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 70, left: 16, right: 16),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: homeController.questionList[homeController.selectIndex.value]["subQuestion"].length,
        itemBuilder: (BuildContext context, int index) {
          var item = homeController.questionList[homeController.selectIndex.value]["subQuestion"][index];
          bool isLast = (homeController.questionList[homeController.selectIndex.value]["subQuestion"].length - 1 == index);
          return commonTiles(
              name: item['subTitle'],
              isLastIndex: isLast,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                homeController.commonQuestionCtr.value.clear();
                homeController.messageCtr.value.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommonQuestionScreen(
                              title: item['subTitle'],
                              questionList: item['question'],
                            )));
              });
        },
      );
    });
  }

  sendMessage() {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        border: Border(
          top: BorderSide(width: 0.5, color: AppColors.greyColor.withOpacity(0.5)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              CommonBottomSheet().addButtonBottomSheet(navigateBy: "home");
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ImageToTextApp()));
            },
            child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(3),
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.add,
                  size: 20,
                  color: AppColors.whiteColor,
                )),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 100.0,
              ),
              child: AppTextField(
                controller: homeController.messageCtr.value,
                hint: 'Ask me anything...',
                onChanged: (v) {
                  homeController.messageCtr.refresh();
                },
                margin: const EdgeInsets.only(left: 10, right: 10),
              ),
            ),
          ),
          Obx(() {
            return GestureDetector(
                onTap: homeController.messageCtr.value.text.isEmpty
                    ? () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AudioSearchScreen(navigateBy: "home")));
                      }
                    : () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      messageText: homeController.messageCtr.value.text,
                                    ))).whenComplete(() {
                          homeController.messageCtr.value.clear();
                          homeController.messageCtr.refresh();
                        });
                      },
                child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    // padding: const EdgeInsets.all(3),
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      homeController.messageCtr.value.text.isEmpty ? AppAssets.microphoneIcon1 : AppAssets.sendIcon,
                      height: 20,
                      width: 20,
                      color: AppColors.blackColor,
                    )));
          })
        ],
      ),
    );
  }

}
