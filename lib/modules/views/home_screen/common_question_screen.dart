import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geminai/modules/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyle.dart';
import '../../../core/utils/common_bottomsheet.dart';
import '../../widgets/custom_textfield.dart';
import '../chat_screen/chat_screen.dart';
import 'audio_search_screen.dart';
import 'home_screen.dart';

class CommonQuestionScreen extends StatefulWidget {
  String? title;
  List<String>? questionList;

  CommonQuestionScreen({super.key, this.questionList, this.title});

  @override
  State<CommonQuestionScreen> createState() => CommonQuestionScreenState();
}

class CommonQuestionScreenState extends State<CommonQuestionScreen> {
  FocusNode _focusNode = FocusNode();
  final homeController = Get.put(HomeController());

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
        title: Text(widget.title!, style: AppTextStyle.regular.copyWith(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.whiteColor)),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 80),
            itemCount: widget.questionList!.length,
            itemBuilder: (BuildContext context, int index) {
              var item = widget.questionList![index];
              bool isLast = (index == widget.questionList!.length - 1);
              return commonTiles(
                  name: item,
                  isLastIndex: isLast,
                  onTap: () {
                    homeController.commonQuestionCtr.value.text = item;
                    FocusScope.of(context).requestFocus(_focusNode);
                    homeController.commonQuestionCtr.refresh();
                    // widget.questionList![index]
                  });
            },
          ),
          sendMessage()
        ],
      ),
    );
  }

  sendMessage() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          border: Border(
            top: BorderSide(width: 0.5, color: AppColors.greyColor.withOpacity(0.5)),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.greyColor.withOpacity(0.5), // Shadow color
          //     spreadRadius: 3, // Spread radius
          //     blurRadius: 2, // Blur radius
          //     offset: const Offset(0, 3), // Offset in x and y direction
          //   ),
          // ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                CommonBottomSheet().addButtonBottomSheet(navigateBy: "question");
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
                  onChanged: (v) {
                    homeController.commonQuestionCtr.refresh();
                  },
                  controller: homeController.commonQuestionCtr.value,
                  focusNode: _focusNode,
                  hint: 'Ask me anything...',
                  margin: const EdgeInsets.only(left: 10, right: 10),
                ),
              ),
            ),
            GestureDetector(
              onTap: homeController.commonQuestionCtr.value.text.isEmpty
                  ? () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AudioSearchScreen(navigateBy: "question")));
                    }
                  : () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    messageText: homeController.commonQuestionCtr.value.text,
                                  ))).whenComplete(() {
                        homeController.commonQuestionCtr.value.clear();
                        homeController.commonQuestionCtr.refresh();
                      });
                    },
              child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    homeController.commonQuestionCtr.value.text.isEmpty ? AppAssets.microphoneIcon1 : AppAssets.sendIcon,
                    height: 20,
                    width: 20,
                    color: AppColors.blackColor,
                  )),
            )
          ],
        ),
      );
    });
  }

  commonTiles({String? name, bool? isLastIndex, GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 5),
                  child: Text(
                    name!,
                    style: AppTextStyle.regular.copyWith(
                      fontSize: 14,
                      height: 1.6,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
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
              margin: const EdgeInsets.only(top: 12),
              height: 0.8,
              width: double.infinity,
              color: AppColors.lightGreyColor.withOpacity(0.25),
            )
        ],
      ),
    );
  }
}
