import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Wallet_Controllers/wallet_controllers.dart';
import '../../../../../../../Utils/app_colors.dart';

class PaymentMethodsWidget extends StatelessWidget {
   PaymentMethodsWidget({Key? key}) : super(key: key);
   final walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(walletController.paymentMethodsList.isEmpty){
        return const Center(child: Text("No Payment Methods"),);
      }
      else if(walletController.isLoadingPaymentMethods.value){
        return const CustomCircleProgress();
      }
      else{
        return ListView.separated(
          itemCount: walletController.paymentMethodsList.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              shape: OutlineInputBorder(
                borderSide:  const BorderSide(
                  color: AppColors.GREY_Light_COLOR,
                ),
                borderRadius: BorderRadius.circular(17),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  // tendersController.changePackageSelectedIndex(index);
                },
                shape: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.GREY_Light_COLOR,
                  ),
                  borderRadius: BorderRadius.circular(17),
                ),
                tileColor: AppColors.GREY_Light_COLOR,
                leading: Checkbox(
                  side: BorderSide(color: AppColors.GREY_COLOR),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  value: true,
                  onChanged: (_) {},
                  activeColor: AppColors.MAIN_COLOR,
                ),
                title:  Text(
                  "${walletController.paymentMethodsList[index].paymentMethod}",
                  style: TextStyle(color: AppColors.BLACK_COLOR),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16)
          ,
        );
      }
    });
  }
}
