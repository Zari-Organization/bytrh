import 'dart:developer';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../Logic/controllers/Products_Controllers/products_controller.dart';

class ProductAnimalsCategoryFilter extends StatelessWidget {
  ProductAnimalsCategoryFilter({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
            () {
          if (productsController.isLoadingProductsCategory.value) {
            return const CustomCircleProgress();
          } else {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.GREY_COLOR),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    'اختر الفئة',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: productsController.productsCategoryList
                      .map((item) => DropdownMenuItem<String>(
                    value: item.idAnimalCategory.toString(),
                    child: Text(
                      item.animalCategoryName,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: productsController.idCategory.value,
                  onChanged: (value) {
                    productsController.idCategory.value = value as String;
                    productsController.getProductSubCategories(productsController.idCategory.value);
                    log(productsController.idCategory.value);
                  },
                ),
              ),
            );
          }
        }
    );
  }
}
