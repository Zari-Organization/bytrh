import 'dart:developer';
import 'dart:io';
import 'package:bytrh/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Models/Adoptions_Models/adoption_animals_categories_model.dart'
    as adoption_animals_categories_import;
import '../../../Models/Adoptions_Models/adoption_details_model.dart'
    as adoption_details_import;
import '../../../Models/Adoptions_Models/adoption_details_model.dart';
import '../../../Models/Adoptions_Models/adoption_list_model.dart'
    as adoption_list_import;
import '../../../Routes/routes.dart';
import '../../../Services/Adoptions_Services/adoptions_services.dart';
import '../../../Models/Location_Models/countries_model.dart'
    as countries_import;
import '../../../Models/Location_Models/cities_model.dart' as cities_import;
import '../../../Services/auth_services.dart';

class AdoptionController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    getAdoptionsList();
  }

  var isLoadingAdoptions = false.obs;

  var adoptionsList = <adoption_list_import.Response>[].obs;

  getAdoptionsList() async {
    try {
      isLoadingAdoptions(true);
      var response = await AdoptionsServices.getAdoptionsList("ACTIVE");
      if (response.success) {
        adoptionsList.value = response.response;
      }
    } finally {
      isLoadingAdoptions(false);
    }
  }

  var isLoadingMyAdoptions = false.obs;
  var myAdoptionsList = <adoption_list_import.Response>[].obs;

  getMyAdoptionsList() async {
    try {
      isLoadingMyAdoptions(true);
      var response = await AdoptionsServices.getAdoptionsList("HISTORY");
      if (response.success) {
        myAdoptionsList.value = response.response;
      }
    } finally {
      isLoadingMyAdoptions(false);
    }
  }

  var isLoadingAdoptionDetails = false.obs;
  var adoptionsDetails = adoption_details_import.Response().obs;
  var idAdoption = ''.obs;

  setDataToAdoptionDetails(String id) async {
    idAdoption.value = id;
    getAdoptionDetails();
    await Get.toNamed(Routes.adoptionDetailsScreen);
  }

  getAdoptionDetails() async {
    try {
      isLoadingAdoptionDetails(true);
      var response = await AdoptionsServices.getAdoptionDetails(
        idAdoption.value,
      );
      if (response.success) {
        adoptionsDetails.value = response.response;
      }
    } finally {
      isLoadingAdoptionDetails(false);
    }
  }

  var isLoadingAdoptionMyAnimalsDetails = false.obs;
  var adoptionsMyAnimalsDetails = adoption_details_import.Response().obs;
  var idAdoptionMyAnimals = ''.obs;

  setDataToAdoptionMyAnimalsDetails(String id) async {
    idAdoptionMyAnimals.value = id;
    getAdoptionMyAnimalsDetails();
    await Get.toNamed(Routes.adoptionMyAnimalsDetailsScreen);
  }

  getAdoptionMyAnimalsDetails() async {
    try {
      isLoadingAdoptionMyAnimalsDetails(true);
      var response = await AdoptionsServices.getAdoptionDetails(
        idAdoptionMyAnimals.value,
      );
      if (response.success) {
        adoptionsMyAnimalsDetails.value = response.response;
        editAnimalNameController.value.text =
            response.response.petName.toString();
        editAnimalStrainController.value.text =
            response.response.petStrain.toString();
        editAnimalAgeController.value.text =
            response.response.petAgeYear.toString();
        editAnimalConditionController.value.text =
            response.response.petCondition.toString();
        editAnimalColorController.value.text =
            response.response.petColor.toString();
        editAnimalSizeController.value.text =
            response.response.petSize.toString();
        editAnimalDescriptionController.value.text =
            response.response.petDescription.toString();
        editAnimalGallery.value = response.response.adoptionGallery!;
      }
    } finally {
      isLoadingAdoptionMyAnimalsDetails(false);
    }
  }


  var isLoadingAdoptionAnimalsCategory = false.obs;
  var adoptionAnimalsCategoryList =
      <adoption_animals_categories_import.Response>[].obs;
  var selectedAdoptionAnimalsCategoryValue = ''.obs;
  var adoptionAnimalsGenderList = <String>["MALE", "FEMALE"].obs;
  var selectedAdoptionAnimalsGenderValue = "FEMALE".obs;

  getAdoptionAnimalsCategory() async {
    try {
      isLoadingAdoptionAnimalsCategory(true);
      var response = await AdoptionsServices.getAdoptionAnimalsCategory();
      if (response.success) {
        adoptionAnimalsCategoryList.value = response.response;
        selectedAdoptionAnimalsCategoryValue.value =
            response.response[0].idAnimalSubCategory.toString();
      }
    } finally {
      isLoadingAdoptionAnimalsCategory(false);
    }
  }

  var isLoadingRemoveFromAnimalGallery = false.obs;

  removeFromAnimalGallery(
    int idImage,
    int index,
    BuildContext context,
  ) async {
    try {
      isLoadingRemoveFromAnimalGallery(true);
      var response = await AdoptionsServices().removeFromAnimalGallery(
        idImage,
      );
      if (response["Success"]) {
        editAnimalGallery.remove(editAnimalGallery[index]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // backgroundColor: AppColors.GREEN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingRemoveFromAnimalGallery(false);
    }
  }

  var isLoadingCountries = false.obs;
  var countriesList = <countries_import.Country>[].obs;
  var idCountry = ''.obs;

  getCountries() async {
    var countries = await AuthServices.getCountries();
    try {
      isLoadingCountries(true);
      if (countries.success) {
        countriesList.value = countries.response.countries;
        idCountry.value = countries.response.countries[0].idCountry.toString();
      }
    } finally {
      isLoadingCountries(false);
    }
  }

  var isLoadingCities = false.obs;
  var citiesList = <cities_import.Country>[].obs;
  var idCity = ''.obs;

  getCities() async {
    var cities = await AuthServices.getCities(idCountry.value);
    try {
      isLoadingCities(true);
      if (cities.success) {
        citiesList.value = cities.response.countries;
      }
    } finally {
      isLoadingCities(false);
    }
  }

  var isLoadingAddAdoptionAnimal = false.obs;
  var addAnimalNameController = TextEditingController().obs;
  var addAnimalStrainController = TextEditingController().obs;
  var addAnimalAgeController = TextEditingController().obs;
  var addAnimalConditionController = TextEditingController().obs;
  var addAnimalColorController = TextEditingController().obs;
  var addAnimalSizeController = TextEditingController().obs;
  var addAnimalDescriptionController = TextEditingController().obs;

  addAdoptionAnimal(
      {required String IDAnimalSubCategory,
      required String IDCity,
      required String PetName,
      required String PetStrain,
      required String PetColor,
      required String PetGender,
      required String PetAgeMonth,
      required String PetAgeYear,
      String? PetSize,
      String? PetCondition,
      String? PetDescription,
      required String AdoptionContact,
      required File PetPicture,
      List<XFile>? AdoptionGalleryList,
      required BuildContext context}) async {
    if (animalImageFile.value!.path == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("أضف صورة الحيوان"),
        ),
      );
    }
    try {
      isLoadingAddAdoptionAnimal(true);
      var response = await AdoptionsServices().addAdoptionAnimal(
        IDAnimalSubCategory: IDAnimalSubCategory,
        IDCity: IDCity,
        PetName: PetName,
        PetStrain: PetStrain,
        PetColor: PetColor,
        PetGender: PetGender,
        PetAgeMonth: PetAgeMonth,
        PetAgeYear: PetAgeYear,
        PetSize: PetSize,
        PetCondition: PetCondition,
        PetDescription: PetDescription,
        AdoptionContact: AdoptionContact,
        PetPicture: PetPicture,
        AdoptionGalleryList: AdoptionGalleryList,
        context: context,
      );
      if (response["Success"]) {
        log(response["ApiMsg"]);
        getMyAdoptionsList();
        Get.toNamed(Routes.adoptionMyAnimalsScreen);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.MAIN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(response["ApiMsg"].toString()),
          ),
        );
      }
    } finally {
      animalImageFile.value = File("");
      animalGallery.clear();
      isLoadingAddAdoptionAnimal(false);
    }
  }


  var isLoadingEditMyAdoptionAnimal = false.obs;
  var editAnimalNameController = TextEditingController().obs;
  var editAnimalStrainController = TextEditingController().obs;
  var editAnimalAgeController = TextEditingController().obs;
  var editAnimalConditionController = TextEditingController().obs;
  var editAnimalColorController = TextEditingController().obs;
  var editAnimalSizeController = TextEditingController().obs;
  var editAnimalDescriptionController = TextEditingController().obs;
  var editAnimalGallery = <AdoptionGallery>[].obs;

  editMyAdoptionAnimal(
      { String? IDAnimalSubCategory,
         String? IDCity,
         String? PetName,
         String? PetStrain,
         String? PetColor,
         String? PetGender,
         String? PetAgeMonth,
         String? PetAgeYear,
        String? PetSize,
        String? PetCondition,
        String? PetDescription,
         String? AdoptionContact,
         required String IDAdoption,
         File? PetPicture,
        List<XFile>? AdoptionGalleryList,
        required BuildContext context}) async {
    try {
      isLoadingEditMyAdoptionAnimal(true);
      var response = await AdoptionsServices().editMyAdoptionAnimal(
        IDAnimalSubCategory: IDAnimalSubCategory,
        IDCity: IDCity,
        PetName: PetName,
        PetStrain: PetStrain,
        PetColor: PetColor,
        PetGender: PetGender,
        PetAgeMonth: PetAgeMonth,
        PetAgeYear: PetAgeYear,
        PetSize: PetSize,
        PetCondition: PetCondition,
        PetDescription: PetDescription,
        AdoptionContact: AdoptionContact,
        IDAdoption: IDAdoption,
        PetPicture: PetPicture,
        AdoptionGalleryList: AdoptionGalleryList,
        context: context,
      );
      if (response["Success"]) {
        log(response["ApiMsg"]);
        getMyAdoptionsList();
        Get.toNamed(Routes.adoptionMyAnimalsScreen);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.MAIN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(response["ApiMsg"].toString()),
          ),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(response["ApiMsg"].toString()),
          ),
        );
      }
    } finally {
      editNewAnimalImageFile.value = File("");
      editNewAnimalGallery.clear();
      isLoadingEditMyAdoptionAnimal(false);
    }
  }

  var isLoadingAddMyAdoptionAnimalStatus = false.obs;

  addMyAdoptionAnimalStatus( String IDAdoption, String AdoptionStatus, BuildContext context) async {
    try {
      isLoadingAddMyAdoptionAnimalStatus(true);
      var response = await AdoptionsServices.addMyAdoptionAnimalStatus(
        IDAdoption,
        AdoptionStatus,
      );
      if (response["Success"]) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(response["ApiMsg"].toString(),),
          ),
        );
      }
    } finally {
      isLoadingAddMyAdoptionAnimalStatus(false);
    }
  }


  void openEmail(String path) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: path,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }



  final ImagePicker _picker = ImagePicker();
  Rx<File?> animalImageFile = File("").obs;

  void addAnimalImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    animalImageFile.value = File(pickedFile!.path);
  }
  Rx<File?> editNewAnimalImageFile = File("").obs;

  void pickNewAnimalImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    editNewAnimalImageFile.value = File(pickedFile!.path);
  }

  RxList<XFile> animalGallery = <XFile>[].obs;

  void addAnimalGallery() async {
    List<XFile>? pickedFile = await _picker.pickMultiImage();
    if (pickedFile != null) {
      animalGallery.addAll(pickedFile);
    }
  }
  RxList<XFile> editNewAnimalGallery = <XFile>[].obs;

  void pickNewAnimalGallery() async {
    List<XFile>? pickedFile = await _picker.pickMultiImage();
    if (pickedFile != null) {
      editNewAnimalGallery.addAll(pickedFile);
    }
  }
}
