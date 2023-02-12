import 'package:bytrh/View/Screens/Auth_Screens/Policies_Screens/terms_screen.dart';
import 'package:get/get.dart';

import '../Logic/binding/My_Account_Bindings/change_password_binding.dart';
import '../Logic/binding/My_Account_Bindings/myAccount_binding.dart';
import '../Logic/binding/Wallet_Bindings/wallet_binding.dart';
import '../Logic/binding/auth_binding.dart';
import '../Logic/binding/main_binding.dart';
import '../Logic/binding/My_Account_Bindings/personal_data_binding.dart';
import '../Logic/binding/verification_binding.dart';
import '../View/Screens/Auth_Screens/Auth_Type_Screen/auth_type_screen.dart';
import '../View/Screens/Auth_Screens/Forget_Password_Screens/Screens/forget_password_screen.dart';
import '../View/Screens/Auth_Screens/Forget_Password_Screens/Screens/newPassword_Screen.dart';
import '../View/Screens/Auth_Screens/Forget_Password_Screens/Screens/verify_resetPassCode_screen.dart';
import '../View/Screens/Auth_Screens/Login_Screen/login_screen.dart';
import '../View/Screens/Auth_Screens/OnBoarding_Screen/onBoarding_screen.dart';
import '../View/Screens/Auth_Screens/SignUp_Screen/signUp_screen.dart';
import '../View/Screens/Auth_Screens/SignUp_Screen/social_signUp_screen.dart';
import '../View/Screens/Auth_Screens/SignUp_Type_Screen/signUp_type_screen.dart';
import '../View/Screens/Auth_Screens/verify_account_screen.dart';
import '../View/Screens/Main_Screen/main_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/Wallet_Screens/card_gift_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/Wallet_Screens/wallet_payment_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/Wallet_Screens/wallet_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/aboutUs_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/change_password_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/contactUs_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/personal_data_screen.dart';
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
  static const mainScreen = Routes.mainScreen;
  static const personalDataScreen = Routes.personalDataScreen;
  static const changePasswordScreen = Routes.changePasswordScreen;
  static const contactUsScreen = Routes.contactUsScreen;
  static const forgetPasswordScreen = Routes.forgetPasswordScreen;
  static const verifyResetPassCodeScreen = Routes.verifyResetPassCodeScreen;
  static const newPassScreen = Routes.newPassScreen;
  static const verifyAccountScreen = Routes.verifyAccountScreen;
  static const socialSignUpScreen = Routes.socialSignUpScreen;
  static const walletScreen = Routes.walletScreen;
  static const walletPaymentScreen = Routes.walletPaymentScreen;
  static const cardGiftScreen = Routes.cardGiftScreen;
  static const aboutUsScreen = Routes.aboutUsScreen;
  static const termsScreen = Routes.termsScreen;

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
      // binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
      bindings: [
        AuthBinding(),
        VerificationBinding(),
      ],
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => SignUpScreen(),
      bindings: [
        AuthBinding(),
        VerificationBinding(),
      ],
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      bindings: [
        MainBinding(),
      ],
    ),
    GetPage(
      name: Routes.personalDataScreen,
      page: () => PersonalDataScreen(),
      bindings: [
        AuthBinding(),
        PersonalDataBinding(),
      ],
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Routes.contactUsScreen,
      page: () => ContactUsScreen(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: Routes.forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: Routes.verifyResetPassCodeScreen,
      page: () => VerifyResetPassCodeScreen(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: Routes.newPassScreen,
      page: () => NewPasswordScreen(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: Routes.verifyAccountScreen,
      page: () => VerifyAccountScreen(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: Routes.socialSignUpScreen,
      page: () => SocialSignUpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.walletScreen,
      page: () => WalletScreen(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: Routes.walletPaymentScreen,
      page: () => WalletPaymentScreen(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: Routes.cardGiftScreen,
      page: () => CardGiftScreen(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: Routes.aboutUsScreen,
      page: () => AboutUsScreen(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: Routes.termsScreen,
      page: () => TermsScreen(),
      binding: AuthBinding(),
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
  static const mainScreen = '/mainScreen';
  static const changePasswordScreen = '/changePasswordScreen';
  static const contactUsScreen = '/contactUsScreen';
  static const forgetPasswordScreen = '/forgetPasswordScreen';
  static const verifyResetPassCodeScreen = '/verifyResetPassCodeScreen';
  static const newPassScreen = '/newPassScreen';
  static const verifyAccountScreen = '/verifyAccountScreen';
  static const socialSignUpScreen = '/socialSignUpScreen';
  static const walletScreen = '/walletScreen';
  static const walletPaymentScreen = '/walletPaymentScreen';
  static const cardGiftScreen = '/cardGiftScreen';
  static const aboutUsScreen = '/aboutUsScreen';
  static const termsScreen = '/termsScreen';
}
