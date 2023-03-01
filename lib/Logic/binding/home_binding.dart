import 'package:get/get.dart';
import '../controllers/Home_Controllers/home_controllers.dart';
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
