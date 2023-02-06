import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/personal_data_controller.dart';

class PersonalDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PersonalDataController());
  }
}
