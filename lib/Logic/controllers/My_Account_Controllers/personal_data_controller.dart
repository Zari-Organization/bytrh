import 'dart:developer';
import 'dart:io';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Models/personal_data_model.dart';
import '../../../Services/Consultations_Services/consultations_services.dart';
import '../../../Services/My_Account_Services/personal_data_services.dart';
import '../auth_controller.dart';
import '../verification_controller.dart';
import '../../../Models/Consultations_Models/animals_category_model.dart'
    as animals_category_import;

class PersonalDataController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    await getPersonalData();
    userNameController.value.text = clientData.value.clientName;
    phoneController.value.text = clientData.value.clientPhone ?? "";
    emailController.value.text = clientData.value.clientEmail ?? "";
    countryNameController.value = clientData.value.countryName;
    cityNameController.value = clientData.value.cityName;
    countryIDController.value = clientData.value.iDCountry.toString();
    await getAnimalsCategory();
    if (clientData.value.idAnimalCategory == null) {
      selectedAnimalsCategoryValue.value =
          animalsCategoryList[0].idAnimalCategory.toString();
    } else {
      selectedAnimalsCategoryValue.value =
          clientData.value.idAnimalCategory.toString();
    }
  }

  var isLoadingAnimalsCategory = false.obs;
  var animalsCategoryList = <animals_category_import.Response>[].obs;
  var selectedAnimalsCategoryValue = ''.obs;

  getAnimalsCategory() async {
    try {
      isLoadingAnimalsCategory(true);
      var animalsCategory = await ConsultationsServices.getAnimalsCategory();
      if (animalsCategory.response.isNotEmpty) {
        animalsCategoryList.value = animalsCategory.response;
      }
    } finally {
      isLoadingAnimalsCategory(false);
    }
  }

  var isLoading = false.obs;

  var userNameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var completePhoneNumber = TextEditingController().obs;
  var phoneCodeController = TextEditingController().obs;
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
        log("Client Data Controller --> ${clientData.value.clientName}");
        await getCountryFlag(clientData.value.clientPhoneFlag ?? "+966");
        log("Country Flag --> ${countryFlag.value}");
      }
    } finally {
      isLoading(false);
    }
  }

  var isLoadingEditData = false.obs;

  editClientInfo(
    String ClientName,
    String ClientEmail,
    String ClientPhone,
    String ClientPhoneFlag,
    String IDCity,
    String IDAnimalCategory,
    File? ClientPicture,
    BuildContext context,
  ) async {
    try {
      isLoadingEditData(true);
      var editData = await PersonalDataServices.editClientInfo(
          ClientName,
          ClientEmail,
          ClientPhone,
          ClientPhoneFlag,
          IDCity,
          IDAnimalCategory,
          ClientPicture!,
          context);
      if (editData["Success"]) {
        if (editData['ApiCode'] == 18) {
          final verificationController = Get.find<VerificationController>();
          verificationController.phoneController.value.text = ClientPhone;
          verificationController.verifyEdit.value = true;
          verificationController.sendCodeToVerifyAccount(
              verificationController.phoneController.value.text, context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.MAIN_COLOR,
              duration: const Duration(seconds: 2),
              content: Text(editData["ApiMsg"].toString()),
            ),
          );
        } else {
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
        }
      } else {
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

  var isLoadingCountriesFlags = false.obs;
  var countriesFlagsList = [].obs;
  var countryFlag = ''.obs;

  getCountryFlag(String userCountryCode) async {
    try {
      isLoadingCountriesFlags(true);
      var response = await PersonalDataServices.getCountriesFlags();
      if (response.isNotEmpty) {
        countriesFlagsList.addAll(response);
        for (int i = 0; i < countriesFlagsList.length; i++) {
          if (countriesFlagsList[i]["dial_code"] == userCountryCode) {
            countryFlag.value = await countriesFlagsList[i]["code"];
          } else {
            null;
          }
        }
      }
    } finally {
      isLoadingCountriesFlags(false);
    }
  }

  final ImagePicker _picker = ImagePicker();
  Rx<File?> profileImageFile = File("").obs;

  void getProfileImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    profileImageFile.value = File(pickedFile!.path);
  }
}
