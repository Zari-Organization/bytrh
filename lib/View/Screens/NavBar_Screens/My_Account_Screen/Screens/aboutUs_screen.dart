import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Logic/controllers/My_Account_Controllers/my_account_controller.dart';
import '../../../../../Utils/app_icons.dart';
import '../../../../Widgets/auth_button.dart';
import '../../../../Widgets/titled_textField.dart';
import '../Widgets/custom_listTile.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({Key? key}) : super(key: key);
  final myAccountController = Get.find<MyAccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        title: const Text("حولنا"),
        centerTitle: true,
      ),
      body: Obx(() {
        return myAccountController.aboutUsData.value.aboutUsTitle == null
            ? const CustomCircleProgress()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("${myAccountController.aboutUsData.value.aboutUsTitle}"),
                      const SizedBox(height: 16),
                      Text("${myAccountController.aboutUsData.value.aboutUsBody}"),
                      const SizedBox(height: 16),
                      Text("تقدر تتواصل معنا",style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 16),
                      CustomListTile(
                        borderRadius: 10,
                        tileColor: AppColors.GREY_Light_COLOR,
                        icon: AppIcons.square_phone_icon,
                        iconColor: null,
                        title: "${myAccountController.aboutUsData.value.contactPhone}",
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              "tel:${myAccountController.aboutUsData.value.contactPhone}",
                            ),
                          );
                        },
                      ),
                      CustomListTile(
                        borderRadius: 10,
                        tileColor: AppColors.GREY_Light_COLOR,
                        icon: AppIcons.square_email_icon,
                        iconColor: null,
                        title: "${myAccountController.aboutUsData.value.contactEmail}",
                        onTap: () {
                          myAccountController.openEmail(myAccountController
                              .aboutUsData.value.contactEmail);
                        },
                      ),
                      CustomListTile(
                        borderRadius: 10,
                        tileColor: AppColors.GREY_Light_COLOR,
                        icon: AppIcons.square_facebook_icon,
                        iconColor: null,
                        title: "${myAccountController.aboutUsData.value.contactFacebook}",
                        onTap: () {
                          launchUrl(Uri.parse(myAccountController.aboutUsData.value.contactFacebook));
                        },
                      ),
                      CustomListTile(
                        borderRadius: 10,
                        tileColor: AppColors.GREY_Light_COLOR,
                        icon: AppIcons.square_whatsapp_icon,
                        iconColor: null,
                        title: "${myAccountController.aboutUsData.value.contactWhatsApp}",
                        onTap: ()async {
                          myAccountController.launchWhatsApp(phone: myAccountController.aboutUsData.value.contactWhatsApp, message: 'Hi');
                        },
                      ),
                      CustomListTile(
                        borderRadius: 10,
                        tileColor: AppColors.GREY_Light_COLOR,
                        icon: AppIcons.square_instagram_icon,
                        iconColor: null,
                        title: "${myAccountController.aboutUsData.value.contactInstagram}",
                        onTap: () {
                          launchUrl(Uri.parse(myAccountController.aboutUsData.value.contactInstagram));
                        },
                      ),
                      CustomListTile(
                        borderRadius: 10,
                        tileColor: AppColors.GREY_Light_COLOR,
                        icon: AppIcons.square_youtube_icon,
                        iconColor: null,
                        title: "${myAccountController.aboutUsData.value.contactYouTube}",
                        onTap: () {
                          launchUrl(Uri.parse(myAccountController.aboutUsData.value.contactYouTube));
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
