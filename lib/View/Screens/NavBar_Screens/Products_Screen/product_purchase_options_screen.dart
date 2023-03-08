import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_icons.dart';
import '../../../../Utils/app_images.dart';
import '../../../Widgets/auth_button.dart';
import '../../../Widgets/custom_circle_progress.dart';
import '../Home_Screen/Screens/Adoption_Screens/Widgets/custom_textField_widget.dart';
import 'Widgets/product_purchase_delivery_section.dart';
import 'Widgets/product_purchase_bagging_section.dart';
import 'Widgets/product_purchase_cutting_section.dart';
import 'Widgets/product_purchase_header.dart';

class ProductPurchaseOptionsScreen extends StatelessWidget {
  ProductPurchaseOptionsScreen({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: const Text("خيارات الشراء"),
      ),
      body: Obx(() {
        if (productsController.isLoadingAnimalProductDetails.value) {
          return const CustomCircleProgress();
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductPurchaseHeader(),
                  ProductPurchaseCuttingSection(),
                  const SizedBox(height: 16),
                  ProductPurchaseBaggingSection(),
                  const SizedBox(height: 16),
                  ProductPurchaseDeliverySection(),
                  const SizedBox(height: 16),
                  const Text(
                    "ملاحظات",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldWidget(
                    hintText: "ملاحظات",
                    maxLines: 3,
                    controller: productsController.purchaseAnimalNoteController.value,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    title: "التالي",
                    // backgroundColor: AppColors.MAIN_COLOR,
                    foregroundColor: AppColors.WHITE_COLOR,
                    overlayColor: AppColors.WHITE_COLOR,
                    onPress: () {
                      productsController.setDataToPurchaseAnimal(context);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
