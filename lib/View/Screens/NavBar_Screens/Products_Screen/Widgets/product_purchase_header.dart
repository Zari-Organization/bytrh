import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_icons.dart';
import '../../../../../Utils/app_images.dart';

class ProductPurchaseHeader extends StatelessWidget {
   ProductPurchaseHeader({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: OutlineInputBorder(
              borderSide:  const BorderSide(
                color: AppColors.GREY_Light_COLOR,
              ),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    imageUrl: productsController
                        .animalProductDetails.value.animalProductImage,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${productsController
                          .animalProductDetails.value.animalProductPrice} ر.س",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.location_icon,
                          color: AppColors.GREY_COLOR,
                        ),
                        Text(
                          productsController
                              .animalProductDetails.value.cityName,
                          style: TextStyle(color: AppColors.GREY_COLOR),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    });
  }
}
