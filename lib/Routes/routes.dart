import 'package:get/get.dart';

import '../Logic/binding/auth_binding.dart';
import '../Logic/binding/personal_data_binding.dart';
import '../View/Screens/Auth_Type_Screen/auth_type_screen.dart';
import '../View/Screens/Login_Screen/login_screen.dart';
import '../View/Screens/OnBoarding_Screen/onBoarding_screen.dart';
import '../View/Screens/Personal_Data_Screen/personal_data_screen.dart';
import '../View/Screens/SignUp_Screen/signUp_screen.dart';
import '../View/Screens/SignUp_Type_Screen/signUp_type_screen.dart';
import '../View/Screens/Splash_Screen/splash_screen.dart';

class AppRoutes {
  //initialRoute
  static const splashScreen = Routes.splashScreen;
  static const onBoardingScreen = Routes.onBoardingScreen;
  static const authTypeScreen = Routes.authTypeScreen;
  static const signUpTypeScreen = Routes.signUpTypeScreen;
  static const signUpScreen = Routes.signUpScreen;
  static const confirmationCodeScreen = Routes.confirmationCodeScreen;
  static const loginScreen = Routes.loginScreen;
  static const personalDataScreen = Routes.personalDataScreen;

  //getPages
  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.onBoardingScreen,
      page: () => OnBoardingScreen(),
    ),
    GetPage(
      name: Routes.authTypeScreen,
      page: () => AuthTypeScreenScreen(),
    ),
    GetPage(
      name: Routes.signUpTypeScreen,
      page: () => SignUpTypeScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: Routes.personalDataScreen,
      page: () => PersonalDataScreen(),
      binding: PersonalDataBinding(),
    ),
  ];
}

class Routes {
  static const splashScreen = '/splashScreen';
  static const onBoardingScreen = '/onBoardingScreen';
  static const authTypeScreen = '/authTypeScreen';
  static const signUpTypeScreen = '/signUpTypeScreen';
  static const signUpScreen = '/signUpScreen';
  static const confirmationCodeScreen = '/confirmationCodeScreen';
  static const loginScreen = '/loginScreen';
  static const personalDataScreen = '/personalDataScreen';
}
