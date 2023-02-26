import 'package:bytrh/Utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../Routes/routes.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_icons.dart';
import '../../../../../../Utils/app_images.dart';
import '../../../../../Widgets/auth_button.dart';
import '../../../../../Widgets/custom_circle_progress.dart';
import 'Widgets/my_pet_details_widget.dart';
import 'Widgets/pet_details_widget.dart';

class AdoptionMyAnimalsDetailsScreen extends StatelessWidget {
  AdoptionMyAnimalsDetailsScreen({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: Text("التفاصيل"),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Container(
              color: AppColors.WHITE_COLOR,
              padding: EdgeInsets.all(16),
              child: ConditionalBuilder(
                condition: !adoptionController.isLoadingAdoptionAnimalsCategory.value,
                builder: (context) => CustomButton(
                  title: "تعديل",
                  backgroundColor: AppColors.WHITE_COLOR,
                  foregroundColor: AppColors.MAIN_COLOR,
                  overlayColor: AppColors.MAIN_COLOR,
                  onPress: () async {
                    await adoptionController.getAdoptionAnimalsCategory();
                    adoptionController
                            .selectedAdoptionAnimalsGenderValue.value =
                        adoptionController.adoptionAnimalsGenderList[0]
                            .toString();
                    await adoptionController.getCountries();
                    adoptionController.idCountry.value = adoptionController
                        .adoptionsMyAnimalsDetails.value.idCountry
                        .toString();
                    adoptionController.idCity.value = adoptionController
                        .adoptionsMyAnimalsDetails.value.idCity
                        .toString();
                    await adoptionController.getCities();
                    adoptionController
                            .selectedAdoptionAnimalsCategoryValue.value =
                        adoptionController
                            .adoptionsMyAnimalsDetails.value.idAnimalSubCategory
                            .toString();
                    Get.toNamed(Routes.adoptionEditMyAnimalScreen);
                  },
                ),
                fallback: (context) => const CustomCircleProgress(),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (adoptionController.isLoadingAdoptionMyAnimalsDetails.value) {
          return CustomCircleProgress();
        } else {
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: AppConstants.mediaHeight(context) / 2.5,
                      imageUrl: adoptionController
                          .adoptionsMyAnimalsDetails.value.petPicture,
                      placeholder: (context, url) => Image.asset(
                        AppImages.placeholder,
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppImages.placeholder,
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppConstants.mediaHeight(context) / 3),
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )),
                            margin: EdgeInsets.only(bottom: 50),
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    adoptionController.adoptionsMyAnimalsDetails
                                        .value.petName,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    " ${adoptionController.adoptionsMyAnimalsDetails.value.animalSubCategoryName} / ${adoptionController.adoptionsMyAnimalsDetails.value.petStrain}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.location_icon,
                                        color: AppColors.GREY_COLOR,
                                      ),
                                      Text(
                                        adoptionController
                                            .adoptionsMyAnimalsDetails
                                            .value
                                            .cityName,
                                        style: TextStyle(
                                            color: AppColors.GREY_COLOR),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  MyPetDetailsWidget(),
                                  SizedBox(height: 20),
                                  Text(
                                    "التفاصيل",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    adoptionController.adoptionsMyAnimalsDetails
                                        .value.petDescription,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 20),
                                  adoptionController.adoptionsMyAnimalsDetails
                                          .value.adoptionGallery!.isEmpty
                                      ? SizedBox()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "الألبوم",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5),
                                            SizedBox(
                                              height: 100,
                                              child: ListView.separated(
                                                itemCount: adoptionController
                                                    .adoptionsMyAnimalsDetails
                                                    .value
                                                    .adoptionGallery!
                                                    .length,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      height: 70,
                                                      width: 100,
                                                      imageUrl: adoptionController
                                                          .adoptionsMyAnimalsDetails
                                                          .value
                                                          .adoptionGallery![
                                                              index]
                                                          .adoptionGalleryPath,
                                                      placeholder:
                                                          (context, url) =>
                                                              Image.asset(
                                                        AppImages.placeholder,
                                                        height: 70,
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                        AppImages.placeholder,
                                                        height: 70,
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                  // return ClipRRect(
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(
                                                  //           10),
                                                  //   child: Image.network(
                                                  //     fit: BoxFit.cover,
                                                  //     height: 70,
                                                  //     width: 100,
                                                  //     adoptionController
                                                  //         .adoptionsDetails
                                                  //         .value
                                                  //         .adoptionGallery![
                                                  //             index]
                                                  //         .adoptionGalleryPath,
                                                  //   ),
                                                  // );
                                                },
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(width: 8),
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
