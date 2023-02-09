import 'package:get/get.dart';
import '../../controllers/Wallet_Controllers/wallet_controllers.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WalletController());
  }
}