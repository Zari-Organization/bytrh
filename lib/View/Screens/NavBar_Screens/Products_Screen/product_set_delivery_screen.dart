import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../Utils/app_colors.dart';
import '../../../Widgets/auth_button.dart';
import '../../../Widgets/custom_circle_progress.dart';
import '../Home_Screen/Screens/Adoption_Screens/Widgets/custom_textField_widget.dart';

class ProductSetDeliveryTimeScreen extends StatelessWidget {
  ProductSetDeliveryTimeScreen({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.MAIN_COLOR,
          centerTitle: true,
          title: Text("التوصيل"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "الموافقة علي التوصيل ؟",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        side: const BorderSide(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        value: productsController.productDeliveryAccepted.value,
                        onChanged: (_) {
                          productsController.productDeliveryAccepted.value =
                              true;
                          productsController.productDeliveryRejected.value =
                              false;
                        },
                        // checkColor: AppColors.MAIN_COLOR,
                        activeColor: AppColors.SECOND_COLOR,
                      ),
                      const Text(
                        "قبول",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Row(
                    children: [
                      Checkbox(
                        side: const BorderSide(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        value: productsController.productDeliveryRejected.value,
                        onChanged: (_) {
                          productsController.productDeliveryAccepted.value =
                              false;
                          productsController.productDeliveryRejected.value =
                              true;
                        },
                        // checkColor: AppColors.MAIN_COLOR,
                        activeColor: AppColors.SECOND_COLOR,
                      ),
                      const Text(
                        "رفض",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (productsController.productDeliveryAccepted.value)
                CustomTextFieldWidget(
                  hintText: "رسوم التوصيل",
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  controller:
                      productsController.productDeliveryFeesController.value,
                ),
              const SizedBox(height: 60),
              ConditionalBuilder(
                condition:
                    !productsController.isLoadingProductDeliveryRequest.value,
                builder: (context) => CustomButton(
                  title: "إرسال",
                  // backgroundColor: AppColors.MAIN_COLOR,
                  foregroundColor: AppColors.WHITE_COLOR,
                  overlayColor: AppColors.WHITE_COLOR,
                  onPress: () {
                    productsController.productDeliveryRequest(
                      context: context,
                      IDAnimalProduct: productsController.idAnimalProduct.value,
                      AnimalProductStatus:
                          productsController.productDeliveryAccepted.value
                              ? "ACCEPTED"
                              : "REJECTED",
                      DeliveryFees: productsController
                          .productDeliveryFeesController.value.text,
                    );
                  },
                ),
                fallback: (context) => const CustomCircleProgress(),
              ),
            ],
          ),
        )),
      );
    });
  }
}
