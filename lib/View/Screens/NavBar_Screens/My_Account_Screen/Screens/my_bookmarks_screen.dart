import 'dart:developer';

import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_images.dart';
import '../../../../../Logic/controllers/My_Account_Controllers/my_account_controller.dart';
import '../../../../Widgets/custom_circle_progress.dart';

class MyBookmarksScreen extends StatelessWidget {
  MyBookmarksScreen({Key? key}) : super(key: key);
  final myAccountController = Get.find<MyAccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          centerTitle: true,
          title: const Text("مفضلاتك"),
        ),
        body: Obx(() {
          if (myAccountController.isLoadingMyBookmarks.value) {
            return const CustomCircleProgress();
          } else if (myAccountController.myBookmarksList.isEmpty) {
            return const Center(
              child: Text("لايوجد مفضلات."),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: myAccountController.myBookmarksList.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.GREY_Light_COLOR,
                    ),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              imageUrl: myAccountController.myBookmarksList[index]
                                  .animalProductImage,
                              placeholder: (context, url) => Image.asset(
                                AppImages.placeholder,
                                width: 100,
                                // height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.placeholder,
                                width: 100,
                                // height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              Text(
                                "${myAccountController.myBookmarksList[index].animalProductPrice} ر.س",
                                style: const TextStyle(
                                    color: AppColors.MAIN_COLOR),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            );
          }
        }));
  }

  String getCountDownTitle(status) {
    switch (status) {
      case "PENDING":
        return "في انتظار موافقة الأدمن";
      case "SOLD":
        return "تم البيع";
      case "CANCELLED":
        return "غير نشط";
      default:
        return "";
    }
  }
}
