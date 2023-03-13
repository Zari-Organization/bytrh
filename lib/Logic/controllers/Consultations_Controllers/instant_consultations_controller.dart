import 'dart:async';
import 'dart:developer';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Models/Consultations_Models/animals_category_model.dart'
    as animals_category_import;
import '../../../Models/Consultations_Models/consultations_cart_model.dart'
    as consultations_cart_import;
import '../../../Models/Consultations_Models/consultations_doctor_profile_model.dart'
    as consultations_doctor_profile_import;
import '../../../Models/Consultations_Models/consultations_doctor_reservation_time_model.dart'
    as consultations_doctor_reservation_time_import;
import '../../../Models/Consultations_Models/consultations_doctors_model.dart'
    as consultations_doctors_import;
import '../../../Models/Location_Models/areas_model.dart' as areas_import;
import '../../../Routes/routes.dart';
import '../../../Services/Consultations_Services/consultations_services.dart';
import '../../../Utils/app_alerts.dart';
import '../Advertisements_Controllers/advertisements_controller.dart';

class InstantConsultationsController extends GetxController
    with GetTickerProviderStateMixin {
  late Rx<TabController> tabController = TabController(length: 2, vsync: this).obs;
  final advertisementsController = Get.find<AdvertisementsController>();
  @override
  void onInit() async {
    super.onInit();
    tabController.value = TabController(length: 2, vsync: this);
    await getAreas();
    await getAnimalsCategory();
    selectedAreaValue.value = areasList[0].idArea.toString();
    selectedAnimalsCategoryValue.value = animalsCategoryList[0].idAnimalCategory.toString();
    await getConsultationsDoctors();
    await  advertisementsController.getAdvertisements();
  }

  var isLoadingConsultationsDoctors = false.obs;
  var consultationsDoctorsList = <consultations_doctors_import.Response>[].obs;
  var defaultCity = ''.obs;
  var serviceKey = ''.obs;

  var areaTextFieldValue = ''.obs;

  getConsultationsDoctors() async {
    try {
      isLoadingConsultationsDoctors(true);
      var response = await ConsultationsServices.getConsultationsDoctors(
        service: doctorServiceKey.value,
        DoctorName: areaTextFieldValue.value,
        IDArea: selectedAreaValue.value,
        IDAnimalCategory: selectedAnimalsCategoryValue.value,
        ClientLatitude: userLatitude.value,
        ClientLongitude: userLongitude.value,
      );
      if (response.response.isNotEmpty) {
        consultationsDoctorsList.value = response.response;
      }else{
        consultationsDoctorsList.clear();
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
    await Get.toNamed(Routes.instantConsultationsDoctorProfileScreen);
  }

  getConsultationsDoctorProfile() async {
    try {
      isLoadingConsultationsDoctorProfile(true);
      var profileResponse =
          await ConsultationsServices.getConsultationsDoctorProfile(
        IDDoctor.value,
        doctorServiceKey.value,
        "",
      );
      if (profileResponse.success) {
        consultationsDoctorProfileData.value = profileResponse.response;
      }
    } finally {
      isLoadingConsultationsDoctorProfile(false);
    }
  }

  var isLoadingCheckConsultStatusApi = false.obs;
  var idConsultFromCart = ''.obs;

  checkConsultStatus(String consultId, String consultStatus, String serviceKey,
      BuildContext context) async {
    idConsultFromCart.value = consultId;
    AppAlerts().consultationsCountDownPop(
      idConsultFromCart.value,
      consultStatus,
    );
    // checkConsultStatusApi(
    //   idConsultFromCart.value,
    //   consultStatus,
    //   serviceKey,
    //   context,
    // );
  }

  var consultationsCartStatusData =
      consultations_doctor_profile_import.ConsultCountDown().obs;

  checkConsultStatusApi(
    String cartConsultId,
    String consultStatus,
    String doctorServiceKey,
    BuildContext context,
  ) async {
    try {
      isLoadingCheckConsultStatusApi(true);
      var response = await ConsultationsServices.getConsultationsDoctorProfile(
        "",
        doctorServiceKey,
        cartConsultId,
      );
      if (response.success) {
        consultationsCartStatusData.value = response.response.consultCountDown!;
        AppAlerts().consultationsCountDownPop(
          idConsultFromCart.value,
          // consultationsCartStatusData.value,
          consultStatus,
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     duration: Duration(seconds: 2),
        //     content: Text(
        //       consultationsCartStatusData.value.minutes.toString(),
        //     ),
        //   ),
        // );
      }
    } finally {
      isLoadingCheckConsultStatusApi(false);
    }
  }

  var idCity = '0'.obs;
  var isLoadingAreas = false.obs;
  var areasList = <areas_import.Response>[].obs;
  var selectedAreaValue = ''.obs;

  getAreas() async {
    try {
      isLoadingAreas(true);
      var areas = await ConsultationsServices.getAreA(idCity.value);
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

  var isLoadingRequestConsultation = false.obs;

  requestConsultation(String idDoctor, BuildContext context) async {
    try {
      isLoadingRequestConsultation(true);
      var response = await ConsultationsServices.requestConsultation(
        IDDoctor: idDoctor,
      );
      if (response["Success"]) {
        AppAlerts().consultationsCreatedSuccessfullyPop();
        void _goNext() async {
          await getConsultationsCart();
          Get.toNamed(Routes.instantsConsultationsCartScreen);
        }

        Timer(const Duration(seconds: 1), () => Get.back());
        Timer(const Duration(seconds: 1), _goNext);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingRequestConsultation(false);
    }
  }

  var isLoadingConsultationsCart = false.obs;
  var consultationsCartList = <consultations_cart_import.Response>[].obs;

  getConsultationsCart() async {
    try {
      isLoadingConsultationsCart(true);
      var response = await ConsultationsServices.getConsultationsCart(
        ConsultType: "URGENT",
      );
      if (response.response.isNotEmpty) {
        consultationsCartList.value = response.response;
      }
    } finally {
      isLoadingConsultationsCart(false);
    }
  }

  setConsultationsDoctorReservationTime(String id) async {
    idConsult.value = id;
    getConsultationsDoctorReservationTime();
    await Get.toNamed(Routes.instantsConsultationsDoctorReservationTimeScreen);
  }

  var isLoadingConsultationsDoctorReservationTime = false.obs;
  var consultationsDoctorReservationTimeData =
      consultations_doctor_reservation_time_import.Response().obs;
  var consultationsDoctorReservationTimeList =
      <consultations_doctor_reservation_time_import.ConsultTime>[].obs;
  var idConsult = ''.obs;
  var doctorTimeValue = 0.obs;

  RxInt timeSelectedIndex = (-1).obs;
  var timeId = ''.obs;

  void changeTimeSelectedIndex(int selectedIndex) {
    timeSelectedIndex.value = selectedIndex;
    timeId.value = consultationsDoctorReservationTimeList[selectedIndex]
        .idConsultTimeValue
        .toString();
    log(timeId.toString());
  }

  getConsultationsDoctorReservationTime() async {
    try {
      isLoadingConsultationsDoctorReservationTime(true);
      var response =
          await ConsultationsServices.getConsultationsDoctorReservationTime(
        IDConsult: idConsult.value,
      );
      if (response.success) {
        consultationsDoctorReservationTimeData.value = response.response;
        if (response.response.consultTime!.isNotEmpty) {
          consultationsDoctorReservationTimeList.value =
              response.response.consultTime!;
        }
      }
    } finally {
      isLoadingConsultationsDoctorReservationTime(false);
    }
  }

  var isLoadingSelectConsultationTime = false.obs;

  selectConsultationTime(BuildContext context) async {
    try {
      isLoadingSelectConsultationTime(true);
      var response = await ConsultationsServices.selectConsultationTime(
        IDConsult: idConsult.value,
        IDConsultTimeValue: timeId.value,
      );
      if (response["Success"]) {
        AppAlerts().selectDoctorTimeCreatedSuccessfullyPop();
        void _goNext() async {
          await getConsultationsCart();
          Get.back();
        }

        Timer(const Duration(seconds: 1), _goNext);
        Timer(const Duration(seconds: 1), () => Get.back());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingSelectConsultationTime(false);
    }
  }

  var isLoadingLocation = false.obs;

  Future<Position> getGeoLocationPosition() async {
    try {
      isLoadingLocation(true);
      bool serviceEnabled;
      LocationPermission permission;
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        await Geolocator.openLocationSettings();
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } finally {
      onInit();
      isLoadingLocation(false);
    }
  }

  var userLatitude = ''.obs;
  var userLongitude = ''.obs;
}
