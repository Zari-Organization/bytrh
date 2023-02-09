import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Widgets/auth_button.dart';
import '../../../../../Widgets/titled_textField.dart';

class WalletPaymentScreen extends StatelessWidget {
  WalletPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          title: const Text("شحن المحفظة"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitledTextField(
                  title: "أدخل قيمة الشحن",
                  // controller:
                  // personalDataController.userNameController.value,
                  fillColor: AppColors.GREY_Light_COLOR,
                ),
                const SizedBox(height: 16),
                const Text(
                  "أختر طريقة الدفع",
                  style: TextStyle(color: AppColors.BLACK_COLOR, fontSize: 16),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      shape: OutlineInputBorder(
                        borderSide: const BorderSide(
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
                        title: const Text(
                          "أبل باي",
                          style: TextStyle(color: AppColors.BLACK_COLOR),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 16)
                  ,
                ),
                const SizedBox(height: 50),
                CustomButton(
                  title: "دفع الآن",
                  backgroundColor: AppColors.MAIN_COLOR,
                  foregroundColor: AppColors.WHITE_COLOR,
                  overlayColor: AppColors.WHITE_COLOR,
                  onPress: () {},
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }
}
