import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_textstyle.dart';

//
// class MessageTile extends StatelessWidget {
//   const MessageTile({super.key, required this.sendByMe, required this.message});
//
//   final bool sendByMe;
//   final String message;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         sendByMe
//             ? CircleAvatar(
//                 backgroundColor: AppColors.greyColor.withOpacity(0.7),
//                 radius: 16,
//                 child: Text(
//                   "A",
//                   style: AppTextStyle.bold.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 16),
//                 ),
//               )
//             : SizedBox(
//                 width: 34,
//                 child: Image.asset(
//                   AppAssets.logo1,
//                   height: 31,
//                 )),
//         /*Lottie.asset(AppAssets.infinityLoader,height: 40),*/
//         const SizedBox(
//           width: 8,
//         ),
//         Column(
//           crossAxisAlignment: /*  sendByMe ? CrossAxisAlignment.end : */ CrossAxisAlignment.start,
//           children: [
//             // Text(
//             //   sendByMe ? 'You' : 'AI Model',
//             //   style: const TextStyle(fontSize: 11.5, color: Colors.grey),
//             // ),
//             // const SizedBox(
//             //   height: 5,
//             // ),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: size.width / 1.28,
//                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//                   decoration: BoxDecoration(
//                       color: sendByMe ? Colors.grey.withOpacity(0.1) : Colors.white.withOpacity(0.92),
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(5),
//                         topLeft: Radius.circular(12),
//                         topRight: Radius.circular(12),
//                         bottomRight: Radius.circular(12),
//                       )),
//                   child: MarkdownBody(
//                       selectable: true,
//                       data: message,
//                       extensionSet: md.ExtensionSet(
//                         md.ExtensionSet.gitHubFlavored.blockSyntaxes,
//                         <md.InlineSyntax>[md.EmojiSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
//                       ),
//                       onTapLink: (text, href, title) async {
//                         await _launchUrl(text);
//                       },
//                       styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
//                           textTheme: TextTheme(
//                             //  bodyMedium: GoogleFonts.lexend(
//                               bodyMedium: AppTextStyle.regular.copyWith(
//                         fontSize: 13,
//                         color: sendByMe ? Colors.white.withOpacity(0.2) : Colors.black,
//                       ))))),
//                 ),
//                 // if (!sendByMe) ...[
//                 //   // const SizedBox(
//                 //   //   width: 8,
//                 //   // ),
//                 //   IconButton(
//                 //       onPressed: () async {
//                 //         await Clipboard.setData(ClipboardData(text: message, ));
//                 //       },
//                 //       icon: Icon(Icons.file_copy_outlined, color: Colors.grey.shade300, size: 18,)),
//                 //   // Icon(
//                 //   //   Icons.file_copy_outlined,
//                 //   //   color: Colors.grey.shade300,
//                 //   //   size: 20,
//                 //   // )
//                 // ]
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Future<void> _launchUrl(String url) async {
//     if (!await launchUrl(Uri.parse(url))) {
//       throw Exception('Could not launch $url');
//     }
//   }
// }

class MessageTile extends StatelessWidget {
  const MessageTile({super.key, required this.sendByMe, required this.message});

  final bool sendByMe;
  final String message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: !sendByMe ? 0 : 30),
     // padding: EdgeInsets.only(left: !sendByMe ? 0 : 70, right: !sendByMe ? 40 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          sendByMe
              ? SizedBox()
              // CircleAvatar(
              //         backgroundColor: AppColors.greyColor.withOpacity(0.7),
              //         radius: 16,
              //         child: Text(
              //           "A",
              //           style: AppTextStyle.bold.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 16),
              //         ),
              //       )
              : Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    AppAssets.appLogoImg,
                    height: 25,
                    color: AppColors.primaryColor,
                  )),
          /*Lottie.asset(AppAssets.infinityLoader,height: 40),*/
          const SizedBox(
            width: 4,
          ),
          Flexible(
            child: Container(
              // width: size.width / 1.28,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: sendByMe ? AppColors.primaryColor.withOpacity(0.9) : AppColors.lightBlackColor,
                  borderRadius: sendByMe
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),

                          // borderRadius: const BorderRadius.only(
                          //   bottomLeft: Radius.circular(5),
                          //   topLeft: Radius.circular(12),
                          //   topRight: Radius.circular(12),
                          //   bottomRight: Radius.circular(12),
                        )),
              child: MarkdownBody(

                  selectable: true,
                  data: message,
                  extensionSet: md.ExtensionSet(
                    md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                    <md.InlineSyntax>[md.EmojiSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
                  ),
                  onTapLink: (text, href, title) async {
                    await _launchUrl(text);
                  },
                  styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                      textTheme: TextTheme(
                          //  bodyMedium: GoogleFonts.lexend(
                          bodyMedium: AppTextStyle.regular.copyWith(
                    fontSize: 13,
                    color: sendByMe ? AppColors.blackColor : AppColors.lightGreyColor,
                  ))))),
            ),
          ),
          // Column(
          //   crossAxisAlignment: /*  sendByMe ? CrossAxisAlignment.end : */ CrossAxisAlignment.start,
          //   children: [
          //     // Text(
          //     //   sendByMe ? 'You' : 'AI Model',
          //     //   style: const TextStyle(fontSize: 11.5, color: Colors.grey),
          //     // ),
          //     // const SizedBox(
          //     //   height: 5,
          //     // ),
          //     Row(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Container(
          //           // width: size.width / 1.28,
          //           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          //           decoration: BoxDecoration(
          //               color: sendByMe ? AppColors.primaryColor : AppColors.lightBlackColor,
          //               borderRadius: sendByMe
          //                   ? const BorderRadius.only(
          //                       topLeft: Radius.circular(12),
          //                       topRight: Radius.circular(12),
          //                       bottomLeft: Radius.circular(12),
          //                     )
          //                   : const BorderRadius.only(
          //                       topLeft: Radius.circular(12),
          //                       topRight: Radius.circular(12),
          //                       bottomRight: Radius.circular(12),
          //
          //                       // borderRadius: const BorderRadius.only(
          //                       //   bottomLeft: Radius.circular(5),
          //                       //   topLeft: Radius.circular(12),
          //                       //   topRight: Radius.circular(12),
          //                       //   bottomRight: Radius.circular(12),
          //                     )),
          //           child: MarkdownBody(
          //               selectable: true,
          //               data: message,
          //               extensionSet: md.ExtensionSet(
          //                 md.ExtensionSet.gitHubFlavored.blockSyntaxes,
          //                 <md.InlineSyntax>[md.EmojiSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
          //               ),
          //               onTapLink: (text, href, title) async {
          //                 await _launchUrl(text);
          //               },
          //               styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
          //                   textTheme: TextTheme(
          //                       //  bodyMedium: GoogleFonts.lexend(
          //                       bodyMedium: AppTextStyle.regular.copyWith(
          //                 fontSize: 13,
          //                 color: sendByMe ? AppColors.blackColor : AppColors.whiteColor,
          //               ))))),
          //         ),
          //         // if (!sendByMe) ...[
          //         //   // const SizedBox(
          //         //   //   width: 8,
          //         //   // ),
          //         //   IconButton(
          //         //       onPressed: () async {
          //         //         await Clipboard.setData(ClipboardData(text: message, ));
          //         //       },
          //         //       icon: Icon(Icons.file_copy_outlined, color: Colors.grey.shade300, size: 18,)),
          //         //   // Icon(
          //         //   //   Icons.file_copy_outlined,
          //         //   //   color: Colors.grey.shade300,
          //         //   //   size: 20,
          //         //   // )
          //         // ]
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
