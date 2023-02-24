import 'package:get/get.dart';
import '../../controllers/Chat_Controllers/chat_controllers.dart';
import '../../controllers/Consultations_Controllers/instant_consultations_controller.dart';

class InstantConsultationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InstantConsultationsController());
    Get.lazyPut(()=>ConsultationsChatController());
  }
}