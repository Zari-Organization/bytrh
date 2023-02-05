// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../../../../Utils/app_colors.dart';
// import '../Routes/routes.dart';
// import 'app_icons.dart';
// import 'app_images.dart';
//
// class AppAlerts {
//   Future<bool>? onWillPop() async {
//     final result = await Get.defaultDialog(
//       title: 'Exit'.tr,
//       titleStyle: const TextStyle(color: AppColors.RED_COLOR),
//       content: Text("exit_app_alert".tr,
//           textAlign: TextAlign.center),
//       cancel: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//               side: const BorderSide(
//                 color: AppColors.MAIN_COLOR,
//                 width: 1,
//               ),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.WHITE_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//         ),
//         onPressed: () {
//           SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//         },
//         child: Text("Yes".tr),
//       ),
//       confirm: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.BLACK_COLOR,
//           ),
//         ),
//         onPressed: () {
//           Get.back();
//         },
//         child: Text(
//           "No".tr,
//           style: const TextStyle(color: AppColors.WHITE_COLOR),
//         ),
//       ),
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? logOutPop() async {
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: Column(
//         children: [
//           Image.asset(
//             AppIcons.alert_icon,
//             width: 90,
//             height: 90,
//           ),
//           const SizedBox(height: 15),
//           Text(
//             "Logout".tr,
//             style: const TextStyle(
//               color: AppColors.MAIN_COLOR,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             "Logout_desc".tr,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: AppColors.GREY_COLOR,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//       cancel: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.WHITE_COLOR,
//           ),
//         ),
//         onPressed: () {
//           Get.back();
//         },
//         child: Text("Cancel".tr),
//       ),
//       confirm: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//               side: const BorderSide(
//                 color: AppColors.MAIN_COLOR,
//                 width: 1,
//               ),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.WHITE_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//         ),
//         onPressed: () {
//           GetStorage authBox = GetStorage();
//           authBox.remove('AccessToken');
//           authBox.remove('userName');
//           Get.back();
//           Get.offAllNamed(Routes.onBoardingScreen);
//         },
//         child: Text("Logout".tr),
//       ),
//       confirmTextColor: AppColors.WHITE_COLOR,
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? deleteAccountPop() async {
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: Column(
//         children: [
//           Image.asset(
//             AppImages.alert_icon,
//             width: 90,
//             height: 90,
//           ),
//           const SizedBox(height: 15),
//           Text(
//             "Delete_Account".tr,
//             style: const TextStyle(
//               color: AppColors.MAIN_COLOR,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             "Delete_Account_desc".tr,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: AppColors.GREY_COLOR,
//               fontSize: 12,
//             ),
//           )
//         ],
//       ),
//       cancel: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.WHITE_COLOR,
//           ),
//         ),
//         onPressed: () {
//           Get.back();
//         },
//         child: Text("Cancel".tr),
//       ),
//       confirm: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//               side: const BorderSide(
//                 color: AppColors.MAIN_COLOR,
//                 width: 1,
//               ),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.WHITE_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//         ),
//         onPressed: () {},
//         child: Text("Delete_Account".tr),
//       ),
//       confirmTextColor: AppColors.WHITE_COLOR,
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? closeTenderPop(
//       {required String idClientTender, required String tenderStatus}) async {
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: Column(
//         children: [
//           Image.asset(
//             AppImages.alert_icon,
//             width: 90,
//             height: 90,
//           ),
//           const SizedBox(height: 15),
//            Text(
//             "Close_Tender".tr,
//             style: const TextStyle(
//               color: AppColors.MAIN_COLOR,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             "Close_mssg".tr,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: AppColors.GREY_COLOR,
//               fontSize: 12,
//             ),
//           )
//         ],
//       ),
//       cancel: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.WHITE_COLOR,
//           ),
//         ),
//         onPressed: () {
//           Get.back();
//         },
//         child: Text("Cancel".tr),
//       ),
//       confirm: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//               side: const BorderSide(
//                 color: AppColors.MAIN_COLOR,
//                 width: 1,
//               ),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.WHITE_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//         ),
//         onPressed: () {
//           Get.back();
//           // tendersController.closeTender(idClientTender, tenderStatus);
//         },
//         child: Text("Close".tr),
//       ),
//       confirmTextColor: AppColors.WHITE_COLOR,
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? tenderClosedSuccessfullyPop() async {
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: Column(
//         children: [
//           Image.asset(
//             AppImages.closed_image,
//             width: 90,
//             height: 90,
//           ),
//           const SizedBox(height: 15),
//            Text(
//             "Closed".tr,
//             style: const TextStyle(
//               color: AppColors.MAIN_COLOR,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//       cancel: const SizedBox(),
//       confirm: const SizedBox(),
//       confirmTextColor: AppColors.WHITE_COLOR,
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? paymentMethodsPop(List response) async {
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: ListView.builder(
//           itemCount: response.length,
//           // shrinkWrap: true,
//           physics: const BouncingScrollPhysics(),
//           itemBuilder: (context, index) {
//             return ListTile(
//               onTap: () {},
//               leading: Image.network(response[index]["ImageUrl"]),
//               title: Text(response[index]['PaymentMethodEn']),
//             );
//           },
//         )
//       ),
//       cancel: const SizedBox(),
//       confirm: const SizedBox(),
//       confirmTextColor: AppColors.WHITE_COLOR,
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? acceptTenderApplicantPop(
//       {required String IdClientTender}) async {
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           children: [
//             Image.asset(
//               AppImages.accept_image,
//               width: 90,
//               height: 90,
//             ),
//             const SizedBox(height: 15),
//             Text(
//               "Accepted".tr,
//               style: const TextStyle(
//                 color: AppColors.GREEN_COLOR,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 25),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   padding: MaterialStateProperty.all(
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                   ),
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   backgroundColor: MaterialStateProperty.all(
//                     AppColors.MAIN_COLOR,
//                   ),
//                   foregroundColor: MaterialStateProperty.all(
//                     AppColors.WHITE_COLOR,
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.back();
//                   closeTenderPop(
//                     idClientTender: IdClientTender,
//                     tenderStatus: "ENDED",
//                   );
//                 },
//                 child:  Text("Close_Tender".tr),
//               ),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   padding: MaterialStateProperty.all(
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                   ),
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                         side: const BorderSide(color: AppColors.MAIN_COLOR)),
//                   ),
//                   backgroundColor: MaterialStateProperty.all(
//                     AppColors.WHITE_COLOR,
//                   ),
//                   foregroundColor: MaterialStateProperty.all(
//                     AppColors.MAIN_COLOR,
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.back();
//                   Get.back();
//                 },
//                 child:  Text("Back_Applicants".tr),
//               ),
//             ),
//           ],
//         ),
//       ),
//       cancel: const SizedBox(),
//       confirm: const SizedBox(),
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? rejectTenderApplicantPop({
//     required String IdClientTender,
//     required String IDClientTenderReply,
//     required String TenderApplicantStatus,
//   }) async {
//     // final tendersController = Get.find<TendersController>();
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: Column(
//         children: [
//           Image.asset(
//             AppImages.alert_icon,
//             width: 90,
//             height: 90,
//           ),
//           const SizedBox(height: 15),
//            Text(
//             "Reject_title".tr,
//             style: const TextStyle(
//               color: AppColors.MAIN_COLOR,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             "Reject_mssg".tr,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: AppColors.GREY_COLOR,
//               fontSize: 12,
//             ),
//           )
//         ],
//       ),
//       cancel: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.WHITE_COLOR,
//           ),
//         ),
//         onPressed: () {
//           Get.back();
//         },
//         child: Text("Cancel".tr),
//       ),
//       confirm: ElevatedButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//               side: const BorderSide(
//                 color: AppColors.MAIN_COLOR,
//                 width: 1,
//               ),
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all(
//             AppColors.WHITE_COLOR,
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             AppColors.MAIN_COLOR,
//           ),
//         ),
//         onPressed: () {
//           Get.back();
//         },
//         child: Text("Reject".tr),
//       ),
//       confirmTextColor: AppColors.WHITE_COLOR,
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? tenderApplicantRejectedPop() async {
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: Column(
//         children: [
//           Image.asset(
//             AppImages.reject_image,
//             width: 90,
//             height: 90,
//           ),
//           const SizedBox(height: 15),
//            Text(
//             "Rejected".tr,
//             style: const TextStyle(
//               color: AppColors.MAIN_COLOR,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//       cancel: const SizedBox(),
//       confirm: const SizedBox(),
//       confirmTextColor: AppColors.WHITE_COLOR,
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? tenderAddedSuccessfullyPop() async {
//     final result = await Get.defaultDialog(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//       title: "Successfully".tr,
//       titleStyle: const TextStyle(color: AppColors.GREEN_COLOR),
//       content: Column(
//         children: [
//           Text(
//             "added_successfully".tr,
//             style: const TextStyle(
//               color: AppColors.BLACK_COLOR,
//               fontSize: 12,
//             ),
//           ),
//           const SizedBox(height: 15),
//           Image.asset(
//             AppImages.success_image,
//             width: 90,
//             height: 90,
//           ),
//         ],
//       ),
//       cancel: const SizedBox(),
//       confirm: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ButtonStyle(
//             // padding: MaterialStateProperty.all(
//             //   const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
//             // ),
//             shape: MaterialStateProperty.all(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25),
//               ),
//             ),
//             backgroundColor: MaterialStateProperty.all(
//               AppColors.MAIN_COLOR,
//             ),
//             foregroundColor: MaterialStateProperty.all(
//               AppColors.WHITE_COLOR,
//             ),
//           ),
//           onPressed: () {
//             Get.back();
//           },
//           child:  Text("Ok".tr),
//         ),
//       ),
//       confirmTextColor: AppColors.WHITE_COLOR,
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? switchAccountSuccessfullyPop() async {
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           children: [
//             Image.asset(
//               AppImages.accept_image,
//               width: 90,
//               height: 90,
//             ),
//             const SizedBox(height: 15),
//             const Text(
//               "Successfully",
//               style: TextStyle(
//                 color: AppColors.GREEN_COLOR,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 15),
//             Text(
//               "Your account has been changed to business account.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: AppColors.GREY_COLOR,
//                 fontSize: 12,
//               ),
//             ),
//             const SizedBox(height: 25),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   padding: MaterialStateProperty.all(
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                   ),
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   backgroundColor: MaterialStateProperty.all(
//                     AppColors.MAIN_COLOR,
//                   ),
//                   foregroundColor: MaterialStateProperty.all(
//                     AppColors.WHITE_COLOR,
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: const Text("Download Manager App"),
//               ),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   padding: MaterialStateProperty.all(
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                   ),
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                         side: const BorderSide(color: AppColors.MAIN_COLOR)),
//                   ),
//                   backgroundColor: MaterialStateProperty.all(
//                     AppColors.WHITE_COLOR,
//                   ),
//                   foregroundColor: MaterialStateProperty.all(
//                     AppColors.MAIN_COLOR,
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: const Text("Back To Profile"),
//               ),
//             ),
//           ],
//         ),
//       ),
//       cancel: const SizedBox(),
//       confirm: const SizedBox(),
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
//
//   Future<bool>? pendingBuyTenderPop() async {
//     final result = await Get.defaultDialog(
//       contentPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       title: "",
//       content: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           children: [
//             Image.asset(
//               AppImages.pending_image,
//               width: 90,
//               height: 90,
//             ),
//             const SizedBox(height: 15),
//             Text(
//               "Pending_Confirmation".tr,
//               style: const TextStyle(
//                 color: AppColors.YELLOW_COLOR,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             // const SizedBox(height: 15),
//             // Text(
//             //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//             //   textAlign: TextAlign.center,
//             //   style: TextStyle(
//             //     color: AppColors.GREY_COLOR,
//             //     fontSize: 12,
//             //   ),
//             // ),
//             const SizedBox(height: 25),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   padding: MaterialStateProperty.all(
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                   ),
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   backgroundColor: MaterialStateProperty.all(
//                     AppColors.MAIN_COLOR,
//                   ),
//                   foregroundColor: MaterialStateProperty.all(
//                     AppColors.WHITE_COLOR,
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child:  Text("Ok".tr),
//               ),
//             ),
//           ],
//         ),
//       ),
//       cancel: const SizedBox(),
//       confirm: const SizedBox(),
//     );
//     if (result == null) {
//       return false;
//     } else {
//       return result;
//     }
//   }
// }
