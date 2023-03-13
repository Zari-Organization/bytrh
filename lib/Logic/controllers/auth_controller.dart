import 'package:bytrh/Logic/controllers/verification_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Models/Auth_Models/login_model.dart';
import '../../Models/Auth_Models/register_model.dart';
import '../../Models/Location_Models/countries_model.dart' as countries_import;
import '../../Models/Location_Models/cities_model.dart' as cities_import;
import '../../Routes/routes.dart';
import '../../Services/Consultations_Services/consultations_services.dart';
import '../../Services/auth_services.dart';
import '../../Utils/app_colors.dart';
import 'dart:developer';

import 'My_Account_Controllers/personal_data_controller.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../../Models/Consultations_Models/animals_category_model.dart'
as animals_category_import;
class AuthController extends GetxController {
  // final personalDataController = Get.find<PersonalDataController>();

  Future? setClientCity() {
    // idCountry.value = personalDataController.countryIDController.value;
    idCountry.value = defaultCountry.value;
    log(defaultCountry.value);
  }

  @override
  void onInit() async {
    super.onInit();
    await getAnimalsCategory();
    selectedAnimalsCategoryValue.value =  animalsCategoryList[0].idAnimalCategory.toString();
    await getLocation();
    await getCountries();
    await setClientCity();
    await getCities();
    getTerms();
    tz.initializeTimeZones();
  }

  var isLogInLoading = false.obs;
  var termsCheck = false.obs;
  var isSecureLoginPass = true.obs;
  var loginUserNameController = TextEditingController().obs;
  var loginClientPhoneCodeController = TextEditingController().obs;
  var loginPasswordController = TextEditingController().obs;
  var loginPhoneWithoutCodeController = TextEditingController().obs;
  final authBox = GetStorage();

  Future login(
    String UserName,
    String Password,
    String LoginBy,
    String ClientAppLanguage,
    String ClientDeviceType,
    String ClientMobileService,
    String ClientDeviceToken,
    BuildContext context,
  ) async {
    try {
      isLogInLoading(true);
      LoginModel loginModel = await AuthServices().loginAPI(
        UserName,
        Password,
        LoginBy,
        ClientAppLanguage,
        ClientDeviceType,
        ClientMobileService,
        ClientDeviceToken,
        context,
      );
      if (loginModel.success) {
        log(
          loginModel.apiMsg,
        );

        authBox.write(
            'AccessToken', "Bearer ${loginModel.response!.accessToken}");
        authBox.write('userName', loginModel.response!.clientName);
        GetStorage().read<String>('AccessToken')!;
        Get.offAllNamed(Routes.mainScreen);
      } else {}
    } finally {
      isLogInLoading(false);
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

  var isSecureRegisterPass = true.obs;
  var isSecureRegisterConfirmPass = true.obs;
  var isRegisterLoading = false.obs;
  var registerClientEmailController = TextEditingController().obs;
  var registerClientPhoneController = TextEditingController().obs;
  var registerClientPhoneCodeController = TextEditingController().obs;
  var registerClientPhoneFlagController = TextEditingController().obs;
  var registerClientPasswordController = TextEditingController().obs;
  var registerClientPasswordConfirmController = TextEditingController().obs;
  var registerClientNameController = TextEditingController().obs;
  var registerLoginByController = TextEditingController().obs;
  var registerClientAppLanguageController = TextEditingController().obs;
  var registerClientDeviceTypeController = TextEditingController().obs;
  var registerClientMobileServiceController = TextEditingController().obs;



  Future register(
    String ClientEmail,
    String ClientPhone,
    String ClientPhoneFlag,
    String ClientPassword,
    String ClientName,
    String LoginBy,
    String ClientAppLanguage,
    String ClientDeviceType,
    String ClientMobileService,
    String IDCity,
    String IDAnimalCategory,
    BuildContext context,
  ) async {
    try {
      isRegisterLoading(true);
      RegisterModel registerModel = await AuthServices().registerAPI(
          ClientEmail,
          ClientPhone,
          ClientPhoneFlag,
          ClientPassword,
          ClientName,
          LoginBy,
          ClientAppLanguage,
          ClientDeviceType,
          ClientMobileService,
          IDCity,
          IDAnimalCategory,
          context);
      if (registerModel.success == true) {
        log("registerModel success --> ${registerModel.success}");
        if (LoginBy != "MANUAL") {
          final authBox = GetStorage();
          await authBox.write(
              'AccessToken', "Bearer ${registerModel.response!.accessToken}");
          GetStorage().read<String>('AccessToken')!;
          Get.offAllNamed(Routes.mainScreen);
        } else {
          final verificationController = Get.find<VerificationController>();
          verificationController.phoneController.value.text = ClientPhone;
          verificationController.accessToken.value =
              "Bearer ${registerModel.response!.accessToken}";
          log("Auth Controller -->${verificationController.accessToken.value}");
          verificationController.sendCodeToVerifyAccount(
            verificationController.phoneController.value.text,
            context,
          );
        }
        // authBox.write(
        //     'AccessToken', "Bearer ${registerModel.response!.accessToken}");
        // authBox.write('userName', registerModel.response!.clientName);
        // GetStorage().read<String>('AccessToken')!;
        // Get.offAllNamed(Routes.mainScreen);
      } else {
        log("registerModel Error  --> ${registerModel.success}");
      }
    } finally {
      isRegisterLoading(false);
    }
  }

  var countryNameController = "".obs;
  var cityNameController = "".obs;
  var cityID = "".obs;

  var googleRegisterClientPhoneController = TextEditingController().obs;
  var googleRegisterClientPhoneCodeController = TextEditingController().obs;
  var googleRegisterPhoneWithoutCodeController = TextEditingController().obs;

  // function to implement the google signin

// creating firebase instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      // throw e;
    }
  }

