import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  late Timer timer;

  void _goNext() =>Get.offAllNamed(Routes.authTypeScreen);

  startDelay() {
    timer = Timer(const Duration(seconds: 3), _goNext);
  }

  @override
  void initState() {
    GetStorage().read<String>('AccessToken');
    GetStorage().read<String>('userName');
    if (kDebugMode) {
      print(GetStorage().read<String>('AccessToken'));
      print(GetStorage().read<String>('userName'));
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
      Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Baytrh",style: TextStyle(color: Color(0xffF2B705),fontSize: 40),),
          Text("بيطرة",style: TextStyle(color: Color(0xffF2B705),fontSize: 30),),
        ],
      )),
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
