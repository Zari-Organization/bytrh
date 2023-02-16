import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/Consultations_Models/animals_category_model.dart'
    as animals_category_import;
import '../../../Models/Consultations_Models/consultations_doctor_profile_model.dart'
    as consultations_doctor_profile_import;
import '../../../Models/Consultations_Models/consultations_doctors_model.dart'
    as consultations_doctors_import;
import '../../../Models/Location_Models/areas_model.dart' as areas_import;
import '../../../Routes/routes.dart';
import '../../../Services/Consultations_Services/consultations_services.dart';

class InstantConsultationsController extends GetxController
    with GetTickerProviderStateMixin {
  late Rx<TabController> tabController =
      TabController(length: 2, vsync: this).obs;

  @override
  void onInit() async {
    super.onInit();
    tabController.value = TabController(length: 2, vsync: this);
    await getAreas();
    await getAnimalsCategory();
    selectedAreaValue.value = areasList[0].idArea.toString();
    selectedAnimalsCategoryValue.value = animalsCategoryList[0].idAnimalCategory.toString();
    await getConsultationsDoctors();
  }

  var isLoadingConsultationsDoctors = false.obs;
  var consultationsDoctorsList = <consultations_doctors_import.Response>[].obs;
  var defaultCity = ''.obs;
  var serviceKey = ''.obs;

  var areaTextFieldValue = ''.obs;

  getConsultationsDoctors() async {
    var response = await ConsultationsServices.getConsultationsDoctors(
      service: doctorServiceKey.value,
      DoctorName: areaTextFieldValue.value,
      IDArea: selectedAreaValue.value,
      IDAnimalCategory: selectedAnimalsCategoryValue.value,
    );
    try {
      isLoadingConsultationsDoctors(true);
      if (response.response.isNotEmpty) {
        consultationsDoctorsList.value = response.response;
      }
    } finally {
      isLoadingConsultationsDoctors(false);
    }
  }

  var isLoadingConsultationsDoctorProfile = false.obs;
  var consultationsDoctorProfileData =
      consultations_doctor_profile_import.Response().obs;
  var IDDoctor = ''.obs;
  var doctorServiceKey = 'URGENT_CONSULT'.obs;

  setDataDoctorProfile(String id, String serviceKey) async {
    IDDoctor.value = id;
    doctorServiceKey.value = serviceKey;
    getConsultationsDoctorProfile();
    await Get.toNamed(Routes.consultationsDoctorProfileScreen);
  }

  getConsultationsDoctorProfile() async {
    try {
      isLoadingConsultationsDoctorProfile(true);
      var profileResponse =
          await ConsultationsServices.getConsultationsDoctorProfile(
              IDDoctor.value, doctorServiceKey.value);
      if (profileResponse.success) {
        consultationsDoctorProfileData.value = profileResponse.response;
      }
    } finally {
      isLoadingConsultationsDoctorProfile(false);
    }
  }

  var idCity = '0'.obs;
  var isLoadingAreas = false.obs;
  var areasList = <areas_import.Response>[].obs;
  var selectedAreaValue = ''.obs;

  getAreas() async {
    var areas = await ConsultationsServices.getAreA(idCity.value);
    try {
      isLoadingAreas(true);
      if (areas.response.isNotEmpty) {
        areasList.value = areas.response;
      }
    } finally {
      isLoadingAreas(false);
    }
  }

  var isLoadingAnimalsCategory = false.obs;
  var animalsCategoryList = <animals_category_import.Response>[].obs;
  var selectedAnimalsCategoryValue = ''.obs;

  getAnimalsCategory() async {
    var animalsCategory = await ConsultationsServices.getAnimalsCategory();
    try {
      isLoadingAnimalsCategory(true);
      if (animalsCategory.response.isNotEmpty) {
        animalsCategoryList.value = animalsCategory.response;
      }
    } finally {
      isLoadingAnimalsCategory(false);
    }
  }
}
