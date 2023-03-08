import 'package:get/get.dart';
import '../controllers/Adoption_Controllers/adoption_controller.dart';
import '../controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../controllers/My_Account_Controllers/my_account_controller.dart';
import '../controllers/Products_Controllers/products_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/My_Account_Controllers/personal_data_controller.dart';
import '../controllers/my_animals_controller.dart';

class MyAnimalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyAnimalsController());
    Get.lazyPut(()=>AdoptionController());
    Get.lazyPut(()=>ProductsController());
  }
}
