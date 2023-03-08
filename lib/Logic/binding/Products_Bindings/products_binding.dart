import 'package:get/get.dart';
import '../../controllers/Products_Controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductsController());
  }
}
