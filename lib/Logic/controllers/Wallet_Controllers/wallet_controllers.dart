import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Models/Wallet_Models/my_wallet_model.dart' as myWallet_import;
import '../../../Models/Wallet_Models/payment_methods_model.dart'
    as payment_methods_import;
import '../../../Models/Wallet_Models/wallet_payment_model.dart'
    as wallet_payment_import;
import '../../../Services/Wallet_Services/wallet_services.dart';
import '../../../Utils/app_alerts.dart';
import '../../../View/Screens/NavBar_Screens/My_Account_Screen/Screens/Wallet_Screens/payment_webView_screen.dart';

class WalletController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    getMyWallet();
    getPaymentMethods();
  }

  var isLoadingMyWallet = false.obs;
  var myWalletData = myWallet_import.Response().obs;

  getMyWallet() async {
    try {
      isLoadingMyWallet(true);
      var result = await WalletServices.getMyWallet();
      if (result.success) {
        myWalletData.value = result.response;
      }
    } finally {
      isLoadingMyWallet(false);
    }
  }

  var isLoadingPaymentMethods = false.obs;
  var paymentMethodsList = <payment_methods_import.Response>[].obs;

  getPaymentMethods() async {
    try {
      isLoadingPaymentMethods(true);
      var result = await WalletServices.getPaymentMethods();
      if (result.success) {
        paymentMethodsList.value = result.response;
      }
    } finally {
      isLoadingPaymentMethods(false);
    }
  }

  var paymentMethodId = "".obs;
  RxInt paymentMethodSelectedIndex = (-1).obs;

  void changePaymentMethodSelectedIndex(int selectedIndex) {
    paymentMethodSelectedIndex.value = selectedIndex;
    paymentMethodId.value =
        paymentMethodsList[selectedIndex].idPaymentMethod.toString();
  }

  var isLoadingWalletPayment = false.obs;
  var walletPaymentData = wallet_payment_import.Response().obs;
  var amountController = TextEditingController().obs;

  getWalletPayment(context) async {
    try {
      isLoadingWalletPayment(true);
      var result = await WalletServices.getWalletPayment(
        amountController.value.text,
        paymentMethodId.value.toString(),
      );
      if (result.success) {
        walletPaymentData.value = result.response;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWebViewScreen(
              PaymentURL: result.response.paymentUrl,
            ),
          ),
        );
        // await launchUrl(Uri.parse(result.response.paymentUrl));
      }
    } finally {
      isLoadingWalletPayment(false);
    }
  }

  var isLoadingWalletPaymentStatus = false.obs;

  walletPaymentStatus(BuildContext context) async {
    try {
      isLoadingWalletPaymentStatus(true);
      var response = await WalletServices.walletPaymentStatus(
        walletPaymentData.value.invoiceId.toString(),
      );
      if (response["Success"]) {
        log(response["ApiMsg"]);
        getMyWallet();
        Get.back();
        await Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
        AppAlerts().paymentSuccessfullyPop(response["ApiMsg"].toString(),
            response["Response"]["BankMessage"] ?? "");
      } else {
        log(response["ApiMsg"]);
        Get.back();
        await Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
        AppAlerts().paymentSuccessfullyPop(
            response["ApiMsg"].toString(), response["Response"]["BankMessage"]);
      }
    } finally {
      isLoadingWalletPaymentStatus(false);
    }
  }
}
