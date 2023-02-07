import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../controllers/My_Account_Controllers/personal_data_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.lazyPut(()=>PersonalDataController());
  }
}
