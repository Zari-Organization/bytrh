import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_images.dart';
import 'dart:developer';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  late Timer timer;

  void _goNext() {
    if (GetStorage().read<bool>('onBoarding') == null) {
      Get.offAllNamed(Routes.onBoardingScreen);
    } else if (GetStorage().read<String>('AccessToken') == null) {
      Get.offAllNamed(Routes.authTypeScreen);
    } else {
      Get.offAllNamed(Routes.mainScreen);
    }
  }

  startDelay() {
    timer = Timer(const Duration(seconds: 3), _goNext);
  }

  @override
  void initState() {
    GetStorage().read<bool>('onBoarding');
    GetStorage().read<String>('AccessToken');
    if (kDebugMode) {
      log(GetStorage().read<String>('AccessToken').toString());
      log(GetStorage().read<bool>('onBoarding').toString());
    }
    startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.MAIN_COLOR.withOpacity(0.5),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              AppImages.splash_background,
              fit: BoxFit.cover,
            ),
          ),
          Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(
                  AppImages.bytrh_logo,
                ),
              )
          ),
          // Center(
          //     child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "Baytrh",
          //       style: TextStyle(color: Color(0xffF2B705), fontSize: 40),
          //     ),
          //     Text(
          //       "بيطرة",
          //       style: TextStyle(color: Color(0xffF2B705), fontSize: 30),
          //     ),
          //   ],
          // )),
          // Center(
          //   child: Hero(
          //     tag: 'logo',
          //     child: Image.asset(
          //       AppImages.bytrh_logo,
          //       fit: BoxFit.cover,
          //       // width: 150,
          //       height: 250,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
