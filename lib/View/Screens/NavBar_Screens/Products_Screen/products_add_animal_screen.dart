import 'dart:developer';
import 'dart:io';

import 'package:bytrh/Utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_icons.dart';
import '../../../../../../Utils/app_images.dart';
import '../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../Widgets/auth_button.dart';
import '../../../Widgets/custom_circle_progress.dart';
import '../Home_Screen/Screens/Adoption_Screens/Widgets/animals_city_filter.dart';
import '../Home_Screen/Screens/Adoption_Screens/Widgets/animals_country_filter.dart';
import '../Home_Screen/Screens/Adoption_Screens/Widgets/animals_gender_filter.dart';
import '../Home_Screen/Screens/Adoption_Screens/Widgets/custom_textField_widget.dart';
import 'Widgets/product_animal_category_filter.dart';
import 'Widgets/product_animal_subCategories_filter.dart';
import 'Widgets/product_animal_type_filter.dart';

class ProductsAddAnimalScreen extends StatelessWidget {
  ProductsAddAnimalScreen({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();
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
            title: Text("إضافة حيوان للبيع"),
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
                          productsController.addAnimalImage();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Color(0xffEFEEEE),
                              borderRadius: BorderRadius.circular(15)),
                          child: productsController
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
                                productsController.animalImageFile.value!,
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      if (productsController.animalImageFile.value!.path.isNotEmpty)
                        CircleAvatar(
                          backgroundColor: AppColors.WHITE_COLOR,
                          child: IconButton(
                            onPressed: () {
                              productsController.animalImageFile.value = File("");
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
                  ProductAnimalsCategoryFilter(),
                  ProductAnimalSubCategoryFilter(),
                  AnimalsGenderFilter(),
                  ProductAnimalsTypeFilter(),
                  AnimalsCountryFilter(),
                  AnimalsCityFilter(),
                  SizedBox(height: 20),
                  CustomTextFieldWidget(
                    hintText:
                    "السن",
                    keyboardType: TextInputType.number,
                    controller: productsController.addAnimalAgeController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "السعر",
                    keyboardType: TextInputType.number,
                    controller:
                    productsController.addAnimalPriceController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "الحجم",
                    keyboardType: TextInputType.number,
                    controller:
                    productsController.addAnimalSizeController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "الوصف",
                    maxLines: 3,
                    controller:
                    productsController.addAnimalDescriptionController.value,
                  ),
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
                          productsController.animalGallery.isEmpty
                              ? SizedBox()
                              : ListView.separated(
                            itemCount:
                            productsController.animalGallery.length,
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
                                        productsController.animalGallery
                                            .remove(productsController
                                            .animalGallery[index]);
                                        log(productsController
                                            .animalGallery.length
                                            .toString());
                                        log(productsController
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
                                              productsController
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
                              productsController.addAnimalGallery();
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
                  SizedBox(height: 50),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: (){
                      productsController.addCuttingToggleStatus.value = !productsController.addCuttingToggleStatus.value;
                    },
                    title: Text("الذبح"),
                    trailing: CupertinoSwitch(
                      // activeColor: AppColors.GREEN_COLOR,
                      // thumbColor: AppColors.RED_COLOR,
                      trackColor: Colors.grey.shade300,
                      value: productsController.addCuttingToggleStatus.value,
                      onChanged: (value) {
                        productsController.addCuttingToggleStatus.value = !productsController.addCuttingToggleStatus.value;
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: (){
                      productsController.addBaggingToggleStatus.value = !productsController.addBaggingToggleStatus.value;
                    },
                    title: Text("التغليف"),
                    trailing: CupertinoSwitch(
                      // activeColor: AppColors.GREEN_COLOR,
                      // thumbColor: AppColors.RED_COLOR,
                      trackColor: Colors.grey.shade300,
                      value: productsController.addBaggingToggleStatus.value,
                      onChanged: (value) {
                        productsController.addBaggingToggleStatus.value = !productsController.addBaggingToggleStatus.value;
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: (){
                      productsController.addDeliveryToggleStatus.value = !productsController.addDeliveryToggleStatus.value;
                    },
                    title: Text("التوصيل"),
                    trailing: CupertinoSwitch(
                      // activeColor: AppColors.GREEN_COLOR,
                      // thumbColor: AppColors.RED_COLOR,
                      trackColor: Colors.grey.shade300,
                      value: productsController.addDeliveryToggleStatus.value,
                      onChanged: (value) {
                        productsController.addDeliveryToggleStatus.value = !productsController.addDeliveryToggleStatus.value;
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: (){
                      productsController.addPhoneToggleStatus.value = !productsController.addPhoneToggleStatus.value;
                    },
                    title: Text("التواصل عبر الهاتف"),
                    trailing: CupertinoSwitch(
                      // activeColor: AppColors.GREEN_COLOR,
                      // thumbColor: AppColors.RED_COLOR,
                      trackColor: Colors.grey.shade300,
                      value: productsController.addPhoneToggleStatus.value,
                      onChanged: (value) {
                        productsController.addPhoneToggleStatus.value = !productsController.addPhoneToggleStatus.value;
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: (){
                      productsController.addWhatsappToggleStatus.value = !productsController.addWhatsappToggleStatus.value;
                    },
                    title: Text("التواصل عبر الواتساب"),
                    trailing: CupertinoSwitch(
                      // activeColor: AppColors.GREEN_COLOR,
                      // thumbColor: AppColors.RED_COLOR,
                      trackColor: Colors.grey.shade300,
                      value: productsController.addWhatsappToggleStatus.value,
                      onChanged: (value) {
                        productsController.addWhatsappToggleStatus.value = !productsController.addWhatsappToggleStatus.value;
                      },
                    ),
                  ),
                  SizedBox(height: 100),
                  ConditionalBuilder(
                    condition:
                    !productsController.isLoadingAddProductAnimal.value,
                    builder: (context) => CustomButton(
                        title: "حفظ",
                        // backgroundColor: AppColors.MAIN_COLOR,
                        foregroundColor: AppColors.WHITE_COLOR,
                        overlayColor: AppColors.WHITE_COLOR,
                        onPress: () {
                          productsController.addProductAnimal(
                            IDAnimalSubCategory: productsController.idSubCategory.value,
                            IDCity: adoptionController.idCity.value,
                            AnimalProductGender: adoptionController.selectedAdoptionAnimalsGenderValue.value,
                            AnimalProductAge: productsController.addAnimalAgeController.value.text,
                            AnimalProductSize: productsController.addAnimalSizeController.value.text,
                            AnimalProductPrice: productsController.addAnimalPriceController.value.text,
                            AnimalProductDescription: productsController.addAnimalDescriptionController.value.text,
                            AnimalProductType: productsController.selectedProductAnimalsTypeValue.value,
                            HasBagging: productsController.addBaggingToggleStatus.value?"1":"0",
                            HasCutting: productsController.addCuttingToggleStatus.value?"1":"0",
                            HasDelivery: productsController.addDeliveryToggleStatus.value?"1":"0",
                            AllowPhone: productsController.addPhoneToggleStatus.value?"1":"0",
                            AllowWhatsapp: productsController.addWhatsappToggleStatus.value?"1":"0",
                            AnimalProductImage: productsController.animalImageFile.value!,
                            AnimalProductGalleryList: productsController.animalGallery,
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
