import 'package:bytrh/Utils/app_images.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Routes/routes.dart';
import '../../../../../../../Utils/app_colors.dart';
import '../../../../../../../Utils/app_constants.dart';
import '../../../../../../../Utils/app_icons.dart';

class AdoptionListWidget extends StatelessWidget {
  AdoptionListWidget({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (adoptionController.isLoadingAdoptions.value) {
        return CustomCircleProgress();
      } else if (adoptionController.adoptionsList.isEmpty) {
        return Center(
          child: Text("لايوجد حيوانات متاحة للتبني الان"),
        );
      } else {
        return ListView.separated(
          itemCount: adoptionController.adoptionsList.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                adoptionController.setDataToAdoptionDetails(adoptionController
                    .adoptionsList[index].idAdoption
                    .toString());
              },
              child: Card(
                shape: OutlineInputBorder(
                  borderSide: BorderSide(
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
                            imageUrl:adoptionController.adoptionsList[index].petPicture,
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
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              adoptionController.adoptionsList[index].petName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              " ${adoptionController.adoptionsList[index].animalSubCategoryName} / ${adoptionController.adoptionsList[index].petStrain}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.location_icon,
                                  color: AppColors.GREY_COLOR,
                                ),
                                Text(
                                  adoptionController
                                      .adoptionsList[index].cityName,
                                  style: TextStyle(color: AppColors.GREY_COLOR),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        );
      }
    });
  }
}
