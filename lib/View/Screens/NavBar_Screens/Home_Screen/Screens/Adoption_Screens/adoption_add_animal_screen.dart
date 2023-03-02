import 'dart:developer';
import 'dart:io';

import 'package:bytrh/Utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_icons.dart';
import '../../../../../../Utils/app_images.dart';
import '../../../../../Widgets/auth_button.dart';
import '../../../../../Widgets/custom_circle_progress.dart';
import 'Widgets/animals_category_filter.dart';
import 'Widgets/animals_city_filter.dart';
import 'Widgets/animals_country_filter.dart';
import 'Widgets/animals_gender_filter.dart';
import 'Widgets/custom_textField_widget.dart';
import 'Widgets/pet_details_widget.dart';

class AdoptionAddAnimalScreen extends StatelessWidget {
  AdoptionAddAnimalScreen({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.MAIN_COLOR,
            centerTitle: true,
            title: Text("إضافة حيوان للتبني"),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          adoptionController.addAnimalImage();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Color(0xffEFEEEE),
                              borderRadius: BorderRadius.circular(15)),
                          child: adoptionController
                                  .animalImageFile.value!.path.isEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.upload_icon,
                                      color: AppColors.SECOND_COLOR,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "إضافة صورة",
                                      style: TextStyle(
                                        color: AppColors.SECOND_COLOR,
                                      ),
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                      adoptionController.animalImageFile.value!,
                                      fit: BoxFit.fill),
                                ),
                        ),
                      ),
                      if (adoptionController
                          .animalImageFile.value!.path.isNotEmpty)
                        CircleAvatar(
                          backgroundColor: AppColors.WHITE_COLOR,
                          child: IconButton(
                            onPressed: () {
                              adoptionController.animalImageFile.value =
                                  File("");
                            },
                            icon: SvgPicture.asset(
                              AppIcons.delete_icon,
                              color: AppColors.RED_COLOR,
                            ),
                          ),
                        )
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextFieldWidget(
                    hintText: "أسم الحيوان",
                    controller:
                        adoptionController.addAnimalNameController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "السلالة",
                    controller:
                        adoptionController.addAnimalStrainController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText:
                    "السن : مثال ( 1.2=عام وشهرين )",
                    keyboardType: TextInputType.number,
                    controller: adoptionController.addAnimalAgeController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "اللون : مثال ( ابيض او White )",
                    controller:
                        adoptionController.addAnimalColorController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "الحجم : مثال ( كبير او Big )",
                    controller:
                        adoptionController.addAnimalSizeController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "الحالة : مثال ( نظيف او Clean )",
                    controller:
                        adoptionController.addAnimalConditionController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "الوصف",
                    maxLines: 3,
                    controller:
                        adoptionController.addAnimalDescriptionController.value,
                  ),
                  AnimalsCategoryFilter(),
                  AnimalsGenderFilter(),
                  AnimalsCountryFilter(),
                  AnimalsCityFilter(),
                  SizedBox(height: 20),
                  Text(
                    "الألبوم",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          adoptionController.animalGallery.isEmpty
                              ? SizedBox()
                              : ListView.separated(
                                  itemCount:
                                      adoptionController.animalGallery.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: AppColors.RED_COLOR,
                                          child: IconButton(
                                            onPressed: () {
                                              adoptionController.animalGallery
                                                  .remove(adoptionController
                                                      .animalGallery[index]);
                                              log(adoptionController
                                                  .animalGallery.length
                                                  .toString());
                                              log(adoptionController
                                                  .animalGallery
                                                  .map(
                                                      (element) => element.path)
                                                  .toString());
                                            },
                                            icon: SvgPicture.asset(
                                              AppIcons.delete_icon,
                                              color: AppColors.WHITE_COLOR,
                                              // height: 10,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Color(0xffEFEEEE),
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: FileImage(
                                                  File(
                                                    adoptionController
                                                        .animalGallery[index]
                                                        .path,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 8),
                                ),
                          InkWell(
                            onTap: () {
                              adoptionController.addAnimalGallery();
                            },
                            child: Container(
                              width: 120,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Color(0xffEFEEEE),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.upload_icon,
                                    color: AppColors.SECOND_COLOR,
                                  ),
                                  Text(
                                    "إضافة صورة",
                                    style: TextStyle(
                                      color: AppColors.SECOND_COLOR,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  ConditionalBuilder(
                    condition:
                        !adoptionController.isLoadingAddAdoptionAnimal.value,
                    builder: (context) => CustomButton(
                        title: "حفظ",
                        // backgroundColor: AppColors.MAIN_COLOR,
                        foregroundColor: AppColors.WHITE_COLOR,
                        overlayColor: AppColors.WHITE_COLOR,
                        onPress: () {
                          var age = adoptionController.addAnimalAgeController.value.text;
                          var year = '';
                          var month = '';
                          if(age.contains('.')){
                            year = age.split('.')[0]==''?"0":adoptionController.addAnimalAgeController.value.text.split('.')[0];
                            month = age.split('.')[1]==''?"0":adoptionController.addAnimalAgeController.value.text.split('.')[1];
                          }
                          else{
                            year = age;
                            month = "0";
                          }
                          adoptionController.addAdoptionAnimal(
                                  IDAnimalSubCategory: adoptionController.selectedAdoptionAnimalsCategoryValue.value,
                                  IDCity: adoptionController.idCity.value,
                                  PetName: adoptionController.addAnimalNameController.value.text,
                                  PetStrain: adoptionController.addAnimalStrainController.value.text,
                                  PetColor: adoptionController.addAnimalColorController.value.text,
                                  PetGender: adoptionController.selectedAdoptionAnimalsGenderValue.value,
                                  PetAgeMonth: month,
                                  PetAgeYear: year,
                                  PetSize: adoptionController.addAnimalSizeController.value.text,
                                  PetCondition: adoptionController.addAnimalConditionController.value.text,
                                  PetDescription: adoptionController.addAnimalDescriptionController.value.text,
                                  AdoptionContact: "1",
                                  PetPicture: adoptionController.animalImageFile.value!,
                                  AdoptionGalleryList: adoptionController.animalGallery,
                                  context: context,
                                );
                        }
                        ),
                    fallback: (context) => const CustomCircleProgress(),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
