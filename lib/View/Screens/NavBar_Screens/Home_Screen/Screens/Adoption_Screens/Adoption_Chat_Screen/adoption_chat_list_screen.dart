import 'dart:developer';

import 'package:bytrh/Utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../../../Utils/app_colors.dart';
import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Routes/routes.dart';
import '../../../../../../../Utils/app_images.dart';
import '../../../../../../Widgets/custom_circle_progress.dart';

class AdoptionChatListScreen extends StatelessWidget {
  AdoptionChatListScreen({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (adoptionController.isLoadingMyAdoptionsChatList.value) {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("المحادثات"),
            centerTitle: true,
          ),
          body: const CustomCircleProgress(),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("المحادثات"),
            centerTitle: true,
          ),
          body: adoptionController.myAdoptionsChatList.isEmpty
              ? Center(
                  child: Text("لايوجد محادثات بعد ."),
                )
              : ListView.separated(
                  itemCount: adoptionController.myAdoptionsChatList.length,
                  // itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {},
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.GREY_Light_COLOR,
                        elevation: 2,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: double.infinity,
                                  imageUrl: adoptionController
                                      .myAdoptionsChatList[index]
                                      .clientPicture,
                                  placeholder: (context, url) => Image.asset(
                                    width: 60,
                                    height: double.infinity,
                                    AppImages.user_placeholder,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    width: 60,
                                    height: double.infinity,
                                    AppImages.user_placeholder,
                                  ),
                                ),
                              ),
                              title: Text(
                                adoptionController
                                    .myAdoptionsChatList[index].clientName,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: AppColors.MAIN_COLOR,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              subtitle: Row(
                                children: [
                                  SvgPicture.asset(AppIcons.call_icon,
                                      color: AppColors.GREY_COLOR, width: 16),
                                  SizedBox(width: 5),
                                  Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text(
                                        adoptionController
                                            .myAdoptionsChatList[index]
                                            .clientPhone,
                                        style: TextStyle(
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis),
                                      ))
                                ],
                              ),
                              trailing: Stack(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(vertical: 15)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                          ),
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.SECOND_COLOR)),
                                      onPressed: () async {
                                        await adoptionController
                                            .getAdoptionChatDetails(
                                          "ADOPTER",
                                          adoptionController
                                              .myAdoptionsChatList[index]
                                              .idAdoptionChat
                                              .toString(),
                                        );
                                        Get.toNamed(Routes.adoptionChatScreen);
                                      },
                                      child: SvgPicture.asset(AppIcons.message_icon,
                                          // color: AppColors.WHITE_COLOR,
                                          width: 16),
                                    ),
                                  ),
                                  if(adoptionController
                                      .myAdoptionsChatList[index]
                                      .adopterChatSeen ==
                                      0)
                                  const CircleAvatar(
                                    radius: 8,
                                    backgroundColor: AppColors.WHITE_COLOR,
                                    child: Icon(
                                      size: 12,
                                      Icons.circle,
                                      color:  AppColors.RED_COLOR
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                ),
        );
      }
    });
  }
}
