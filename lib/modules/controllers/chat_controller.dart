import 'package:flutter/material.dart';
import 'package:geminai/core/constants/app_colors.dart';
import 'package:geminai/core/constants/app_textstyle.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatController extends GetxController {
  static const _apiKey = 'AIzaSyDnrnQDv5vvwWPxIkAK3YBEHtvuhh-NW9Q';
  List<Content> history = <Content>[].obs;

  GenerativeModel? model;
  ChatSession? chat;
  final Rx<TextEditingController> textController = TextEditingController().obs;
  final FocusNode textFieldFocus = FocusNode();

  RxBool loading = false.obs;
  final ScrollController scrollController = ScrollController();

  onInitCall({required String messageText}) {
    history.clear();
    model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey,
    );
    chat = model!.startChat();

    ///direct send message
    if (messageText.isNotEmpty) {
      history.add(Content('user', [TextPart(messageText)]));
      sendChatMessage(messageText, history.length);
    }
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  Future<void> sendChatMessage(String message, int historyIndex) async {
    loading.value = true;
    textController.value.clear();
    textFieldFocus.unfocus();
    scrollDown();

    List<Part> parts = [];

    try {
      var response = chat!.sendMessageStream(
        Content.text(message),
      );

      // debugPrint("Respone====$response");
      await for (var item in response) {
        var text = item.text;
        if (text == null) {
          showError('No response from API.');
          return;
        } else {
          parts.add(TextPart(text));
          if ((history.length - 1) == historyIndex) {
            history.removeAt(historyIndex);
          }
          history.insert(historyIndex, Content('model', parts));
        }
      }
    } catch (e, t) {
      print(":::error E :$e");
      print(":::error T: $t");
      showError(e.toString());
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }

  void showError(String message) {
    Get.dialog(AlertDialog(
      backgroundColor: AppColors.lightBlackColor,
      title: Text(
        'Something went wrong',
        style: AppTextStyle.bold.copyWith(fontSize: 14),
      ),
      content: SingleChildScrollView(
        child: SelectableText(
          message,
          style: AppTextStyle.regular.copyWith(fontSize: 13, color: AppColors.greyColor),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK', style: AppTextStyle.bold.copyWith(fontSize: 14, color: AppColors.primaryColor)),
        )
      ],
    ));
  }
}
