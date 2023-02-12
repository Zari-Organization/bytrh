import 'package:bytrh/Logic/controllers/verification_controller.dart';
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
import '../../Services/auth_services.dart';
import '../../Utils/app_colors.dart';
import 'dart:developer';

import 'My_Account_Controllers/personal_data_controller.dart';

class AuthController extends GetxController {
  final personalDataController = Get.find<PersonalDataController>();
  Future? setClientCity() {
    idCountry.value = personalDataController.countryIDController.value;
  }

  @override
  void onInit() async {
    super.onInit();
    await setClientCity();
    getCountries();
    await getCities();
    getTerms();
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
          context);
      if (registerModel.success == true) {
        final verificationController = Get.find<VerificationController>();
        verificationController.phoneController.value.text = ClientPhone;
        verificationController.accessToken.value =
            "Bearer ${registerModel.response!.accessToken}";
        log(" Auth Controller -->${verificationController.accessToken.value}");
        verificationController.sendCodeToVerifyAccount(
            verificationController.phoneController.value.text, context);
        // authBox.write(
        //     'AccessToken', "Bearer ${registerModel.response!.accessToken}");
        // authBox.write('userName', registerModel.response!.clientName);
        // GetStorage().read<String>('AccessToken')!;
        // Get.offAllNamed(Routes.mainScreen);
      } else {}
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

  static final _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> googleLogin(BuildContext context) async {
    var result = await _googleSignIn.signIn();
    login(
      result!.email,
      result.id,
      "MANUAL",
      "ar",
      "ANDROID",
      "GMS",
      context,
    );
  }

  Future<GoogleSignInAccount?> googleSignUp(BuildContext context) async {
    var result = await _googleSignIn.signIn();
    register(
      result!.email,
      googleRegisterClientPhoneController.value.text,
      googleRegisterClientPhoneCodeController.value.text,
      result.id,
      result.displayName!,
      "MANUAL",
      "en",
      "ANDROID",
      "GMS",
      "1",
      context,
    );
  }

  var facebookChecking = true.obs;
  AccessToken? facebookAccessToken;
  Map<String, dynamic>? facebookUserData;

  checkIfFacebookLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    facebookChecking.value = false;
    if (accessToken != null) {
      log("checkIfFacebookLoggedIn accessToken --> ${accessToken.toJson().toString()}");
      final userData = await FacebookAuth.instance.getUserData();
      facebookAccessToken = accessToken;
      facebookUserData = userData;
      log("checkIfFacebookLoggedIn facebookAccessToken --> ${facebookAccessToken!.toJson().toString()}");
      log("checkIfFacebookLoggedIn accessToken --> ${facebookUserData.toString()}");
    } else {
      facebookLogin();
    }
  }

  facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      facebookAccessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      facebookUserData = userData;
      log("facebookLogin facebookAccessToken --> ${facebookAccessToken!.toJson().toString()}");
      log("facebookLogin facebookUserData --> ${facebookUserData.toString()}");
      log("facebookLogin facebookUserData Email --> ${facebookUserData!['email']}");
      log("facebookLogin facebookUserData Name --> ${facebookUserData!['name']}");
    } else {
      log(result.status.toString());
      log(result.message.toString());
    }
    facebookChecking.value = false;
  }

  facebookLogout() async {
    await FacebookAuth.instance.logOut();
    facebookAccessToken = null;
    facebookUserData = null;
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
      }
    } finally {
      isLoadingCities(false);
    }
  }
}
