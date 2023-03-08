import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_icons.dart';
import '../../../../../Utils/app_images.dart';

class ProductPurchaseDeliverySection extends StatelessWidget {
  ProductPurchaseDeliverySection({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {

      if(productsController.animalProductDetails.value.hasDelivery!=0){
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "هل ترغب في التوصيل إلى مكانك؟",
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
                          value: productsController.deliveryChecked.value,
                          onChanged: (_) {
                            productsController.deliveryChecked.value = true;
                            productsController.deliveryNotChecked.value = false;
                          },
                          activeColor: AppColors.SECOND_COLOR,
                        ),

                        const Text(
                          "نعم",
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
                          value: productsController.deliveryNotChecked.value,
                          onChanged: (_) {
                            productsController.deliveryChecked.value = false;
                            productsController.deliveryNotChecked.value = true;
                          },
                          activeColor: AppColors.SECOND_COLOR,
                        ),
                        const Text(
                          "لا",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                )
          ],
        );
      }
      else{
        return const SizedBox();
      }
    });
  }
}
