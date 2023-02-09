import 'package:bytrh/Utils/app_alerts.dart';
import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../Logic/controllers/Wallet_Controllers/wallet_controllers.dart';
import '../../../../../Widgets/auth_button.dart';
import '../../../../../Widgets/titled_textField.dart';
import 'Widgets/payment_methods_widget.dart';

class WalletPaymentScreen extends StatelessWidget {
  WalletPaymentScreen({Key? key}) : super(key: key);
  final walletController = Get.find<WalletController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          title: const Text("شحن المحفظة"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitledTextField(
                  title: "أدخل قيمة الشحن",
                  controller: walletController.amountController.value,
                  fillColor: AppColors.GREY_Light_COLOR,
                ),
                const SizedBox(height: 16),
                const Text(
                  "أختر طريقة الدفع",
                  style: TextStyle(color: AppColors.BLACK_COLOR, fontSize: 16),
                ),
                const SizedBox(height: 16),
                PaymentMethodsWidget(),
                const SizedBox(height: 50),
                Obx(
                      () => ConditionalBuilder(
                    condition: !walletController.isLoadingWalletPayment.value,
                    builder: (context) =>  CustomButton(
                      title: "دفع الآن",
                      backgroundColor: AppColors.MAIN_COLOR,
                      foregroundColor: AppColors.WHITE_COLOR,
                      overlayColor: AppColors.WHITE_COLOR,
                      onPress: () {
                        // AppAlerts().paymentSuccessfullyPop("تم الدفع بنجاح","AUTHENTICATION_FAILED");
                        walletController.getWalletPayment(context);
                      },
                    ),
                    fallback: (context) => const CustomCircleProgress(),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }
}