  Future<void> newGoogleLogin(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
        // scopes: [
        //   'email',
        //   'https://www.googleapis.com/auth/contacts.readonly',
        // ],
        );
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    log("new google ${googleSignInAccount.toString()}");
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      log("googleSignInAuthentication --> ${googleSignInAuthentication.accessToken.toString()}");
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      log("authCredential --> ${authCredential.accessToken.toString()}");
      // Getting users credential
      try {
        // UserCredential result = await auth.signInWithCredential(authCredential);
        final authResult = await auth.signInWithCredential(authCredential);
        log("result --> ${authResult.user.toString()}");
        // User? user = result.user;
        // if (result != null) {
        //   log("user --> ${user.toString()}");
        // }
      } catch (e) {
        log("Error: $e");
      }
    }
  }

  static final _googleSignIn = GoogleSignIn(
      // scopes: [
      //   'email',
      //   'https://www.googleapis.com/auth/contacts.readonly',
      // ],
      );

  Future<UserCredential?> facebookLogin(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      final accessToken = result.accessToken;
      log("userId --> ${accessToken!.userId}");
      login(
        accessToken.userId,
        accessToken.userId,
        "FACEBOOK",
        "ar",
        "ANDROID",
        "GMS",
        GetStorage().read('DeviceToken'),
        context,
      );
    } else {
      log(result.status.toString());
      log(result.message.toString());
    }
  }

  Future<UserCredential?> facebookSignUp(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      final accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      log("userId --> ${accessToken!.userId}");
      log("userData --> ${userData["name"]}");
      register(
        "",
        "",
        "",
        accessToken.userId,
        userData["name"] ?? "",
        "FACEBOOK",
        "ar",
        "ANDROID",
        "GMS",
        defaultCity.value,
        selectedAnimalsCategoryValue.value,
        context,
      );
    } else {
      log(result.status.toString());
      log(result.message.toString());
    }
  }


  Future<GoogleSignInAccount?> googleLogin(BuildContext context) async {
    var result = await _googleSignIn.signIn();
    log(result.toString());
    login(
      result!.id,
      result.id,
      "GOOGLE",
      "ar",
      "ANDROID",
      "GMS",
      GetStorage().read('DeviceToken'),
      context,
    );
  }

  Future<GoogleSignInAccount?> googleSignUp(BuildContext context) async {
    var result = await _googleSignIn.signIn();
    log(result.toString());
    register(
      "",
      "",
      "",
      result!.id,
      result.displayName ?? "",
      "GOOGLE",
      "ar",
      "ANDROID",
      "GMS",
      defaultCity.value,
      selectedAnimalsCategoryValue.value,
      context,
    );
  }

  var isLoadingTerms = false.obs;
  RxString? termsData = "".obs;

  getTerms() async {
    try {
      isLoadingTerms(true);
      var response = await AuthServices.getTerms();
      if (response["Success"]) {
        termsData!.value = response["Response"];
      }
    } finally {
      isLoadingTerms(false);
    }
  }

  var isLoadingCountries = false.obs;
  var countriesList = <countries_import.Country>[].obs;
  var defaultCountry = ''.obs;

  getCountries() async {
    var countries = await AuthServices.getCountries();
    try {
      isLoadingCountries(true);
      if (countries.response.countries.isNotEmpty) {
        countriesList.addAll(countries.response.countries);
        defaultCountry.value = countries.response.idCountry.toString();
        countryNameController.value = countries.response.countryName;
      }
    } finally {
      isLoadingCountries(false);
    }
  }

  var idCountry = ''.obs;
  var isLoadingCities = false.obs;
  var citiesList = <cities_import.Country>[].obs;
  var defaultCity = ''.obs;

  getCities() async {
    var cities = await AuthServices.getCities(idCountry.value);
    try {
      isLoadingCities(true);
      if (cities.response.countries.isNotEmpty) {
        citiesList.addAll(cities.response.countries);
        defaultCity.value = cities.response.idCity.toString();
        cityNameController.value = cities.response.cityName;
      }
    } finally {
      isLoadingCities(false);
    }
  }

  var locationCountryCode = ''.obs;
  var isLoadingLocation = false.obs;

  getLocation() async {
    try {
      isLoadingLocation(true);
      var response = await AuthServices.getLocation();
      if (response['status'] == "success") {
        locationCountryCode.value = await response['countryCode'];
        log("CC Api ---> ${locationCountryCode.value}");
      }
    } finally {
      isLoadingLocation(false);
    }
  }
}
