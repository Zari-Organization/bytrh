import 'dart:async';
import 'dart:developer';

import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/View/Widgets/auth_button.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';

import '../Logic/controllers/Chat_Controllers/chat_controllers.dart';
import '../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../Logic/controllers/My_Account_Controllers/my_account_controller.dart';
import '../Logic/controllers/Products_Controllers/products_controller.dart';
import '../Models/Consultations_Models/consultations_doctor_profile_model.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/Widgets/custom_textField_widget.dart';
import 'app_colors.dart';
import 'app_constants.dart';
import 'app_images.dart';

class AppAlerts {
  Future<bool>? onWillPop() async {
    final result = await Get.defaultDialog(
      title: 'Exit'.tr,
      titleStyle: const TextStyle(color: AppColors.RED_COLOR),
      content: Text("exit_app_alert".tr, textAlign: TextAlign.center),
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
      content:
          Text("هل تريد الغاء عملية الدفع؟".tr, textAlign: TextAlign.center),
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
        onPressed: () async {
          Get.back();
          await Future.delayed(const Duration(seconds: 1))
              .then((value) => Get.back());
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
        width: AppConstants.mediaWidth(context) / 3,
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
        width: AppConstants.mediaWidth(context) / 3,
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

  Future<bool>? paymentSuccessfullyPop(String title, String bankMsg) async {
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
          const SizedBox(height: 10),
          Text(
            bankMsg,
            style: TextStyle(
              color: AppColors.GREY_COLOR,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(AppImages.saudi_man_image),
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

  Future<bool>? consultationsCreatedSuccessfullyPop() async {
    final result = await Get.defaultDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: "",
      content: Column(
        children: [
          const Text(
            "تم إرسال طلب إستشارتك",
            style: TextStyle(
              color: AppColors.MAIN_COLOR,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(AppImages.saudi_man_image),
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

  Future<bool>? selectDoctorTimeCreatedSuccessfullyPop() async {
    final result = await Get.defaultDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: "",
      content: Column(
        children: [
          const Text(
            "تم الطلب بنجاح",
            style: TextStyle(
              color: AppColors.MAIN_COLOR,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(AppImages.saudi_man_image),
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

  Future<bool>? consultationsCountDownPop(
      String consultId, String consultStatus) async {
    Get.put(ConsultationsChatController());
    final result = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(color: AppColors.MAIN_COLOR),
      titlePadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Text(
                getStatus(consultStatus),
                style: const TextStyle(color: AppColors.MAIN_COLOR),
              ),
            ],
          ),
        ),
      ),
      cancel: const SizedBox(),
      confirm: const SizedBox(),
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }

  Future<bool>? chatComplaintPop(String idConsult, BuildContext context) async {
    final consultationsChatController = Get.find<ConsultationsChatController>();
    final result = await Get.defaultDialog(
      title: 'إرسال شكوي',
      titleStyle: const TextStyle(color: AppColors.MAIN_COLOR),
      content: CustomTextFieldWidget(
        hintText: "اكتب شكوتك ...",
        maxLines: 3,
        controller: consultationsChatController.chatComplaintController.value,
      ),
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
          consultationsChatController.sendComplaintConsultChat(
              idConsult,
              consultationsChatController.chatComplaintController.value.text,
              context);
        },
        child: const Text("إرسال"),
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
        child: const Text(
          "إلغاء",
          style: TextStyle(color: AppColors.WHITE_COLOR),
        ),
      ),
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }

  Future<bool>? chatSupportEndedPop() async {
    final result = await Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: "",
      content: Column(
        children: [
          const Text(
            "تم انتهاء المحادثة مع الدعم",
            style: TextStyle(
              color: AppColors.MAIN_COLOR,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      cancel: const SizedBox(),
      confirm: Expanded(
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
          Timer(const Duration(seconds: 1), () => Get.back());
          Timer(const Duration(seconds: 1), () => Get.back());
        },
        child: const Text(
          "موافق",
          style: TextStyle(color: AppColors.WHITE_COLOR),
        ),
      )),
      confirmTextColor: AppColors.WHITE_COLOR,
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }

  Future<bool>? setProductDelivery(BuildContext context) async {
    // final consultationsChatController = Get.find<ConsultationsChatController>();
    final result = await Get.defaultDialog(
      title: 'إرسال شكوي',
      titleStyle: const TextStyle(color: AppColors.MAIN_COLOR),
      content: CustomTextFieldWidget(
        hintText: "اكتب شكوتك ...",
        keyboardType: TextInputType.number,
        maxLines: 1,
        // controller: consultationsChatController.chatComplaintController.value,
      ),
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
        onPressed: () {},
        child: const Text("موافق"),
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
        child: const Text(
          "إلغاء",
          style: TextStyle(color: AppColors.WHITE_COLOR),
        ),
      ),
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }

  Future<bool>? productDeliveryFeesPop(int index, BuildContext context) async {
    final productsController = Get.find<ProductsController>();
    final result = await Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      titlePadding: EdgeInsets.zero,
      title: "",
      content: Obx(
        () => Column(
          children: [
            Text(
              "تم تحديد قيمة التوصيل",
              style: TextStyle(
                color: AppColors.GREY_COLOR,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${productsController.productsAnimalsRequestsList[index].deliveryFees} ر.س",
              style: const TextStyle(
                color: AppColors.MAIN_COLOR,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  side: const BorderSide(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  value: productsController.acceptDeliveryChecked.value,
                  onChanged: (_) {
                    productsController.acceptDeliveryNotChecked.value = false;
                    productsController.acceptDeliveryChecked.value = true;
                    log(productsController.acceptDeliveryChecked.value
                        .toString());
                    log(productsController.acceptDeliveryNotChecked.value
                        .toString());
                  },
                  activeColor: AppColors.SECOND_COLOR,
                ),
                const Text(
                  "موافق",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  side: const BorderSide(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  value: productsController.acceptDeliveryNotChecked.value,
                  onChanged: (_) {
                    productsController.acceptDeliveryChecked.value = false;
                    productsController.acceptDeliveryNotChecked.value = true;
                    log(productsController.acceptDeliveryChecked.value
                        .toString());
                    log(productsController.acceptDeliveryNotChecked.value
                        .toString());
                  },
                  activeColor: AppColors.SECOND_COLOR,
                ),
                const Text(
                  "غير موافق",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      cancel: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomButton(
          title: "تم",
          foregroundColor: AppColors.WHITE_COLOR,
          onPress: () {
            productsController.addProductDeliveryStatus(
              IDAnimalProduct: productsController
                  .productsAnimalsRequestsList[index].idAnimalProduct
                  .toString(),
              AnimalProductStatus:
                  productsController.acceptDeliveryChecked.value
                      ? "ACCEPTED"
                      : "REJECTED",
              context: context,
            );
          },
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomButton(
          title: "إلغاء",
          backgroundColor: AppColors.WHITE_COLOR,
          onPress: () {
            Get.back();
          },
        ),
      ),
      confirmTextColor: AppColors.WHITE_COLOR,
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }

  Future<bool>? termsRequestConsultationsNotePop(BuildContext context) async {
    final termConsultationsController = Get.find<TermConsultationsController>();
    final result = await Get.defaultDialog(
      title: 'ملاحظات',
      titleStyle: const TextStyle(color: AppColors.MAIN_COLOR),
      content: CustomTextFieldWidget(
        hintText: "أكتب ملاحظاتك مع طلب الإستشارة ...",
        maxLines: 3,
        controller:
            termConsultationsController.requestConsultNoteController.value,
      ),
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
          termConsultationsController.termRequestConsult(
            ConsultNote: termConsultationsController
                .requestConsultNoteController.value.text,
            context: context,
          );
        },
        child: const Text("طلب"),
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
        child: const Text(
          "إلغاء",
          style: TextStyle(color: AppColors.WHITE_COLOR),
        ),
      ),
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }
}

Future<bool>? consultationsCreatedSuccessfullyPop() async {
  final result = await Get.defaultDialog(
    contentPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    title: "",
    content: Column(
      children: [
        const Text(
          "تم إرسال طلب إستشارتك",
          style: TextStyle(
            color: AppColors.MAIN_COLOR,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(AppImages.saudi_man_image),
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

String getStatus(status) {
  switch (status) {
    case "ONGOING":
      return "الإستشارة جارية";
    case "PENDING":
      return "لم يتم قبول الإستشارة بعد";
    case "PENDING_TIME":
      return "في انتظار تحديد الوقت";
    case "ACCEPTED":
      return "تم قبول الإستشارة";
    case "REJECTED":
      return "تم رفض الاستشارة من قبل الطبيب";
    case "ENDED":
      return "تم إنتهاء وقت الإستشارة";
    case "EXPIRED":
      return " انتهاء صلاحية الإستشارة";
    case "NO_RESPONSE":
      return " لم يستجب الدكتور";
    case "SKIPPED":
      return " تم التخطي من قبل الدكتور";
    case "CANCELLED":
      return " تم الغاء الاستشارة";
    default:
      return "";
  }
}
