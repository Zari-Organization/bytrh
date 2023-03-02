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
                        textDirection: TextDirection.ltr,
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
                        textDirection: TextDirection.ltr,
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
                        onTap: () {
                          myAccountController.requestChatSupport(context);
                        },
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
                      const Text("أو تواصل معنا من خلال إرسال رسالة..",style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 16),
                      TitledTextField(
                        title: "الأسم",
                        controller:
                            myAccountController.contactUserNameController.value,
                        fillColor: AppColors.GREY_Light_COLOR,
                      ),
                      Form(
                        autovalidateMode: AutovalidateMode.always,
                        child: TitledTextField(
                          validator: validateEmail,
                          title: "البريد الإلكتروني",
                          textDirection: TextDirection.ltr,
                          controller:
                              myAccountController.contactEmailController.value,
                          fillColor: AppColors.GREY_Light_COLOR,
                        ),
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
    } else if (myAccountController.contactEmailController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("من فضلك ادخل بريدك الالكتروني"),
        ),
      );
    } else if (myAccountController.contactMssgController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("من فضلك أكتب رسالتك".tr),
        ),
      );
    } else {
      myAccountController.sendToContactUs(
        myAccountController.contactUserNameController.value.text,
        myAccountController.contactEmailController.value.text,
        myAccountController.contactMssgController.value.text,
        context,
      );
    }
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'من فضلك ادخل البريد الالكتروني صحيح'
        : null;
  }
}
