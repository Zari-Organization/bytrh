import 'package:get/get.dart';
import '../../controllers/Consultations_Controllers/instant_consultations_controller.dart';

class InstantConsultationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InstantConsultationsController());
  }
}