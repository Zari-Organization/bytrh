import 'package:bytrh/View/Screens/Auth_Screens/Policies_Screens/terms_screen.dart';
import 'package:bytrh/View/Screens/NavBar_Screens/My_Account_Screen/Screens/chat_support_screen.dart';
import 'package:get/get.dart';

import '../Logic/binding/Adoption_Bindings/adoption_binding.dart';
import '../Logic/binding/Consultations_Bindings/instant_consultations_binding.dart';
import '../Logic/binding/Consultations_Bindings/term_consultations_binding.dart';
import '../Logic/binding/Consultations_Chat_Bindings/consultations_chat_binding.dart';
import '../Logic/binding/My_Account_Bindings/change_password_binding.dart';
import '../Logic/binding/My_Account_Bindings/myAccount_binding.dart';
import '../Logic/binding/Products_Bindings/products_binding.dart';
import '../Logic/binding/Wallet_Bindings/wallet_binding.dart';
import '../Logic/binding/advertisements_binding.dart';
import '../Logic/binding/auth_binding.dart';
import '../Logic/binding/home_binding.dart';
import '../Logic/binding/main_binding.dart';
import '../Logic/binding/My_Account_Bindings/personal_data_binding.dart';
import '../Logic/binding/my_animals_binding.dart';
import '../Logic/binding/verification_binding.dart';
import '../View/Screens/Auth_Screens/Auth_Type_Screen/auth_type_screen.dart';
import '../View/Screens/Auth_Screens/Forget_Password_Screens/Screens/forget_password_screen.dart';
import '../View/Screens/Auth_Screens/Forget_Password_Screens/Screens/newPassword_Screen.dart';
import '../View/Screens/Auth_Screens/Forget_Password_Screens/Screens/verify_resetPassCode_screen.dart';
import '../View/Screens/Auth_Screens/Login_Screen/login_screen.dart';
import '../View/Screens/Auth_Screens/OnBoarding_Screen/onBoarding_screen.dart';
import '../View/Screens/Auth_Screens/SignUp_Screen/signUp_screen.dart';
import '../View/Screens/Auth_Screens/SignUp_Type_Screen/signUp_type_screen.dart';
import '../View/Screens/Auth_Screens/verify_account_screen.dart';
import '../View/Screens/Main_Screen/main_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/Adoption_Chat_Screen/adoption_chat_list_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/Adoption_Chat_Screen/adoption_chat_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/Adoption_Chat_Screen/my_adoption_chat_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/adoption_add_animal_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/adoption_details_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/adoption_edit_my_animal_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/adoption_my_animals_details_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/adoption_my_animals_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/adoption_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Adoption_Screens/Adoption_Chat_Screen/my_adoption_chat_list_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Chat_Screen/chat_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Instant_Consultations_Screen/Screens/Consultations_Doctor_Profile_Screen/consultations_doctor_profile_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Instant_Consultations_Screen/Screens/Consultations_Doctor_Profile_Screen/instants_consultations_doctor_reservation_time_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Instant_Consultations_Screen/Screens/Instant_Consultations_Cart_Screen/instant_consultations_cart_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Instant_Consultations_Screen/instant_consultations_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Term_Consultation_Screen/Screens/Term_Consultations_Cart_Screen/term_consultations_cart_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Term_Consultation_Screen/Screens/Terms_Consultations_Doctor_Profile_Screen/terms_consultations_doctor_profile_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Term_Consultation_Screen/Screens/Terms_Consultations_List_Screen/terms_consultations_list_screen.dart';
import '../View/Screens/NavBar_Screens/Home_Screen/Screens/Term_Consultation_Screen/term_consultations_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/Wallet_Screens/card_gift_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/Wallet_Screens/wallet_payment_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/Wallet_Screens/wallet_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/aboutUs_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/change_password_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/contactUs_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/my_animals_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/my_bookmarks_screen.dart';
import '../View/Screens/NavBar_Screens/My_Account_Screen/Screens/personal_data_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/Chat_Screens/products_chat_list_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/Chat_Screens/products_chat_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/product_details_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/product_purchase_options_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/product_set_delivery_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/products_add_animal_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/products_animals_requests_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/products_edit_animal_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/products_screen.dart';
import '../View/Screens/NavBar_Screens/Products_Screen/sub_categories_screen.dart';
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
  static const walletScreen = Routes.walletScreen;
  static const walletPaymentScreen = Routes.walletPaymentScreen;
  static const cardGiftScreen = Routes.cardGiftScreen;
  static const aboutUsScreen = Routes.aboutUsScreen;
  static const termsScreen = Routes.termsScreen;
  static const instantConsultationsScreen = Routes.instantConsultationsScreen;
  static const instantConsultationsDoctorProfileScreen = Routes.instantConsultationsDoctorProfileScreen;
  static const instantsConsultationsCartScreen =
      Routes.instantsConsultationsCartScreen;
  static const instantsConsultationsDoctorReservationTimeScreen = Routes.instantsConsultationsDoctorReservationTimeScreen;
  static const consultationsChatScreenScreen = Routes.consultationsChatScreenScreen;
  static const termConsultationsScreen = Routes.termConsultationsScreen;
  static const termConsultationsDoctorProfileScreen = Routes.termConsultationsDoctorProfileScreen;
  static const termConsultationsCartScreen = Routes.termConsultationsCartScreen;
  static const termConsultationsListScreen = Routes.termConsultationsListScreen;
  static const adoptionScreen = Routes.adoptionScreen;
  static const adoptionDetailsScreen = Routes.adoptionDetailsScreen;
  static const adoptionAddAnimalScreen = Routes.adoptionAddAnimalScreen;
  static const adoptionMyAnimalsScreen = Routes.adoptionMyAnimalsScreen;
  static const adoptionMyAnimalsDetailsScreen = Routes.adoptionMyAnimalsDetailsScreen;
  static const adoptionEditMyAnimalScreen = Routes.adoptionEditMyAnimalScreen;
  static const myAdoptionChatListScreen = Routes.myAdoptionChatListScreen;
  static const myAdoptionChatScreen = Routes.myAdoptionChatScreen;
  static const adoptionChatListScreen = Routes.adoptionChatListScreen;
  static const adoptionChatScreen = Routes.adoptionChatScreen;
  static const chatSupportScreen = Routes.chatSupportScreen;
  static const subCategoriesScreen = Routes.subCategoriesScreen;
  static const productsScreen = Routes.productsScreen;
  static const productDetailsScreen = Routes.productDetailsScreen;
  static const productPurchaseOptionsScreen = Routes.productPurchaseOptionsScreen;
  static const myAnimalsScreen = Routes.myAnimalsScreen;
  static const productsAddAnimalScreen = Routes.productsAddAnimalScreen;
  static const productsEditAnimalScreen = Routes.productsEditAnimalScreen;
  static const productsAnimalsRequestsScreen = Routes.productsAnimalsRequestsScreen;
  static const productsChatScreen = Routes.productsChatScreen;
  static const productsChatListScreen = Routes.productsChatListScreen;
  static const myBookmarksScreen = Routes.myBookmarksScreen;
  static const productSetDeliveryTimeScreen = Routes.productSetDeliveryTimeScreen;

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
        // ProductsBinding(),
        MainBinding(),
        AdvertisementsBinding(),
        HomeBinding(),
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
    GetPage(
        name: Routes.instantConsultationsScreen,
        page: () => InstantConsultationsScreen(),
        binding: InstantConsultationsBinding()),
    GetPage(
      name: Routes.instantConsultationsDoctorProfileScreen,
      page: () => InstantConsultationsDoctorProfileScreen(),
      binding: InstantConsultationsBinding(),
    ),
    GetPage(
      name: Routes.instantsConsultationsCartScreen,
      page: () => InstantsConsultationsCartScreen(),
      binding: InstantConsultationsBinding(),
    ),
    GetPage(
      name: Routes.instantsConsultationsDoctorReservationTimeScreen,
      page: () => InstantsConsultationsDoctorReservationTimeScreen(),
      binding: InstantConsultationsBinding(),
    ),
    GetPage(
      name: Routes.consultationsChatScreenScreen,
      page: () => ConsultationsChatScreen(),
      binding: ConsultationsChatBinding(),
    ),
    GetPage(
      name: Routes.termConsultationsScreen,
      page: () => TermConsultationsScreen(),
      binding: TermConsultationsBinding(),
    ),
    GetPage(
      name: Routes.termConsultationsDoctorProfileScreen,
      page: () => TermConsultationsDoctorProfileScreen(),
      binding: TermConsultationsBinding(),
    ),
    GetPage(
      name: Routes.termConsultationsCartScreen,
      page: () => TermConsultationsCartScreen(),
      binding: TermConsultationsBinding(),
    ),    GetPage(
      name: Routes.termConsultationsListScreen,
      page: () => TermConsultationsListScreen(),
      binding: TermConsultationsBinding(),
    ),
    GetPage(
      name: Routes.adoptionScreen,
      page: () => AdoptionScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.adoptionDetailsScreen,
      page: () => AdoptionDetailsScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.adoptionAddAnimalScreen,
      page: () => AdoptionAddAnimalScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.adoptionMyAnimalsScreen,
      page: () => AdoptionMyAnimalsScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.adoptionMyAnimalsDetailsScreen,
      page: () => AdoptionMyAnimalsDetailsScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.adoptionEditMyAnimalScreen,
      page: () => AdoptionEditMyAnimalScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.myAdoptionChatListScreen,
      page: () => MyAdoptionChatListScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.myAdoptionChatScreen,
      page: () => MyAdoptionChatScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.adoptionChatListScreen,
      page: () => AdoptionChatListScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.adoptionChatScreen,
      page: () => AdoptionChatScreen(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: Routes.chatSupportScreen,
      page: () => ChatSupportScreen(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: Routes.subCategoriesScreen,
      page: () => SubCategoriesScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productsScreen,
      page: () => ProductsScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productDetailsScreen,
      page: () => ProductDetailsScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productPurchaseOptionsScreen,
      page: () => ProductPurchaseOptionsScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.myAnimalsScreen,
      page: () => MyAnimalsScreen(),
      binding: MyAnimalsBinding(),
    ),
    GetPage(
      name: Routes.productsAddAnimalScreen,
      page: () => ProductsAddAnimalScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productsEditAnimalScreen,
      page: () => ProductsEditAnimalScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productsAnimalsRequestsScreen,
      page: () => ProductsAnimalsRequestsScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productsChatScreen,
      page: () => ProductsChatScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productsChatListScreen,
      page: () => ProductsChatListScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.myBookmarksScreen,
      page: () => MyBookmarksScreen(),
      // binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productSetDeliveryTimeScreen,
      page: () => ProductSetDeliveryTimeScreen(),
      // binding: ProductsBinding(),
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
  static const walletScreen = '/walletScreen';
  static const walletPaymentScreen = '/walletPaymentScreen';
  static const cardGiftScreen = '/cardGiftScreen';
  static const aboutUsScreen = '/aboutUsScreen';
  static const termsScreen = '/termsScreen';
  static const instantConsultationsScreen = '/instantConsultationsScreen';
  static const instantConsultationsDoctorProfileScreen = '/instantConsultationsDoctorProfileScreen';
  static const instantsConsultationsCartScreen =
      '/instantsConsultationsCartScreen';
  static const instantsConsultationsDoctorReservationTimeScreen = '/instantsConsultationsDoctorReservationTimeScreen';
  static const consultationsChatScreenScreen = '/consultationsChatScreenScreen';
  static const termConsultationsScreen = '/termConsultationsScreen';
  static const termConsultationsDoctorProfileScreen = '/termConsultationsDoctorProfileScreen';
  static const termConsultationsCartScreen = '/termConsultationsCartScreen';
  static const termConsultationsListScreen = '/TermConsultationsListScreen';
  static const adoptionScreen = '/adoptionScreen';
  static const adoptionDetailsScreen = '/adoptionDetailsScreen';
  static const adoptionAddAnimalScreen = '/adoptionAddAnimalScreen';
  static const adoptionMyAnimalsScreen = '/adoptionMyAnimalsScreen';
  static const adoptionMyAnimalsDetailsScreen = '/adoptionMyAnimalsDetailsScreen';
  static const adoptionEditMyAnimalScreen = '/adoptionEditMyAnimalScreen';
  static const myAdoptionChatListScreen = '/myAdoptionChatListScreen';
  static const myAdoptionChatScreen = '/myAdoptionChatScreen';
  static const adoptionChatListScreen = '/adoptionChatListScreen';
  static const adoptionChatScreen = '/adoptionChatScreen';
  static const chatSupportScreen = '/chatSupportScreen';
  static const subCategoriesScreen = '/subCategoriesScreen';
  static const productsScreen = '/productsScreen';
  static const productDetailsScreen = '/productDetailsScreen';
  static const productPurchaseOptionsScreen = '/productPurchaseOptionsScreen';
  static const myAnimalsScreen = '/myAnimalsScreen';
  static const productsAddAnimalScreen = '/productsAddAnimalScreen';
  static const productsEditAnimalScreen = '/productsEditAnimalScreen';
  static const productsAnimalsRequestsScreen = '/productsAnimalsRequestsScreen';
  static const productsChatScreen = '/productsChatScreen';
  static const productsChatListScreen = '/productsChatListScreen';
  static const myBookmarksScreen = '/myBookmarksScreen';
  static const productSetDeliveryTimeScreen = '/productSetDeliveryTimeScreen';
}
