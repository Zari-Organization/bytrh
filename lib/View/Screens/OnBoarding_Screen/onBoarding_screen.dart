import 'dart:io';
import 'dart:math';
import 'package:bytrh/Utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../Utils/app_colors.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_icons.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.BLACK_COLOR,
      body: Column(
        children: [
        Stack(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: AppConstants.mediaHeight(context)/3,
                color: AppColors.MAIN_COLOR,
              ),
            ),
          ],
        )
        ],
      )
    );
  }
}
