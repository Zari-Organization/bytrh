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

class ProductsAnimalsRequestsScreen extends StatelessWidget {
  ProductsAnimalsRequestsScreen({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          centerTitle: true,
          title: const Text("طلباتك"),
        ),
        body: Obx(() {
          if (productsController.isLoadingProductsAnimalsRequests.value) {
            return const CustomCircleProgress();
          } else if (productsController.productsAnimalsRequestsList.isEmpty) {
            return const Center(
              child: Text("لايوجد لديك طلبات بعد."),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: productsController.productsAnimalsRequestsList.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    if(productsController.productsAnimalsRequestsList[index].animalProductStatus=="RESERVED"){
                      productsController.idAnimalProduct.value = productsController.productsAnimalsRequestsList[index].idAnimalProduct.toString();
                      Get.toNamed(Routes.productSetDeliveryTimeScreen);
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
                      // crossAxisAlignment: CrossAxisAlignment.start,
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
                                    .productsAnimalsRequestsList[index]
                                    .animalProductImage,
                                placeholder: (context, url) => Image.asset(
                                  AppImages.placeholder,
                                  width: 100,
                                  // height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Image.asset(
                                  AppImages.placeholder,
                                  width: 100,
                                  // height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${productsController.productsAnimalsRequestsList[index].animalProductPrice} ر.س",
                              style: const TextStyle(
                                  color: AppColors.MAIN_COLOR),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Text(
                          getCountDownTitle(productsController.productsAnimalsRequestsList[index].animalProductStatus),
                          style:  TextStyle(
                              color: AppColors.GREY_COLOR,fontSize: 12),
                        ),),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            );
          }
        }));
  }

  String getCountDownTitle(status) {
    switch (status) {
      case "PENDING":
        return "في انتظار الموافقة";
      case "SOLD":
        return "تم البيع";
      case "RESERVED":
        return "في انتظار قبول الطلب";
      default:
        return "";
    }
  }
}
