import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyle.dart';
import '../../../core/utils/common_bottomsheet.dart';
import '../../controllers/chat_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../home_screen/audio_search_screen.dart';
import 'message_tile.dart';

class ChatScreen extends StatefulWidget {
  final String? messageText;

  const ChatScreen({super.key, this.messageText});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    chatController.onInitCall(messageText: widget.messageText!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppColors.blackColor,
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
        titleSpacing: 0,
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
            Text("New Chat", style: AppTextStyle.regular.copyWith(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.whiteColor)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              debugPrint("---->hello");
            },
            child: const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 12, top: 5, bottom: 5),
                child: Icon(
                  CupertinoIcons.ellipsis,
                  color: AppColors.whiteColor,
                  size: 20,
                )),
          )
        ],
      ),
      body: Obx(() {
        return SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView.separated(
                padding: const EdgeInsets.fromLTRB(10, 10, 15, 90),
                itemCount: chatController.history.reversed.length,
                controller: chatController.scrollController,
                reverse: true,
                itemBuilder: (context, index) {
                  var content = chatController.history.reversed.toList()[index];
                  var text = content.parts.whereType<TextPart>().map<String>((e) => e.text).join('');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MessageTile(
                        sendByMe: content.role == 'user',
                        message: text,
                      ),
                      SizedBox(
                          height: index == 0
                              ? chatController.loading.value == true
                                  ? 10
                                  : 0
                              : 0),
                      index == 0
                          ? chatController.loading.value == true
                              ? Row(
                                  children: [
                                    Lottie.asset(AppAssets.infinityLoader, height: 45),
                                    Expanded(
                                      child: Shimmer.fromColors(
                                          baseColor: AppColors.primaryColor.withOpacity(0.5),
                                          highlightColor: const Color(0xff66BAD0).withOpacity(0.8),
                                          // baseColor: const Color(0xff7669EC).withOpacity(0.25),
                                          //highlightColor: const Color(0xff66BAD0).withOpacity(0.8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 5,
                                                width: size.width / 1.35,
                                                color: AppColors.blackColor,
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Container(
                                                height: 5,
                                                width: size.width / 2,
                                                color: AppColors.blackColor,
                                              )
                                            ],
                                          )),
                                    ),
                                  ],
                                )
                              : const SizedBox()
                          : const SizedBox(),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              ),
              sendMessage(),
            ],
          ),
        );
      }),
    );
  }

  sendMessage() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
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
              onTap: () {
                CommonBottomSheet().addButtonBottomSheet(navigateBy: "chat");
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
                  controller: chatController.textController.value,
                  hint: 'Ask me anything...',
                  autofocus: true,
                  onChanged: (v) {
                    chatController.textController.refresh();
                  },
                  readOnly: chatController.loading.value,
                  focusNode: chatController.textFieldFocus,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                ),
              ),
            ),
            GestureDetector(
                onTap: chatController.loading.value
                    ? null
                    : chatController.textController.value.text.isEmpty
                        ? () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AudioSearchScreen(navigateBy: "chat")));
                          }
                        : () {
                            if (chatController.textController.value.text.isNotEmpty) {
                              chatController.history.add(Content('user', [TextPart(chatController.textController.value.text)]));
                              chatController.sendChatMessage(chatController.textController.value.text, chatController.history.length);
                            }
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
                      chatController.textController.value.text.isEmpty ? AppAssets.microphoneIcon1 : AppAssets.sendIcon,
                      height: 20,
                      width: 20,
                      color: AppColors.blackColor,
                    )))
          ],
        ),
      ),
    );
  }

// Future<void> _sendChatMessage(String message, int historyIndex) async {
//   setState(() {
//     _loading = true;
//     _textController.clear();
//     _textFieldFocus.unfocus();
//     _scrollDown();
//   });
//
//   List<Part> parts = [];
//
//   try {
//     var response = _chat.sendMessageStream(
//       Content.text(message),
//     );
//     debugPrint("Respone====$response");
//     await for (var item in response) {
//       var text = item.text;
//       debugPrint("Text====$text");
//       if (text == null) {
//         _showError('No response from API.');
//         return;
//       } else {
//         setState(() {
//           // _loading = false;
//           parts.add(TextPart(text));
//           if ((history.length - 1) == historyIndex) {
//             history.removeAt(historyIndex);
//           }
//           history.insert(historyIndex, Content('model', parts));
//         });
//       }
//     }
//   } catch (e, t) {
//     print(e);
//     print(t);
//     _showError(e.toString());
//     setState(() {
//       _loading = false;
//     });
//   } finally {
//     setState(() {
//       _loading = false;
//     });
//   }
// }
//
// void _showError(String message) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text('Something went wrong'),
//         content: SingleChildScrollView(
//           child: SelectableText(message),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('OK'),
//           )
//         ],
//       );
//     },
//   );
// }
}
