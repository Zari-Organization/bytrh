import 'package:bytrh/Utils/app_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../Logic/controllers/Advertisements_Controllers/advertisements_controller.dart';
import '../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_constants.dart';
import '../../../Widgets/custom_circle_progress.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdvertisementsWidget extends StatelessWidget {
  AdvertisementsWidget({Key? key}) : super(key: key);
  final advertisementsController = Get.find<AdvertisementsController>();
  final adoptionController = Get.find<AdoptionController>();
  final instantConsultationsController = Get.find<InstantConsultationsController>();
  final termConsultationsController = Get.find<TermConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (advertisementsController.advertisementsList.isEmpty) {
        return const SizedBox();
      } else {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  // height: AppConstants.mediaHeight(context) / 1.7,
                  height: 180,
                  padEnds: false,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    advertisementsController.currentAdvertisement.value = index;
                  }),
              items: advertisementsController.advertisementsList.map(
                (image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                           if(image.idLink==null){
                             return;
                           }else{
                             if (image.advertisementService == "NONE") {
                               return;
                             }
                             else if (image.advertisementService == "CONSULT") {
                               termConsultationsController.setDataDoctorProfileFromAdvertisement(
                                 image.idLink.toString(),
                                 "CONSULT",
                               );
                             }
                             else if (image.advertisementService == "URGENT_CONSULT") {
                               instantConsultationsController.setDataDoctorProfile(
                                 image.idLink.toString(),
                                 "URGENT_CONSULT",
                               );

                             }else if (image.advertisementService == "ADOPTION") {
                               adoptionController.setDataToAdoptionDetails(image.idLink.toString());
                             }
                           }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: image.advertisementImage,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              placeholder: (context, url) => Image.asset(
                                AppImages.placeholder,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.placeholder,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: 0,
              child: ListView.builder(
                  itemCount: advertisementsController.advertisementsList.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.circle,
                          size: 10,
                          color: advertisementsController.currentAdvertisement.value == index
                              ? AppColors.MAIN_COLOR
                              : AppColors.GREY_COLOR,
                        ),
                      );
                    });
                  }),
            ),
          ],
        );
      }
    });
  }
}
