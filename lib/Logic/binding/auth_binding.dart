import 'package:get/get.dart';
import '../controllers/My_Account_Controllers/personal_data_controller.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>PersonalDataController());
    Get.put(AuthController());

  }
}
