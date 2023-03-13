import 'dart:async';
import 'dart:developer';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../Models/Consultations_Models/animals_category_model.dart'
    as animals_category_import;
import '../../../Models/Consultations_Models/terms_consultations_cart_model.dart'
    as consultations_cart_import;
import '../../../Models/Consultations_Models/consultations_cart_model.dart'
    as consultations_list_import;
import '../../../Models/Consultations_Models/consultations_doctor_profile_model.dart'
    as consultations_doctor_profile_import;
import '../../../Models/Consultations_Models/consultations_doctor_reservation_time_model.dart'
    as consultations_doctor_reservation_time_import;
import '../../../Models/Consultations_Models/consultations_doctors_model.dart'
    as consultations_doctors_import;
import '../../../Models/Consultations_Models/term_doctor_days_model.dart'
    as term_doctor_days_import;
import '../../../Models/Location_Models/areas_model.dart' as areas_import;
import '../../../Routes/routes.dart';
import '../../../Services/Consultations_Services/consultations_services.dart';
import '../../../Utils/app_alerts.dart';
import '../Advertisements_Controllers/advertisements_controller.dart';

class TermConsultationsController extends GetxController
    with GetTickerProviderStateMixin {
  late Rx<TabController> tabController =
      TabController(length: 2, vsync: this).obs;
  final advertisementsController = Get.find<AdvertisementsController>();

  @override
  void onInit() async {
    super.onInit();
    tabController.value = TabController(length: 2, vsync: this);
    await getAreas();
    await getAnimalsCategory();
    selectedAreaValue.value = areasList[0].idArea.toString();
    selectedAnimalsCategoryValue.value =
        animalsCategoryList[0].idAnimalCategory.toString();
    selectedDoctorDay.value =
        DateFormat('EEEE').format(DateTime.now()).toUpperCase();
    selectedDoctorDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    selectedDoctorDayLocale.value =
        DateFormat.EEEE('ar')
            .format(DateTime.now())
            .toUpperCase();
    selectedDoctorDateLocale.value =
        DateFormat.yMd('ar')
            .format(DateTime.now());
    await getConsultationsDoctors();
    await  advertisementsController.getAdvertisements();
  }

  var isLoadingConsultationsDoctors = false.obs;
  var consultationsDoctorsList = <consultations_doctors_import.Response>[].obs;
  var defaultCity = ''.obs;
  var serviceKey = ''.obs;
  var areaTextFieldValue = ''.obs;

  var doctorChecked = <int>[].obs;

  checkSelectedDoctors(bool? value) {}

  void onSelectedDoctor(bool selected, int dataName) {
    if (selected == true) {
      doctorChecked.add(dataName);
      log(doctorChecked.toString());
    } else {
      doctorChecked.remove(dataName);
      log(doctorChecked.toString());
    }
  }

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
      } else {
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
  var IDDoctorConsult = ''.obs;
  var doctorServiceKey = 'CONSULT'.obs;

  setDataDoctorProfile(String id, String serviceKey) async {
    IDDoctorConsult.value = id;
    doctorServiceKey.value = serviceKey;
    getConsultationsDoctorProfile(IDDoctorConsult.value);
    await Get.toNamed(Routes.termConsultationsDoctorProfileScreen);
  }

  getConsultationsDoctorProfile(String consultId) async {
    try {
      isLoadingConsultationsDoctorProfile(true);
      var profileResponse = await ConsultationsServices.getConsultationsDoctorProfile(
        "",
        doctorServiceKey.value,
        consultId,
      );
      if (profileResponse.success) {
        consultationsDoctorProfileData.value = profileResponse.response;
        setDoctorProfileDays(
            consultationsDoctorProfileData.value.idDoctor.toString());
      }
    } finally {
      isLoadingConsultationsDoctorProfile(false);
    }
  }

  setDataDoctorProfileFromAdvertisement(String id, String serviceKey) async {
    IDDoctor.value = id;
    doctorServiceKey.value = serviceKey;
    getConsultationsDoctorProfileFromAdvertisement(IDDoctor.value);
    await Get.toNamed(Routes.termConsultationsDoctorProfileScreen);
  }

  getConsultationsDoctorProfileFromAdvertisement(String doctorId) async {
    try {
      isLoadingConsultationsDoctorProfile(true);
      var profileResponse = await ConsultationsServices.getConsultationsDoctorProfile(
        doctorId,
        doctorServiceKey.value,
        "",
      );
      if (profileResponse.success) {
        consultationsDoctorProfileData.value = profileResponse.response;
        setDoctorProfileDays(
            consultationsDoctorProfileData.value.idDoctor.toString());
      }
    } finally {
      isLoadingConsultationsDoctorProfile(false);
    }
  }

  var idConsultFromCart = ''.obs;

  checkConsultStatus(String consultId, String consultStatus, String serviceKey,
      BuildContext context) async {
    idConsultFromCart.value = consultId;
    AppAlerts().consultationsCountDownPop(
      idConsultFromCart.value,
      consultStatus,
    );
  }

  var isLoadingCheckConsultStatusApi = false.obs;
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

  var isLoadingConsultationsList = false.obs;
  var consultationsList = <consultations_list_import.Response>[].obs;

  getConsultationsList() async {
    try {
      isLoadingConsultationsList(true);
      var response = await ConsultationsServices.getConsultationsList(
        ConsultType: "NORMAL",
      );
      log("Consultations List Controller --> ${response.response.length}");
      if (response.response.isNotEmpty) {
        consultationsList.value = response.response;
        log("Consultations List Controller --> ${consultationsCartList.length}");
      }
    } finally {
      isLoadingConsultationsList(false);
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
      var response = await ConsultationsServices.getTermsConsultationsCart();
      log("Consultations Cart Controller --> ${response.response.length}");
      if (response.success) {
        consultationsCartList.value = response.response;
        log("Consultations Cart Controller --> ${consultationsCartList.length}");
      }
    } finally {
      isLoadingConsultationsCart(false);
    }
  }

  var isLoadingRemoveConsultationsCart = false.obs;

  removeConsultationsCart({ required String IDConsultCart , required BuildContext context}) async {
    try {
      isLoadingRemoveConsultationsCart(true);
      var response =
      await ConsultationsServices.removeConsultationCart(
        IDConsultCart: IDConsultCart,
      );
      if (response["Success"]) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: AppColors.MAIN_COLOR,
        //     duration: Duration(seconds: 2),
        //     content: Text(
        //       response["ApiMsg"].toString(),
        //     ),
        //   ),
        // );
        getConsultationsCart();
      }else{
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
      isLoadingRemoveConsultationsCart(false);
    }
  }

  // setConsultationsDoctorReservationTime(String id) async {
  //   idConsult.value = id;
  //   getConsultationsDoctorReservationTime();
  //   await Get.toNamed(Routes.instantsConsultationsDoctorReservationTimeScreen);
  // }

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

  var doctorHourId = ''.obs;

  setDoctorConsultTime(String ConsultDate, BuildContext context) {
    selectDoctorConsultationTime(IDDoctor.value, doctorHourId.value, ConsultDate, context);
    log(doctorHourId.value);
  }

  RxInt daySelectedIndex = (-1).obs;

  void changeSelectedIndex(int selectedIndex, String idHour) {
    daySelectedIndex.value = selectedIndex;
    doctorHourId.value = idHour;
  }

  var isLoadingSelectConsultationTime = false.obs;

  selectDoctorConsultationTime(String IDDoctor, String IDDoctorHour, String ConsultDate, BuildContext context) async {
    try {
      isLoadingSelectConsultationTime(true);
      var response = await ConsultationsServices.selectDoctorConsultationTime(
        IDDoctor: IDDoctor,
        IDDoctorHour: IDDoctorHour,
        ConsultDate: ConsultDate,
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

  var selectedDoctorDay = ''.obs;
  var selectedDoctorDate = ''.obs;
  var selectedDoctorDayLocale = ''.obs;
  var selectedDoctorDateLocale = ''.obs;

  // var selectedDoctorProfileDayValue = ''.obs;
  // var doctorProfileDays = [
  //   "Saturday",
  //   "Sunday",
  //   "Monday",
  //   "Tuesday",
  //   "Wednesday",
  //   "Thursday",
  //   "Friday",
  // ].obs;

  setDoctorProfileDays(String idDoctor) async {
    getConsultationsDoctorsDays(idDoctor);
  }

  var isLoadingConsultationsDoctorsDays = false.obs;
  var consultationsDoctorsDaysList = <term_doctor_days_import.Response>[].obs;

  getConsultationsDoctorsDays(String idDoctor) async {
    try {
      isLoadingConsultationsDoctorsDays(true);
      var response = await ConsultationsServices.getConsultationsDoctorsDays(
        IDDoctor: idDoctor,
        Day: selectedDoctorDay.value,
        Date: selectedDoctorDate.value,
      );
      if (response.response.isNotEmpty) {
        consultationsDoctorsDaysList.clear();
        consultationsDoctorsDaysList.value = response.response;
      } else {
        consultationsDoctorsDaysList.clear();
      }
    } finally {
      isLoadingConsultationsDoctorsDays(false);
    }
  }

  var isLoadingTermRequestConsult = false.obs;
  var requestConsultNoteController = TextEditingController(text: "").obs;

  termRequestConsult({required String ConsultNote,required BuildContext context}) async {
    try {
      isLoadingTermRequestConsult(true);
      var response = await ConsultationsServices.termRequestConsult(
          ConsultNote : ConsultNote
      );
      if (response["Success"]) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      } else {
        Get.back();
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
      isLoadingTermRequestConsult(false);
    }
  }

  // termRequestConsult({
  //   dynamic listDays,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     isLoadingTermRequestConsult(true);
  //     var response = await ConsultationsServices().termRequestConsult(
  //       listDays,
  //     );
  //     if (response["Success"]) {
  //       getConsultationsCart();
  //       await Get.toNamed(Routes.termConsultationsCartScreen);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           duration: Duration(seconds: 2),
  //           content: Text(
  //             response["ApiMsg"].toString(),
  //           ),
  //         ),
  //       );
  //     }
  //   } finally {
  //     isLoadingTermRequestConsult(false);
  //     doctorChecked.clear();
  //   }
  // }
}
