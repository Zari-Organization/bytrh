import 'dart:developer';

import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_images.dart';
import '../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../Widgets/auth_button.dart';
import '../../../Widgets/custom_circle_progress.dart';

class ProductsMyAnimalsScreen extends StatelessWidget {
  ProductsMyAnimalsScreen({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productsController.isLoadingProductsMyAnimals.value) {
        return const CustomCircleProgress();
      } else if (productsController.productsMyAnimalsList.isEmpty) {
        return Stack(
          children: [
            const Center(
              child: Text("لايوجد لديك حيوانات متاحة للبيع"),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: ConditionalBuilder(
                  condition: true,
                  builder: (context) => CustomButton(
                    title: "إضافة حيوان جديد",
                    backgroundColor: AppColors.WHITE_COLOR,
                    onPress: () async {
                      await productsController.getProductsCategory();
                      await productsController.getProductSubCategories(
                          productsController.idCategory.value);
                      await adoptionController.getCountries();
                      await adoptionController.getCities();
                      adoptionController.idCity.value =
                          adoptionController.citiesList[0].idCity.toString();
                      Get.toNamed(Routes.productsAddAnimalScreen);
                    },
                  ),
                  fallback: (context) => const CustomCircleProgress(),
                ),
              ),
            )
          ],
        );
      } else {
        return Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: productsController.productsMyAnimalsList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          if(productsController.productsMyAnimalsList[index].animalProductStatus=="RESERVED"){
                            productsController.idAnimalProduct.value = productsController.productsMyAnimalsList[index].idAnimalProduct.toString();
                            Get.toNamed(Routes.productSetDeliveryTimeScreen);
                          }else{
                            productsController.getAnimalProductDetails(
                              productsController.productsMyAnimalsList[index].idAnimalProduct.toString(),
                            );
                            Get.toNamed(Routes.productDetailsScreen);
                          }
                        },
                        child: Card(
                          shape: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.GREY_Light_COLOR,
                            ),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(17),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                      imageUrl: productsController
                                          .productsMyAnimalsList[index]
                                          .animalProductImage,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        AppImages.placeholder,
                                        width: 100,
                                        // height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        AppImages.placeholder,
                                        width: 100,
                                        // height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        "السعر يبدأ من",
                                        style: TextStyle(
                                            color: AppColors.GREY_COLOR),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "${productsController.productsMyAnimalsList[index].animalProductPrice} ر.س",
                                        style: const TextStyle(
                                            color: AppColors.MAIN_COLOR),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        if (productsController
                                            .productsMyAnimalsList[index]
                                            .animalProductStatus ==
                                            "PENDING"||productsController
                                            .productsMyAnimalsList[index]
                                            .animalProductStatus ==
                                            "ACTIVE")
                                          DropdownButton<String>(
                                            icon: SvgPicture.asset(
                                                AppIcons.list_icon),
                                            underline: const SizedBox(),
                                            items: productsController
                                                .productsMyAnimalsList[index]
                                                .animalProductStatus==
                                                "PENDING"
                                                ? <String>[
                                              'تعديل',
                                              'حذف',
                                            ].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList()
                                                : <String>[
                                              'تعديل',
                                              'حذف',
                                              'تم البيع'
                                            ].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) async {
                                              log(value.toString());
                                              if (value == "تعديل") {
                                                await  productsController.getAnimalProductDetails(
                                                  productsController.productsMyAnimalsList[index].idAnimalProduct.toString(),
                                                );
                                                await productsController.getProductsCategory();
                                                await productsController.getProductSubCategories(
                                                    productsController.idCategory.value);
                                                await adoptionController.getCountries();
                                                await adoptionController.getCities();
                                                adoptionController.idCity.value = adoptionController.citiesList[0].idCity.toString();
                                                adoptionController.selectedAdoptionAnimalsGenderValue.value = adoptionController.adoptionAnimalsGenderList[0].toString();
                                                Get.toNamed(Routes.productsEditAnimalScreen);
                                              } else {
                                                await productsController.addMyProductAnimalStatus(
                                                  productsController
                                                      .productsMyAnimalsList[index]
                                                      .idAnimalProduct
                                                      .toString(),
                                                  value == "حذف"
                                                      ? "CANCELLED"
                                                      : "SOLD",
                                                  context,
                                                );
                                                productsController.getProductsMyAnimals();
                                              }
                                            },
                                          ),
                                        Text(
                                          getCountDownTitle(productsController.productsMyAnimalsList[index].animalProductStatus,),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.GREY_COLOR,
                                            // overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: ConditionalBuilder(
                  condition: true,
                  builder: (context) => CustomButton(
                    title: "إضافة حيوان جديد",
                    backgroundColor: AppColors.WHITE_COLOR,
                    onPress: () async {
                      await productsController.getProductsCategory();
                      await productsController.getProductSubCategories(
                          productsController.idCategory.value);
                      await adoptionController.getCountries();
                      await adoptionController.getCities();
                      adoptionController.idCity.value =
                          adoptionController.citiesList[0].idCity.toString();
                      Get.toNamed(Routes.productsAddAnimalScreen);
                    },
                  ),
                  fallback: (context) => const CustomCircleProgress(),
                ),
              ),
            )
          ],
        );
      }
    });
  }

  String getCountDownTitle(status) {
    switch (status) {
      case "PENDING":
        return "في انتظار موافقة الأدمن";
      case "SOLD":
        return "تم البيع";
      case "CANCELLED":
        return "غير نشط";
      case "RESERVED":
        return "في انتظار قبول الطلب";
      default:
        return "";
    }
  }
}
