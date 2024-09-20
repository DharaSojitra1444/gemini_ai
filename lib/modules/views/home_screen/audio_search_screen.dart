import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geminai/core/constants/app_assets.dart';
import 'package:geminai/modules/controllers/chat_controller.dart';
import 'package:geminai/modules/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyle.dart';

class AudioSearchScreen extends StatefulWidget {
  final String navigateBy;

  const AudioSearchScreen({super.key, required this.navigateBy});

  @override
  State<AudioSearchScreen> createState() => _AudioSearchScreenState();
}

class _AudioSearchScreenState extends State<AudioSearchScreen> {
  final homeController = Get.put(HomeController());
  final chatController = Get.put(ChatController());
  Timer? timer;

  @override
  void initState() {
    startSpeechToText();

    super.initState();
  }

  Future<void> startSpeechToText() async {
    await homeController.speechToText.value.stop();
    homeController.speechEnabled.value = await homeController.speechToText.value.initialize();
    homeController.speechEnabled.refresh();
    homeController.sendChatController.value.clear();
    homeController.sendChatController.refresh();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      homeController.speechToText.refresh();
      homeController.sendChatController.refresh();
      if (homeController.speechToText.value.lastStatus == "listening" ||
          homeController.speechToText.value.lastStatus == "notListening" ||
          homeController.speechToText.value.lastStatus != "done" && homeController.sendChatController.value.text.isEmpty) {
        debugPrint("---------3333333----------");
      } else {
        t.cancel();
        debugPrint("-------------------");
      }
    });
    // Timer(Duration(seconds: 1), () {
    //
    //   setState(() {
    //     homeController.speechToText.refresh();
    //     homeController.sendChatController.refresh();
    //     debugPrint("-------------------");
    //   });
    // });

    await homeController.speechToText.value.listen(
      listenFor: const Duration(minutes: 10),
      cancelOnError: true,
      onResult: (v) async {
        homeController.sendChatController.value.text = v.recognizedWords;
        homeController.sendChatController.refresh();
        homeController.speechToText.refresh();
        debugPrint("-------n------${homeController.speechToText.value.lastStatus}");
        if (homeController.speechToText.value.lastStatus == "notListening") {
          debugPrint("-------ppppp------");
          // Get.back();
        } else if (homeController.speechToText.value.lastStatus == "done") {
          debugPrint("-------done------");
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    homeController.speechToText.value.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return homeController.speechToText.value.lastStatus == "listening" ||
                              homeController.speechToText.value.lastStatus == "notListening"
                          ? Text("Listening...", style: AppTextStyle.medium.copyWith(fontSize: 20, color: AppColors.whiteColor))
                          : homeController.speechToText.value.lastStatus == "done" && homeController.sendChatController.value.text.isNotEmpty
                              ? Text(
                                  homeController.sendChatController.value.text,
                                  style: AppTextStyle.medium.copyWith(fontSize: 16, color: AppColors.whiteColor),
                                )
                              : Text("Didn't hear that. Try again.", style: AppTextStyle.medium.copyWith(fontSize: 18, color: AppColors.whiteColor));
                    }),
                    /*
                    Obx(
                          () {
                        return Text(
                          "Tap to stop ${homeController.speechToText.value.lastStatus}",
                          style: AppTextStyle.semiBold.copyWith(color: AppColors.whiteColor, fontSize: 16),
                        );
                      },

                    ),
                    Obx(
                          () {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            homeController.sendChatController.value.text,
                            style: AppTextStyle.regular.copyWith(color: AppColors.whiteColor, fontSize: 14),
                          ),
                        );
                      },
                    ),*/
                  ],
                ),
              ),
            ),
            Obx(() {
              return Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      homeController.speechToText.value.lastStatus == "listening" ||
                              homeController.speechToText.value.lastStatus == "notListening" ||
                              homeController.speechToText.value.lastStatus != "done" && homeController.sendChatController.value.text.isEmpty
                          ? Lottie.asset(
                              'assets/lotties/audio_wave.json',
                              height: Get.size.height / 3,
                            )
                          : SizedBox(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  overlayColor: MaterialStateProperty.all(Colors.black),
                                  borderRadius: BorderRadius.circular(150),
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppColors.redColor.withOpacity(0.2),
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: AppColors.redColor,
                                      ))),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: homeController.speechToText.value.lastStatus == "listening" ||
                                            homeController.speechToText.value.lastStatus == "notListening" ||
                                            homeController.speechToText.value.lastStatus != "done" &&
                                                homeController.sendChatController.value.text.isEmpty
                                        ? () {}
                                        : () {
                                            startSpeechToText();
                                          },
                                    child: Image(
                                      image: const AssetImage(AppAssets.microphoneIcon),
                                      color: AppColors.primaryColor,
                                      height: Get.size.height / 12,
                                    ),
                                  ),
                                ],
                              ),
                              homeController.speechToText.value.lastStatus == "done" && homeController.sendChatController.value.text.isNotEmpty
                                  ? InkWell(
                                      borderRadius: BorderRadius.circular(150),
                                      overlayColor: MaterialStateProperty.all(Colors.black),
                                      onTap: () {

                                        if (widget.navigateBy == "home") {
                                          homeController.messageCtr.value.text = homeController.sendChatController.value.text;
                                          homeController.messageCtr.refresh();
                                        } else if (widget.navigateBy == "question") {
                                          homeController.commonQuestionCtr.value.text = homeController.sendChatController.value.text;
                                          homeController.commonQuestionCtr.refresh();
                                        } else if (widget.navigateBy == "chat") {
                                          chatController.textController.value.text = homeController.sendChatController.value.text;
                                          chatController.textController.refresh();
                                        }
                                        Get.back();
                                      },
                                      child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: AppColors.greenColor.withOpacity(0.2),
                                          child: const Icon(
                                            Icons.check,
                                            size: 20,
                                            color: AppColors.greenColor,
                                          )))
                                  : const CircleAvatar(radius: 20, backgroundColor: AppColors.transparentColor),
                            ],
                          ),
                          SizedBox(
                            height: homeController.speechToText.value.lastStatus == "listening" ||
                                    homeController.speechToText.value.lastStatus == "notListening" ||
                                    homeController.speechToText.value.lastStatus != "done" && homeController.sendChatController.value.text.isEmpty
                                ? 0
                                : 18,
                          ),
                          homeController.speechToText.value.lastStatus == "listening" ||
                                  homeController.speechToText.value.lastStatus == "notListening" ||
                                  homeController.speechToText.value.lastStatus != "done" && homeController.sendChatController.value.text.isEmpty
                              ? const SizedBox()
                              : Text("Tap microphone to try again",
                                  style: AppTextStyle.medium.copyWith(fontSize: 14, color: AppColors.whiteColor.withOpacity(0.7))),
                        ],
                      ),
                      SizedBox(
                        height: homeController.speechToText.value.lastStatus == "listening" ||
                                homeController.speechToText.value.lastStatus == "notListening" ||
                                homeController.speechToText.value.lastStatus != "done" && homeController.sendChatController.value.text.isEmpty
                            ? 0
                            : Get.size.height / 3.5,
                      )
                    ],
                  ));
            }),
          ],
        ),
      ),
    );
  }
}
