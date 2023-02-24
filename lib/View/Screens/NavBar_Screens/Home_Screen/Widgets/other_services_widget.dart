import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/Utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:developer';

import '../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../Notifications/local_notifications.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_icons.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../Widgets/custom_circle_progress.dart';

class OtherServicesWidget extends StatelessWidget {
  OtherServicesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "خدمات أخرى",
          style: TextStyle(color: AppColors.BLACK_COLOR, fontSize: 20),
        ),
        SizedBox(height: 8),
        InkWell(
          onTap: () async {
            Get.toNamed(Routes.adoptionScreen);
          },
          child: SizedBox(
            height: 150,
            width: AppConstants.mediaWidth(context)/2.2,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.adoption_icon,
                      height: 30,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "تبني حيوانات أليفة",
                      style: TextStyle(
                        color: AppColors.MAIN_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
