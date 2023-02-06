import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Models/auth_model.dart';
import '../../Models/personal_data_model.dart';
import '../../Routes/routes.dart';
import '../../Services/auth_services.dart';
import '../../Services/personal_data_services.dart';

class PersonalDataController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  await getPersonalData();
    userNameController.value = clientData.value.clientName;
    phoneController.value = clientData.value.clientPhone;
    emailController.value = clientData.value.clientEmail;
    cityController.value = clientData.value.idClient;
  }

  var isLoading = false.obs;

  var userNameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var cityController = TextEditingController().obs;

  var clientData = PersonalDataResponse().obs;


  getPersonalData() async {
    try {
      isLoading(true);
      var profileResponse = await PersonalDataServices.getPersonalData();
      if (profileResponse.success) {
        clientData.value = profileResponse.response;
      }
    } finally {
      isLoading(false);
    }
  }

}
