import 'package:get/get.dart';
import '../controllers/Advertisements_Controllers/advertisements_controller.dart';
import '../controllers/My_Account_Controllers/personal_data_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/verification_controller.dart';

class AdvertisementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdvertisementsController());
  }
}
