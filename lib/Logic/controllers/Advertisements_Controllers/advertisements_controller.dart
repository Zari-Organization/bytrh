import 'package:get/get.dart';
import '../../../Models/advertisements_model/advertisements_model.dart' as advertisements_import;
import '../../../Services/Advertisements_Services/advertisements_services.dart';

class AdvertisementsController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    advertisementLocation.value = "HOME";
    advertisementService.value = "NONE";
  }
  var currentAdvertisement = 0.obs;


  var isLoadingAdvertisements = false.obs;
  var advertisementLocation = ''.obs;
  var advertisementService = ''.obs;
  var advertisementsList = <advertisements_import.Response>[].obs;

  getAdvertisements() async {
    try {
      isLoadingAdvertisements(true);
      var response = await AdvertisementsServices.getAdvertisements(
        AdvertisementLocation: advertisementLocation.value,
        AdvertisementService: advertisementService.value,
      );
      if (response.success) {
        advertisementsList.value = response.response;
      }
    } finally {
      isLoadingAdvertisements(false);
    }
  }
}
