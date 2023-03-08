import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/Utils/app_images.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../Utils/app_colors.dart';
import '../Widgets/advertisements_Widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: const Text("الفئات"),
      ),
      body: Obx(() {
        if (productsController.isLoadingProductsCategory.value) {
          return CustomCircleProgress();
        } else if (productsController.productsCategoryList.isEmpty) {
          return Center(
            child: Text("لا يوجد"),
          );
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AdvertisementsWidget(),
                const SizedBox(height: 20),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: productsController.productsCategoryList.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        productsController.selectedProductsCategoryName.value = productsController
                            .productsCategoryList[index].animalCategoryName;
                         productsController.getProductSubCategories(
                          productsController
                              .productsCategoryList[index].idAnimalCategory
                              .toString(),
                        );
                        Get.toNamed(Routes.subCategoriesScreen);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GridTile(
                          footer: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            color: Colors.black26,
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              productsController.productsCategoryList[index]
                                  .animalCategoryName,
                              style: TextStyle(
                                height: 1.3,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Container(
                            color: Colors.white,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              imageUrl: productsController
                                  .productsCategoryList[index]
                                  .animalCategoryImage,
                              placeholder: (context, url) => Image.asset(
                                AppImages.placeholder,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.placeholder,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
