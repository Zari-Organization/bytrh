import 'package:bytrh/Logic/controllers/My_Account_Controllers/personal_data_controller.dart';
import 'package:get/get.dart';

import '../../View/Screens/NavBar_Screens/Auction_Screen/auction_screen.dart';
import '../../View/Screens/NavBar_Screens/Home_Screen/home_screen.dart';
import '../../View/Screens/NavBar_Screens/My_Account_Screen/my_account_screen.dart';
import '../../View/Screens/NavBar_Screens/Products_Screen/categories_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  var appBarTitle = ''.obs;
  final tabs = [
    const HomeScreen(),
    CategoriesScreen(),
    const AuctionScreen(),
    MyAccountScreen(),
  ].obs;

  @override
  void onInit() async {
    super.onInit();
    tz.initializeTimeZones();
  }
}
