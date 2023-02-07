import 'package:get/get.dart';
import '../../controllers/My_Account_Controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChangePasswordController());
  }
}
