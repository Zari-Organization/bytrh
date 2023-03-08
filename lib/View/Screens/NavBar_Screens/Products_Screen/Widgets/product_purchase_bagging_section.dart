import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_icons.dart';
import '../../../../../Utils/app_images.dart';

class ProductPurchaseBaggingSection extends StatelessWidget {
  ProductPurchaseBaggingSection({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {

      if(productsController.animalProductDetails.value.hasBagging!=0){
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "هل ترغب في التكييس بعد الذبح؟",
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
                      value: productsController.baggingChecked.value,
                      onChanged: (_) {
                        productsController.baggingChecked.value = true;
                        productsController.baggingNotChecked.value = false;
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
                      value: productsController.baggingNotChecked.value,
                      onChanged: (_) {
                        productsController.baggingChecked.value = false;
                        productsController.baggingNotChecked.value = true;
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
            ),
            const SizedBox(height: 16),
            if(productsController.baggingChecked.value&&productsController.animalProductBaggingList.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "أختار نوع التكييس",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    itemCount: productsController.animalProductBaggingList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title:  Text(
                            productsController.animalProductBaggingList[index].baggingName,
                            style: TextStyle(),
                          ),
                          secondary:  Text(
                            "${productsController.animalProductBaggingList[index].baggingPrice} ر.س",
                            style: TextStyle(),
                          ),
                          value: productsController.animalProductBaggingList[index].idBagging,
                          groupValue: productsController.baggingListValue.value,
                          onChanged: (value) {
                            productsController.baggingListValue.value = value!;
                            log(productsController.baggingListValue.value.toString());
                          },
                        );
                      });
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 1),
                  ),
                ],
              ),
          ],
        );
      }
      else{
        return SizedBox();
      }
    });
  }
}
