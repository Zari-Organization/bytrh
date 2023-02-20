import 'package:get/get.dart';
import '../../controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../controllers/Consultations_Controllers/term_consultations_controller.dart';

class TermConsultationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TermConsultationsController());
  }
}