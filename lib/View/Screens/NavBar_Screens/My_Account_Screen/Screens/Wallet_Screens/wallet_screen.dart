import 'package:bytrh/Utils/app_images.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Logic/controllers/Wallet_Controllers/wallet_controllers.dart';
import '../../../../../../Routes/routes.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_icons.dart';
import '../../../../../Widgets/auth_button.dart';
import '../../Widgets/custom_listTile.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({Key? key}) : super(key: key);
  final walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (walletController.isLoadingMyWallet.value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.MAIN_COLOR,
            centerTitle: true,
            title: const Text("المحفظة"),
          ),
          body: CustomCircleProgress(),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.MAIN_COLOR,
            centerTitle: true,
            title: const Text("المحفظة"),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        AppImages.card_image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${walletController.myWalletData.value.clientName}",
                              style: const TextStyle(
                                color: AppColors.WHITE_COLOR,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text("رصيدك"),
                            Row(
                              children: [
                                Text(
                                  "${walletController.myWalletData.value.clientBalance}",
                                  style: const TextStyle(
                                    color: AppColors.WHITE_COLOR,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "ر.س",
                                  style: TextStyle(
                                    color: AppColors.WHITE_COLOR,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomListTile(
                    icon: AppIcons.points_icon,
                    title: "النقاط المجمعه",
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${walletController.myWalletData.value.clientCurrentPoints}",
                          style: const TextStyle(
                            color: AppColors.MAIN_COLOR,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "نقطة",
                          style: TextStyle(
                            color: AppColors.MAIN_COLOR,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  CustomListTile(
                    icon: AppIcons.discount_icon,
                    title: "قسائم الشراء",
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${walletController.myWalletData.value.giftCards}",
                          style: const TextStyle(
                            color: AppColors.MAIN_COLOR,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "قسيمة",
                          style: TextStyle(
                            color: AppColors.MAIN_COLOR,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 100),
                  CustomButton(
                    title: "شحن المحفظة",
                    foregroundColor: AppColors.WHITE_COLOR,
                    overlayColor: AppColors.WHITE_COLOR,
                    onPress: () {
                      Get.toNamed(Routes.walletPaymentScreen);
                    },
                  ),
                  const SizedBox(height: 16),
                  // CustomButton(
                  //   title: "إهداء بطاقة لصديق",
                  //   backgroundColor: AppColors.WHITE_COLOR,
                  //   foregroundColor: AppColors.MAIN_COLOR,
                  //   overlayColor: AppColors.MAIN_COLOR,
                  //   onPress: () {
                  //     Get.toNamed(Routes.cardGiftScreen);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
