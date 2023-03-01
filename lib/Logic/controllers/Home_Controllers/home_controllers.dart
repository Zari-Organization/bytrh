import 'package:get/get.dart';
import '../../../Models/Home_Models/our_new_home_model.dart'as our_new_home_import;
import '../../../Models/advertisements_model/advertisements_model.dart' as advertisements_import;
import '../../../Services/Home_Services/home_services.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    getOurNew();
  }


  var isLoadingOurNewList = false.obs;
  var ourNewList = <our_new_home_import.Response>[].obs;

  getOurNew() async {
    try {
      isLoadingOurNewList(true);
      var response = await HomeServices.getOurNew();
      if (response.success) {
        ourNewList.value = response.response;
      }
    } finally {
      isLoadingOurNewList(false);
    }
  }
}
