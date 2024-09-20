import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geminai/modules/controllers/home_controller.dart';
import 'package:geminai/modules/controllers/image_controller.dart';
import 'package:geminai/modules/views/image_screen/generate_img_screen.dart';
import 'package:geminai/modules/widgets/custom_button.dart';
import 'package:geminai/modules/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyle.dart';
import '../../widgets/app_network_image.dart';
import '../../widgets/loading_dialog.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => ImageScreenState();
}

class ImageScreenState extends State<ImageScreen> {
  final imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: Get.height,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text("Prompt",
                        style: AppTextStyle.regular.copyWith(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.primaryColor)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16),
                    child: AppTextField(
                      controller: imageController.promptController,
                      maxLines: 6,
                      contentPadding: EdgeInsets.only(top: 20, left: 15, right: 10),
                      hint: 'Type a prompt...',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child:
                        Text("Style", style: AppTextStyle.regular.copyWith(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.primaryColor)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 180.0,
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemCount: imageController.styleList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(left: index == 0 || index == 1 ? 16 : 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      imageController.selectStyleIndex.value = index;
                                    },
                                    child: Container(
                                        width: Get.size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: AppColors.whiteColor.withOpacity(0.1),
                                          border: Border.all(
                                              color: imageController.selectStyleIndex.value == index
                                                  ? AppColors.primaryColor
                                                  : AppColors.transparentColor,
                                              width: 2),
                                          /*image: DecorationImage(
                                                                  image: NetworkImage(storyController
                                                                      .storyCategoriesList[index]["image"]
                                                                      .toString()),
                                                                  fit: BoxFit.cover)*/
                                        ),
                                        child: index == 0
                                            ? Icon(
                                                Icons.not_interested_rounded,
                                                size: 45,
                                                color: AppColors.lightGreyColor.withOpacity(0.7),
                                              )
                                            : ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: AppNetworkImage(
                                                  image: imageController.styleList[index]["image"].toString(),
                                                  isWebImage: true,
                                                  width: 300,
                                                  height: 300,
                                                ))),
                                  );
                                }),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(() {
                                      return Text(
                                        index == 0 ? "No Style" : imageController.styleList[index]["title"].toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.medium.copyWith(
                                            fontSize: 11,
                                            color: imageController.selectStyleIndex.value == index ? AppColors.primaryColor : AppColors.whiteColor),
                                      );
                                    }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.count(2, index == 0 || index == 1 ? 2 : 1.65),
                    ),
                  ),
                  // Expanded(
                  //   child: GridView.builder(
                  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount: 4, mainAxisSpacing: 12.0, crossAxisSpacing: 8.0, mainAxisExtent: 95),
                  //       shrinkWrap: true,
                  //       padding: const EdgeInsets.only(bottom: 20),
                  //       itemCount: imageController.styleList.length,
                  //       itemBuilder: (context, index) {
                  //         return Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Expanded(
                  //               child: Obx(() {
                  //                 return InkWell(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   onTap: () {
                  //                     imageController.selectStyleIndex.value = index;
                  //                   },
                  //                   child: Container(
                  //                       width: Get.size.width,
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: AppColors.whiteColor.withOpacity(0.1),
                  //                         border: Border.all(
                  //                             color: imageController.selectStyleIndex.value == index ? AppColors.primaryColor : AppColors.transparentColor,
                  //                             width: 2),
                  //                         /*image: DecorationImage(
                  //                                               image: NetworkImage(storyController
                  //                                                   .storyCategoriesList[index]["image"]
                  //                                                   .toString()),
                  //                                               fit: BoxFit.cover)*/
                  //                       ),
                  //                       child: index == 0
                  //                           ? Icon(
                  //                               Icons.not_interested_rounded,
                  //                               size: 45,
                  //                               color: AppColors.lightGreyColor.withOpacity(0.7),
                  //                             )
                  //                           : ClipRRect(
                  //                               borderRadius: BorderRadius.circular(6),
                  //                               child: AppNetworkImage(
                  //                                 image: imageController.styleList[index]["image"].toString(),
                  //                                 isWebImage: true,
                  //                               ))
                  //                       // ClipRRect(
                  //                       //         borderRadius: BorderRadius.circular(6),
                  //                       //         child: Image(
                  //                       //           image:  NetworkImage(
                  //                       //               imageController.styleList[index]["image"].toString()
                  //                       //           ),
                  //                       //           fit: BoxFit.cover,
                  //                       //           errorBuilder: (context, error, stackTrace) {
                  //                       //             return Padding(
                  //                       //               padding: const EdgeInsets.all(8.0),
                  //                       //               child: Image.asset(AppAssets.logo),
                  //                       //             );
                  //                       //           },
                  //                       //           loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  //                       //             if (loadingProgress == null) {
                  //                       //               return child;
                  //                       //             }
                  //                       //             return Center(
                  //                       //               child: CircularProgressIndicator(
                  //                       //                 strokeWidth: 2.0,
                  //                       //                 color: AppColors.primaryColor.withOpacity(0.7),
                  //                       //                 value: loadingProgress.expectedTotalBytes != null
                  //                       //                     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  //                       //                     : null,
                  //                       //               ),
                  //                       //             );
                  //                       //           },
                  //                       //         ),
                  //                       //       ),
                  //                       ),
                  //                 );
                  //               }),
                  //             ),
                  //             const SizedBox(height: 5),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 5),
                  //               child: Row(
                  //                 children: [
                  //                   Expanded(
                  //                     child: Obx(() {
                  //                       return Text(
                  //                         index == 0 ? "No Style" : imageController.styleList[index]["title"].toString(),
                  //                         overflow: TextOverflow.ellipsis,
                  //                         maxLines: 1,
                  //                         textAlign: TextAlign.center,
                  //                         style: AppTextStyle.medium.copyWith(
                  //                             fontSize: 11,
                  //                             color: imageController.selectStyleIndex.value == index ? AppColors.primaryColor : AppColors.whiteColor),
                  //                       );
                  //                     }),
                  //                   ),
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         );
                  //       }),
                  // )
                ],
              ),
            ),
          ),
          generateButton()
        ],
      ),
    );
  }

  generateButton() {
    return buttonView(
        onPressed: () async {
          if (imageController.promptController.text.isNotEmpty) {
            String myPrompt = imageController.selectStyleIndex.value == 0
                ? imageController.promptController.text
                : '${imageController.promptController.text} using ${imageController.styleList[imageController.selectStyleIndex.value]["title"]} style.';

            showLoadingDialog();
            OpenAIImageModel image = await OpenAI.instance.image.create(
              prompt: myPrompt,
              n: 1,
              size: OpenAIImageSize.size1024,
              responseFormat: OpenAIImageResponseFormat.url,
            );
            hideLoadingDialog();
            if (image.data.isNotEmpty) {
              print("jjjjjjjjjj::");
              print(image.data.first.url);
              Navigator.push(
                  this.context,
                  MaterialPageRoute(
                      builder: (context) => GenerateImgScreen(
                            title: myPrompt,
                            url: image.data.first.url,
                          )));
            }

            imageController.promptController.clear();
          }
        },
        textColor: AppColors.greyColor,
        leftMargin: 20,
        rightMargin: 20,
        borderRadius: 10,
        title: "Generate",
        backGroundColor: AppColors.lightBlackColor);
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? hint;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? errorBorder;
  final int maxLines;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? contentPadding;
  final bool autofocus;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const AppTextField(
      {super.key,
      this.controller,
      this.keyboardType = TextInputType.text,
      @required this.hint,
      this.inputFormatters,
      this.validator,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
      this.enableInteractiveSelection = true,
      this.enabledBorder,
      this.focusedBorder,
      this.focusedErrorBorder,
      this.errorBorder,
      this.maxLines = 1,
      this.margin = const EdgeInsets.only(top: 0),
      this.autofocus = false,
      this.fillColor,
      this.prefixIcon,
      this.suffixIcon,
      this.onEditingComplete,
      this.focusNode,
      this.onChanged,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        onChanged: onChanged,
        autofocus: autofocus,
        focusNode: focusNode,
        enableInteractiveSelection: enableInteractiveSelection,
        onTap: onTap,
        obscureText: obscureText,
        onEditingComplete: onEditingComplete,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        style: AppTextStyle.regular.copyWith(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 45,
            minHeight: 45,
          ),
          suffixIcon: suffixIcon,
          hintText: hint!,
          hintStyle: AppTextStyle.regular.copyWith(fontSize: 14, color: AppColors.greyColor, fontWeight: FontWeight.w500),
          filled: true,
          fillColor: fillColor ?? AppColors.lightBlackColor,
          contentPadding: contentPadding ?? const EdgeInsets.only(left: 15),
          enabledBorder: enabledBorder ?? appOutlineInputBorder(borderRadius: 17),
          focusedBorder: focusedBorder ?? appOutlineInputBorder(borderRadius: 17),
          errorBorder: errorBorder ?? appOutlineInputBorder(color: AppColors.redColor, borderRadius: 17),
          focusedErrorBorder: focusedErrorBorder ?? appOutlineInputBorder(color: AppColors.redColor, borderRadius: 17),
          errorMaxLines: 2,
          errorStyle: const TextStyle(
            fontSize: 13,
            color: AppColors.redColor,
            fontWeight: FontWeight.w500,
          ),
          //   border: appOutlineInputBorder(),
        ),
      ),
    );
  }

  static OutlineInputBorder appOutlineInputBorder({Color? color, double? borderRadius}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 30),
        borderSide: BorderSide(color: color ?? AppColors.primaryColor.withOpacity(0.2), width: 1),
      );
}
