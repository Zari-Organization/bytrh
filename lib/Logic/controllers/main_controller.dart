import 'package:get/get.dart';

import '../../View/Screens/Auction_Screen/auction_screen.dart';
import '../../View/Screens/Home_Screen/home_screen.dart';
import '../../View/Screens/My_Account_Screen/my_account_screen.dart';
import '../../View/Screens/Products_Screen/products_screen.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  var appBarTitle = ''.obs;
  final tabs = [
    const HomeScreen(),
    const ProductsScreen(),
    const AuctionScreen(),
    const MyAccountScreen(),
  ].obs;

  @override
  void onInit() async {
    super.onInit();
  }
}
