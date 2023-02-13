import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Models/personal_data_model.dart';
import '../../../Services/My_Account_Services/personal_data_services.dart';

class PersonalDataController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await getPersonalData();
    userNameController.value.text = clientData.value.clientName;
    phoneController.value.text = clientData.value.clientPhone??"";
    emailController.value.text = clientData.value.clientEmail??"";
    countryNameController.value = clientData.value.countryName;
    cityNameController.value = clientData.value.cityName;
    countryIDController.value = clientData.value.iDCountry.toString();
  }

  var isLoading = false.obs;

  var userNameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var countryNameController = "".obs;
  var cityNameController = "".obs;
  var countryIDController = ''.obs;
  var cityID = ''.obs;


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

  var isLoadingEditData = false.obs;


  editClientInfo(
    String ClientName,
    String ClientEmail,
    String IDCity,
    File? ClientPicture,
    BuildContext context,
  ) async {
    try {
      isLoadingEditData(true);
      var editData = await PersonalDataServices.editClientInfo(
        ClientName,
        ClientEmail,
        IDCity,
        ClientPicture!,
      );
      if (editData["Success"]) {
        log(editData["Success"].toString());
        getPersonalData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // backgroundColor: AppColors.GREEN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(
              "Data_updated".tr,
            ),
          ),
        );
        Get.back();
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // backgroundColor: AppColors.GREEN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(
              editData["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingEditData(false);
    }
  }
  final ImagePicker _picker = ImagePicker();
  Rx<File?> profileImageFile = File("").obs;

  void getProfileImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    profileImageFile.value = File(pickedFile!.path);
  }
}
