import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Logic/controllers/My_Account_Controllers/my_account_controller.dart';
import 'app_colors.dart';
import 'app_constants.dart';
import 'app_images.dart';

class AppAlerts {
  Future<bool>? onWillPop() async {
    final result = await Get.defaultDialog(
      title: 'Exit'.tr,
      titleStyle: const TextStyle(color: AppColors.RED_COLOR),
      content: Text("exit_app_alert".tr,
          textAlign: TextAlign.center),
      cancel: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                color: AppColors.MAIN_COLOR,
                width: 1,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.WHITE_COLOR,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.MAIN_COLOR,
          ),
        ),
        onPressed: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        child: Text("Yes".tr),
      ),
      confirm: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.MAIN_COLOR,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.BLACK_COLOR,
          ),
        ),
        onPressed: () {
          Get.back();
        },
        child: Text(
          "No".tr,
          style: const TextStyle(color: AppColors.WHITE_COLOR),
        ),
      ),
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }
  Future<bool>? onPaymentPop() async {
    final result = await Get.defaultDialog(
      title: 'الغاء'.tr,
      titleStyle: const TextStyle(color: AppColors.RED_COLOR),
      content: Text("هل تريد الغاء عملية الدفع؟".tr,
          textAlign: TextAlign.center),
      cancel: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                color: AppColors.MAIN_COLOR,
                width: 1,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.WHITE_COLOR,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.MAIN_COLOR,
          ),
        ),
        onPressed: ()async {
          Get.back();
          await Future.delayed(Duration(seconds: 1)).then((value) => Get.back());
        },
        child: Text("Yes".tr),
      ),
      confirm: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.MAIN_COLOR,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.BLACK_COLOR,
          ),
        ),
        onPressed: () {
          Get.back();
        },
        child: Text(
          "No".tr,
          style: const TextStyle(color: AppColors.WHITE_COLOR),
        ),
      ),
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }
  Future<bool>? logoutPop(context) async {
    final myAccountController = Get.find<MyAccountController>();
    final result = await Get.defaultDialog(
      title: 'تسجيل الخروج',
      titleStyle: const TextStyle(color: AppColors.RED_COLOR),
      content: const Text("هل أنت متأكد أنك تريد تسجيل الخروج ؟",
          textAlign: TextAlign.center),
      cancel: SizedBox(
        width: AppConstants.mediaWidth(context)/3,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(
                  color: AppColors.MAIN_COLOR,
                  width: 1,
                ),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              AppColors.WHITE_COLOR,
            ),
            foregroundColor: MaterialStateProperty.all(
              AppColors.MAIN_COLOR,
            ),
          ),
          onPressed: () {
            myAccountController.logout(context);
          },
          child: Text("نعم".tr),
        ),
      ),
      confirm: SizedBox(
        width: AppConstants.mediaWidth(context)/3,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              AppColors.MAIN_COLOR,
            ),
            foregroundColor: MaterialStateProperty.all(
              AppColors.BLACK_COLOR,
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: Text(
            "الغاء".tr,
            style: const TextStyle(color: AppColors.WHITE_COLOR),
          ),
        ),
      ),
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }

  Future<bool>? paymentSuccessfullyPop(String title,String bankMsg) async {
    final result = await Get.defaultDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: "",
      content: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.MAIN_COLOR,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            bankMsg,
            style:  TextStyle(
              color: AppColors.GREY_COLOR,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Image.asset(
            AppImages.saudi_man_image
          ),
        ],
      ),
      cancel: const SizedBox(),
      confirm: const SizedBox(),
      confirmTextColor: AppColors.WHITE_COLOR,
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }

}