import 'package:get/get.dart';
import '../controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../controllers/My_Account_Controllers/my_account_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/My_Account_Controllers/personal_data_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.lazyPut(()=>PersonalDataController());
    Get.lazyPut(()=>MyAccountController());
    Get.lazyPut(()=>InstantConsultationsController());
    Get.lazyPut(()=>TermConsultationsController());
  }
}
