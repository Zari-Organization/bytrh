import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // 1. Define a `GlobalKey` as part of the parent widget's state
  final _introKey = GlobalKey<IntroductionScreenState>();
  String _status = 'Waiting...';
  final authBox = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authBox.write('onBoarding', true);
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      // 2. Pass that key to the `IntroductionScreen` `key` param
      key: _introKey,
      // controlsPadding: EdgeInsets.zero,
      bodyPadding: EdgeInsets.zero,
      pages: [
        PageViewModel(
            // title: '',
            titleWidget: SizedBox(),
            bodyWidget: Column(
              children: [
                Image.asset(AppImages.OB_IMAGE1,fit: BoxFit.cover,),
                SizedBox(height: 12),
                Text("مرحبا"),
                SizedBox(height: 12),
                Text("مرحباً بك في_____ تعرف معنا على ا على ا على مميزات التطبيق الخاص بنا"),
              ],
            ),),
        PageViewModel(
          // title: '',
          titleWidget: SizedBox(),
          bodyWidget: Column(
            children: [
              Image.asset(AppImages.OB_IMAGE2),
              SizedBox(height: 12),
              Text("عيادات وإستشارات طبية"),
              SizedBox(height: 12),
              Text("من خلال ______ يمكنك حجز موعد في عيادة أو مركز طبي من خلالنا."),
            ],
          ),),
        PageViewModel(
          // title: '',
          titleWidget: SizedBox(),
          bodyWidget: Column(
            children: [
              Image.asset(AppImages.OB_IMAGE3,fit: BoxFit.cover,),
              SizedBox(height: 12),
              Text("إنقاذ الحيوانات"),
              SizedBox(height: 12),
              Text("من خلال ______ يمكننا العمل على الإنقاذ السريع للحيوانات."),
            ],
          ),),
      ],
      onDone: () {
       Get.toNamed(Routes.authTypeScreen);
      },
      back: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios_rounded,size: 18),
          Text("السابق"),
        ],
      ),
      skip: const Text("تخطي"),
      next:Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("التالي"),
          Icon(Icons.arrow_forward_ios,size: 18),
        ],
      ),
      done: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("ابدأ الان"),
          Icon(Icons.arrow_forward_ios,size: 18),
        ],
      ),

      skipStyle: TextButton.styleFrom(primary: AppColors.GREY_COLOR),
      doneStyle: TextButton.styleFrom(primary: AppColors.SECOND_COLOR),
      nextStyle: TextButton.styleFrom(primary: AppColors.SECOND_COLOR),
      // backStyle: TextButton.styleFrom(primary: AppColors.GREY_COLOR),
      showNextButton: true,
      showDoneButton: true,
      // showBackButton: true,
      showSkipButton: true,
    );
  }
}
