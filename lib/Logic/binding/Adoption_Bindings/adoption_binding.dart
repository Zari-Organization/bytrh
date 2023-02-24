import 'package:get/get.dart';
import '../../controllers/Adoption_Controllers/adoption_controller.dart';

class AdoptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdoptionController());
  }
}
