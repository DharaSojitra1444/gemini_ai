import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geminai/modules/widgets/app_network_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyle.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/image_controller.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  final homeController = Get.put(HomeController());
  final imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.blackColor,
          body: Column(
            children: [
              Container(
                decoration:
                    BoxDecoration(color: Colors.white.withOpacity(0.0), border: Border(bottom: BorderSide(color: AppColors.greyColor, width: 0.25))),
                child: TabBar(
                  overlayColor: MaterialStateProperty.all(Colors.black),
                  indicatorColor: AppColors.primaryColor,
                  unselectedLabelColor: AppColors.greyColor,
                  labelColor: AppColors.whiteColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1.3, color: AppColors.primaryColor), // Adjust the width to change the indicator height
                  ),
                  dividerColor: AppColors.greyColor,
                  // Set indicator to an empty BoxDecoration to remove it
                  tabs: const [
                    Tab(text: 'Chat'),
                    Tab(text: 'Image'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    chatHistoryView(),
                    imageHistoryView(),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  chatHistoryView() {
    return homeController.historyList.isEmpty
        ? const SizedBox()
        : ListView.builder(
            padding: const EdgeInsets.only(top: 15, bottom: 30),
            itemCount: homeController.historyList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 12, top: 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightBlackColor,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      //  border: Border.all(color: const Color(0xff5E5E5E))),
                      border: Border.all(color: AppColors.greyColor.withOpacity(0.1))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          homeController.historyList[index]["history"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.semiBold.copyWith(
                            fontSize: 13.6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0, top: 2),
                          child: Text(
                            homeController.historyList[index]["dec"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.regular.copyWith(fontSize: 11, color: AppColors.whiteColor.withOpacity(0.3)
                                // color: AppColors.greyColor.withOpacity(0.7)

                                // color: exploreProvider.tapIndex == index ? Colors.white : Colors.black,
                                ),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.appLogoImg,
                              height: 22,
                              width: 22,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                DateFormat('MMM dd, yyyy HH:mm').format(homeController.historyList[index]["date"]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.bold.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                bottomSheet();
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2, bottom: 2),
                                  child: Icon(
                                    CupertinoIcons.ellipsis,
                                    color: AppColors.greyColor.withOpacity(0.5),
                                    size: 20,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
  }

  // imageHistoryView() {
  //   return MasonryGridView.count(
  //       itemCount: imageController.styleList.length,
  //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 10,
  //       mainAxisSpacing: 10,
  //       itemBuilder: (context, index) {
  //         return index == 0
  //             ? ClipRRect(
  //                 borderRadius: BorderRadius.circular(6),
  //                 child: const AppNetworkImage(
  //                  // image: 'https://miro.medium.com/v2/resize:fit:1400/1*YMJDp-kqus7i-ktWtksNjg.jpeg',
  //                   image: 'https://wallpapercave.com/wp/bYSkrmh.jpg',
  //                   isWebImage: true,
  //                 ))
  //             : ClipRRect(
  //                 borderRadius: BorderRadius.circular(6),
  //                 child: Container(
  //                   color: AppColors.lightBlackColor,
  //                   child: AppNetworkImage(
  //                     image: imageController.styleList[index]["image"].toString(),
  //                     isWebImage: true,
  //
  //                   ),
  //                 ));
  //       });
  // }
  imageHistoryView() {
    return StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.only(top: 15),
        itemCount: imageController.styleList.length,
        itemBuilder: (context, index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: AppColors.whiteColor.withOpacity(0.07),
                child: AppNetworkImage(
                  image: index == 0 ? 'https://wallpapercave.com/wp/bYSkrmh.jpg' : imageController.styleList[index]["image"].toString(),
                  isWebImage: true,
                ),
              ));
        },
        staggeredTileBuilder: (index) {
          // return StaggeredTile.count(1, index.isEven ? 1.45 : 1.55);
          return StaggeredTile.count(1, index.isEven ? 1.25 : 1.1);
        });
  }

  bottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: AppColors.lightBlackColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: Get.context!,
        builder: (context) {
          return SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.greyColor,
                      ),
                      width: 60,
                      height: 2.2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: Row(
                          children: [
                            Image.asset(AppAssets.editIcon, height: 16, color: AppColors.whiteColor),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Rename",
                              style: AppTextStyle.regular.copyWith(fontSize: 14, color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 0.8,
                      width: double.infinity,
                      color: AppColors.lightGreyColor.withOpacity(0.2),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              AppAssets.deleteIcon,
                              height: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Delete",
                              style: AppTextStyle.regular.copyWith(fontSize: 14, color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 0.8,
                      width: double.infinity,
                      color: AppColors.lightGreyColor.withOpacity(0.2),
                    ),
                  ],
                )),
          );
        });
  }
}
