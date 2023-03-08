import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import '../../../Widgets/custom_circle_progress.dart';
import '../Widgets/advertisements_Widget.dart';


class SubCategoriesScreen extends StatelessWidget {
   SubCategoriesScreen({Key? key}) : super(key: key);
   final productsController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title:  Text(productsController.selectedProductsCategoryName.value),
      ),
      body: Obx((){
        if (productsController.isLoadingSubCategories.value) {
          return const CustomCircleProgress();
        } else if (productsController.productsSubCategoriesList.isEmpty) {
          return const Center(
            child: Text("لا يوجد"),
          );
        }else{
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
                  ),
                  itemCount: productsController.productsSubCategoriesList.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        productsController.selectedAnimalName.value = productsController.productsSubCategoriesList[index].animalSubCategoryName;
                        productsController.getAnimalProducts(
                          productsController
                              .productsSubCategoriesList[index].idAnimalSubCategory
                              .toString(),
                        );
                        Get.toNamed(Routes.productsScreen);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GridTile(
                          footer: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            color: Colors.black26,
                            alignment: Alignment.bottomCenter,
                            child:  Text(
                              productsController.productsSubCategoriesList[index].animalSubCategoryName,
                              style: const TextStyle(
                                height: 1.3,
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            imageUrl: productsController.productsSubCategoriesList[index].animalSubCategoryImage,
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
                    );
                  },
                ),
              ],
            ),
          );
        }
      })
    );
  }
}
