import 'package:bytrh/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Utils/app_icons.dart';
import '../../../Widgets/auth_button.dart';
import '../../../Widgets/titled_textField.dart';
import '../Widgets/custom_listTile.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        title: const Text("تواصل معنا"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomListTile(
                borderRadius:10,
                tileColor: AppColors.GREY_Light_COLOR,
                icon: AppIcons.square_phone_icon,
                iconColor: null,
                title: "00966055823545",
                onTap: () {},
              ),
              CustomListTile(
                borderRadius:10,
                tileColor: AppColors.GREY_Light_COLOR,
                icon: AppIcons.square_email_icon,
                iconColor: null,
                title: "Baetary.56@gmail.com",
                onTap: () {},
              ),
              CustomListTile(
                borderRadius:10,
                tileColor: AppColors.GREY_Light_COLOR,
                icon: AppIcons.square_message_icon,
                iconColor: null,
                title: "شات الدعم الفني",
                onTap: () {},
              ),
              CustomListTile(
                borderRadius:10,
                tileColor: AppColors.GREY_Light_COLOR,
                icon: AppIcons.square_location_icon,
                iconColor: null,
                title: "المدينة المنورة",
                onTap: () {},
              ),
              const SizedBox(height: 16),
              TitledTextField(
                title: "الأسم",
                // controller: personalDataController.userNameController.value,
                fillColor: AppColors.GREY_Light_COLOR,
              ),
              TitledTextField(
                title: "البريد الإلكتروني",
                // controller: personalDataController.userNameController.value,
                fillColor: AppColors.GREY_Light_COLOR,
              ),
              TitledTextField(
                maxLines: 4,
                title: "الرسالة",
                // controller: personalDataController.userNameController.value,
                fillColor: AppColors.GREY_Light_COLOR,
              ),
              const SizedBox(height: 16),
              CustomButton(
                title: "ارسال",
                backgroundColor: AppColors.MAIN_COLOR,
                foregroundColor: AppColors.WHITE_COLOR,
                overlayColor: AppColors.WHITE_COLOR,
                onPress: () {},
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
