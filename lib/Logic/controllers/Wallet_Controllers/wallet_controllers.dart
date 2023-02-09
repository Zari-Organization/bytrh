import 'package:get/get.dart';

import '../../../Models/Wallet_Models/my_wallet_model.dart'as myWallet_import;
import '../../../Models/Wallet_Models/payment_methods_model.dart'as payment_methods_import;
import '../../../Services/Wallet_Services/wallet_services.dart';


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

}
