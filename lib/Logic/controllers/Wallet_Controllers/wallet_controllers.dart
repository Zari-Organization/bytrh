import 'package:get/get.dart';

import '../../../Models/Wallet_Models/my_wallet_model.dart'as myWallet_import;
import '../../../Services/Wallet_Services/wallet_services.dart';


class WalletController extends GetxController {

  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    getMyWallet();
  }

  var myWalletData = myWallet_import.Response().obs;

  getMyWallet() async {
    try {
      isLoading(true);
      var result = await WalletServices.getMyWallet();
      if (result.success) {
        myWalletData.value = result.response;
      }
    } finally {
      isLoading(false);
    }
  }

}
