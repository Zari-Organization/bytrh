import 'package:get/get.dart';
import '../../controllers/My_Account_Controllers/my_account_controller.dart';

class MyAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyAccountController());
  }
}
