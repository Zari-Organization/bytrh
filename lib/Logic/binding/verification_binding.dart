import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/verification_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VerificationController());
    Get.lazyPut(()=>AuthController());
  }
}
