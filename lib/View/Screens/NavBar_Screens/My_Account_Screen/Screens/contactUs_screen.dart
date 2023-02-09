import 'package:bytrh/Utils/app_colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Logic/controllers/My_Account_Controllers/my_account_controller.dart';
import '../../../../../Utils/app_icons.dart';
import '../../../../Widgets/auth_button.dart';
import '../../../../Widgets/custom_circle_progress.dart';
import '../../../../Widgets/titled_textField.dart';
import '../Widgets/custom_listTile.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);
  final myAccountController = Get.find<MyAccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        title: const Text("تواصل معنا"),
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
                      CustomListTile(
                        borderRadius: 10,
                        tileColor: AppColors.GREY_Light_COLOR,
                        icon: AppIcons.square_phone_icon,
                        iconColor: null,
                        title:
                            "${myAccountController.aboutUsData.value.contactPhone}",
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
                        title:
                            "${myAccountController.aboutUsData.value.contactEmail}",
                        onTap: () {
                          myAccountController.openEmail(myAccountController
                              .aboutUsData.value.contactEmail);
                        },
                      ),
                      CustomListTile(
                        borderRadius: 10,
                        tileColor: AppColors.GREY_Light_COLOR,
                        icon: AppIcons.square_message_icon,
                        iconColor: null,
                        title: "شات الدعم الفني",
                        onTap: () {},
                      ),
                      CustomListTile(
                        borderRadius: 10,
                        tileColor: AppColors.GREY_Light_COLOR,
                        icon: AppIcons.square_location_icon,
                        iconColor: null,
                        title:
                            "${myAccountController.aboutUsData.value.contactLocation}",
                        onTap: () {
                          myAccountController.openMap(
                            double.parse(myAccountController
                                .aboutUsData.value.contactLocationLat),
                            double.parse(myAccountController
                                .aboutUsData.value.contactLocationLong),
                            context,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text("أو تواصل معنا من خلال إرسال رسالة.."),
                      const SizedBox(height: 16),
                      TitledTextField(
                        title: "الأسم",
                        controller:
                            myAccountController.contactUserNameController.value,
                        fillColor: AppColors.GREY_Light_COLOR,
                      ),
                      TitledTextField(
                        title: "البريد الإلكتروني",
                        controller:
                            myAccountController.contactEmailController.value,
                        fillColor: AppColors.GREY_Light_COLOR,
                      ),
                      TitledTextField(
                        maxLines: 4,
                        title: "الرسالة",
                        controller:
                            myAccountController.contactMssgController.value,
                        fillColor: AppColors.GREY_Light_COLOR,
                      ),
                      const SizedBox(height: 16),
                      ConditionalBuilder(
                        condition:
                            !myAccountController.isLoadingSendContactUs.value,
                        builder: (context) => SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: CustomButton(
                            title: "ارسال",
                            backgroundColor: AppColors.MAIN_COLOR,
                            foregroundColor: AppColors.WHITE_COLOR,
                            overlayColor: AppColors.WHITE_COLOR,
                            onPress: () {
                              handleSendToContactUsRequest(context);
                            },
                          ),
                        ),
                        fallback: (context) => const CustomCircleProgress(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
      }),
    );
  }
  handleSendToContactUsRequest(BuildContext context) {

    if (myAccountController.contactUserNameController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Enter_Name".tr),
        ),
      );
    }
    else if (myAccountController.contactEmailController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("من فضلك ادخل بريدك الالكتروني"),
        ),
      );
    }
    else if (myAccountController.contactMssgController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("من فضلك أكتب رسالتك".tr),
        ),
      );
    }  else {
      myAccountController.sendToContactUs(
        myAccountController
            .contactUserNameController.value.text,
        myAccountController
            .contactEmailController.value.text,
        myAccountController
            .contactMssgController.value.text,
        context,
      );
    }
  }
}
