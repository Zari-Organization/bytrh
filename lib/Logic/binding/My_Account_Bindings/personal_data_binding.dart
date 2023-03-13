import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/My_Account_Controllers/personal_data_controller.dart';
import '../../controllers/verification_controller.dart';

class PersonalDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PersonalDataController());
  }
}
