import 'dart:developer';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get/get.dart';
import '../../../../../Logic/controllers/Products_Controllers/products_controller.dart';

class ProductAnimalSubCategoryFilter extends StatelessWidget {
  ProductAnimalSubCategoryFilter({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
            () {
          if (productsController.isLoadingSubCategories.value) {
            return const CustomCircleProgress();
          } else {
            // return DropDown(
            //   items: productsController.productsSubCategoriesList,
            //   initialValue: 1,
            //   hint: Text("Male"),
            //   icon: Icon(
            //     Icons.expand_more,
            //     color: Colors.blue,
            //   ),
            //   onChanged: (_){},
            // );
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
                    'اختر الفئة الفرعية',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: productsController.productsSubCategoriesList
                      .map((item) => DropdownMenuItem<String>(
                    value: item.idAnimalSubCategory.toString(),
                    child: Text(
                      item.animalSubCategoryName,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )).toList(),
                  value: productsController.idSubCategory.value,
                  onChanged: (value) {
                    productsController.idSubCategory.value = value as String;
                    log(productsController.idSubCategory.value);
                  },
                ),
              ),
            );
          }
        }
    );
  }
}
