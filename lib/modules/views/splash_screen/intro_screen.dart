// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geminai/core/constants/app_assets.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_textstyle.dart';
// import '../../widgets/custom_button.dart';
//
// class IntroScreen extends StatefulWidget {
//   const IntroScreen({super.key});
//
//   @override
//   State<IntroScreen> createState() => IntroScreenState();
// }
//
// class IntroScreenState extends State<IntroScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: slideView(),
//     );
//   }
//
//   slideView() {
//     return CarouselSlider(
//       items: [
//         sliderWidget(
//             title: "Create Personal AI Model",
//             subTitle: "Introduce yourself to AI, train your assistant and have unique model just for you!",
//             image: AppAssets.backGroundImg),
//         sliderWidget(title: "Find Your Match", subTitle: "Swipe, match, connect\nIt all starts here on BOLO", image: AppAssets.backGroundImg),
//         sliderWidget(title: "Start Dating", subTitle: "Discover romance, connection\nand adventure on BOLO", image: AppAssets.backGroundImg),
//       ],
//       options: CarouselOptions(
//           height: Get.height,
//           // enlargeCenterPage: true,
//           // autoPlay: true,
//           aspectRatio: 5,
//           autoPlayCurve: Curves.linear,
//           enableInfiniteScroll: true,
//          // autoPlayInterval: const Duration(seconds: 2),
//           //  autoPlayAnimationDuration: const Duration(milliseconds: 200),
//           viewportFraction: 1.0,
//           onPageChanged: (val, C) {
//             // setState(() {
//             //   initialVal = val;
//             // });
//           }),
//     );
//   }
//
//   sliderWidget({required String title, required String subTitle, required String image}) {
//     return Stack(
//       children: [
//         Image.asset(
//           image,
//           height: Get.height,
//           width: Get.width,
//           fit: BoxFit.fill,
//         ),
//         SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 100.0, bottom: 100),
//                     child: Image.asset(
//                       AppAssets.intro1Img,
//                       height: Get.height / 3.5,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 // Spacer(),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 15.0),
//                 //   child: GradientText(
//                 //     title,
//                 //     style: AppTextStyle.regular.copyWith(
//                 //       fontWeight: FontWeight.w600,
//                 //       fontSize: 30,
//                 //       color: AppColors.whiteColor,
//                 //     ),
//                 //     gradient: const LinearGradient(
//                 //       colors: [AppColors.secondaryPrimaryColor, AppColors.secondaryPrimaryColor],
//                 //     ),
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0, bottom: 25),
//                   child: Text(
//                     title,
//                     style: AppTextStyle.regular.copyWith(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 32,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   subTitle,
//                   style: AppTextStyle.regular.copyWith(
//                     fontSize: 15,
//                     color: AppColors.whiteColor,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 buttonView(
//                   title: "Next"
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
// class GradientText extends StatelessWidget {
//   const GradientText(
//       this.text, {
//         super.key,
//         required this.gradient,
//         this.style,
//       });
//
//   final String text;
//   final TextStyle? style;
//   final Gradient gradient;
//
//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       blendMode: BlendMode.srcIn,
//       shaderCallback: (bounds) => gradient.createShader(
//         Rect.fromLTWH(0, 0, bounds.width, bounds.height),
//       ),
//       child: Text(text, style: style),
//     );
//   }
// }