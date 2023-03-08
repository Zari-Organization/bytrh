import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_icons.dart';
import '../../../../../Utils/app_images.dart';

class ProductPurchaseCuttingSection extends StatelessWidget {
  ProductPurchaseCuttingSection({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {

      if(productsController.animalProductDetails.value.hasCutting!=0){
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "هل ترغب في ذبح المنتج؟",
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
                      value: productsController.cuttingChecked.value,
                      onChanged: (_) {
                        productsController.cuttingChecked.value =true;
                        productsController.cuttingNotChecked.value =false;
                      },
                      // checkColor: AppColors.MAIN_COLOR,
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
                      value: productsController.cuttingNotChecked.value,
                      onChanged: (_) {
                        productsController.cuttingChecked.value =false;
                        productsController.cuttingNotChecked.value =true;
                      },
                      // checkColor: AppColors.MAIN_COLOR,
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
            if(productsController.cuttingChecked.value&&productsController.animalProductCuttingList.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "أختار نوع الذبح",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    itemCount: productsController.animalProductCuttingList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Obx((){
                        return RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title:  Text(
                            productsController.animalProductCuttingList[index].cuttingName,
                            style: TextStyle(),
                          ),
                          secondary:  Text(
                            "${productsController.animalProductCuttingList[index].cuttingPrice} ر.س",
                            style: TextStyle(),
                          ),
                          value: productsController.animalProductCuttingList[index].idCutting,
                          groupValue: productsController.cuttingListValue.value,
                          onChanged: (value) {
                            productsController.cuttingListValue.value = value!;
                            log(productsController.cuttingListValue.value.toString());
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
