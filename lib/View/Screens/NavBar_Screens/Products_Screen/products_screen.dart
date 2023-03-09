import 'package:bytrh/Utils/app_alerts.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_constants.dart';
import '../../../../Utils/app_images.dart';
import '../../../Widgets/custom_circle_progress.dart';
import '../Widgets/advertisements_Widget.dart';
import 'Widgets/bookmark_button.dart';

class ProductsScreen extends StatelessWidget {
   ProductsScreen({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: const Text("المنتجات"),

      ),
      body: Obx((){
        // if (productsController.isLoadingAnimalProducts.value) {
        //   return const CustomCircleProgress();
        // } else
          if (productsController.animalProductsList.isEmpty) {
          return const Center(
            child: Text("لا يوجد"),
          );
        }
        else{
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    childAspectRatio: 0.8),
                itemCount: productsController.animalProductsList.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      productsController.getAnimalProductDetails(
                        productsController
                            .animalProductsList[index].idAnimalProduct
                            .toString(),
                      );
                      Get.toNamed(Routes.productDetailsScreen);
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.GREY_Light_COLOR,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: double.infinity,
                                      imageUrl: productsController.animalProductsList[index].animalProductImage,
                                      placeholder: (context, url) => Image.asset(
                                        AppImages.placeholder,
                                        height: 80,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                            AppImages.placeholder,
                                            height: 80,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                    ),
                                  ),
                                  BookMarkButton(
                                    function: () async {
                                      productsController.addToBookmarks(
                                        id: productsController
                                            .animalProductsList[index].idAnimalProduct
                                            .toString(),
                                        context: context,
                                      );
                                    },
                                    statusActive:
                                    productsController
                                        .animalProductsList[index].bookmarked ==
                                        0
                                        ? false
                                        : true,
                                  )
                                  // IconButton(
                                  //   onPressed: () {},
                                  //   icon: CircleAvatar(
                                  //     backgroundColor:
                                  //     AppColors.WHITE_COLOR.withOpacity(0.7),
                                  //     radius: 17,
                                  //     child: SvgPicture.asset(
                                  //       AppIcons.favorite_icon,
                                  //       color: AppColors.BLACK_COLOR,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "السعر يبدأ من:",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.BLACK_COLOR,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // maxLines: 2,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${productsController.animalProductsList[index].animalProductPrice} ر.س",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.MAIN_COLOR,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // maxLines: 2,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              if(productsController.isLoadingAnimalProducts.value)
              CustomCircleProgress(),
            ],
          ),
        );
        }
      })
    );
  }
}
