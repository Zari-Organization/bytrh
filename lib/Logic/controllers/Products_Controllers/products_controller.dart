import 'dart:developer';
import 'dart:io';
import 'package:bytrh/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Models/Products_Models/animal_product_cutting_model.dart'
    as animal_product_cutting_import;
import '../../../Models/Products_Models/animal_product_bagging_model.dart'
    as animal_product_bagging_import;
import '../../../Models/Products_Models/animal_product_details_model.dart'
    as animal_product_details_import;
import '../../../Models/Products_Models/animal_product_details_model.dart';
import '../../../Models/Products_Models/animal_products_model.dart'
    as animal_products_import;
import '../../../Models/Products_Models/products_animals_requests_model.dart'as products_animals_requests_import;
import '../../../Models/Products_Models/products_categories_model.dart'
    as products_categories_import;
import '../../../Models/Products_Models/products_my_animals_model.dart'
    as product_my_animals_import;
import '../../../Models/Products_Models/products_subCategories_model.dart'
    as products_sub_categories_import;
import '../../../Services/Products_Services/products_services.dart';
import '../../../Utils/app_colors.dart';

class ProductsController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    // getProductsCategory();
  }

  var isLoadingProductsCategory = false.obs;
  var productsCategoryList = <products_categories_import.Response>[].obs;
  var selectedProductsCategoryName = ''.obs;
  var idCategory = ''.obs;

  getProductsCategory() async {
    try {
      isLoadingProductsCategory(true);
      var response = await ProductsServices.getProductsCategory();
      if (response.response.isNotEmpty) {
        productsCategoryList.value = response.response;
        idCategory.value = response.response[0].idAnimalCategory.toString();
      }
    } finally {
      isLoadingProductsCategory(false);
    }
  }

  var isLoadingSubCategories = false.obs;
  var productsSubCategoriesList =
      <products_sub_categories_import.Response>[].obs;
  var selectedAnimalName = ''.obs;
  var idSubCategory = ''.obs;

  getProductSubCategories(String id) async {
    try {
      isLoadingSubCategories(true);
      var response = await ProductsServices.getProductSubCategories(id);
      if (response.success) {
        // productsSubCategoriesList.clear();
        productsSubCategoriesList.value = response.response;
        idSubCategory.value =
            response.response[0].idAnimalSubCategory.toString();
      }
    } finally {
      isLoadingSubCategories(false);
    }
  }

  var isLoadingAnimalProducts = false.obs;
  var animalProductsList = <animal_products_import.Response>[].obs;

  getAnimalProducts(String id) async {
    try {
      isLoadingAnimalProducts(true);
      var response = await ProductsServices.getAnimalProducts(id);
      if (response.success) {
        animalProductsList.value = response.response;
      }
    } finally {
      isLoadingAnimalProducts(false);
    }
  }

  var isLoadingAnimalProductDetails = false.obs;
  var animalProductDetails = animal_product_details_import.Response().obs;

  getAnimalProductDetails(String id) async {
    try {
      isLoadingAnimalProductDetails(true);
      var response = await ProductsServices.getAnimalProductDetails(id);
      if (response.success) {
        animalProductDetails.value = response.response;
        if (response.response.hasCutting == 1) {
          getAnimalProductCutting(
              id: response.response.idAnimalProduct.toString());
        }
        if (response.response.hasBagging == 1) {
          getAnimalProductBagging(
              id: response.response.idAnimalProduct.toString());
        }
        editAnimalAgeController.value.text = response.response.animalProductAge.toString();
        editAnimalSizeController.value.text = response.response.animalProductSize.toString();
        editAnimalDescriptionController.value.text = response.response.animalProductDescription.toString();
        editAnimalPriceController.value.text = response.response.animalProductPrice.toString();
        editAnimalGallery.value = response.response.gallery!;
      }
    } finally {
      isLoadingAnimalProductDetails(false);
    }
  }

  var cuttingChecked = true.obs;
  var cuttingNotChecked = false.obs;
  var baggingChecked = true.obs;
  var baggingNotChecked = false.obs;
  var deliveryChecked = true.obs;
  var deliveryNotChecked = false.obs;

  // var cuttingValue = ''.obs;
  // var baggingValue = ''.obs;
  var purchaseAnimalNoteController = TextEditingController().obs;

  var isLoadingAnimalProductCutting = false.obs;
  var animalProductCuttingList = <animal_product_cutting_import.Response>[].obs;

  var cuttingListValue = 0.obs;
  var baggingListValue = 0.obs;

  getAnimalProductCutting({required String id}) async {
    try {
      isLoadingAnimalProductCutting(true);
      var response = await ProductsServices.getAnimalProductCutting(id);
      if (response.success) {
        animalProductCuttingList.value = response.response;
      }
    } finally {
      isLoadingAnimalProductCutting(false);
    }
  }

  var isLoadingAnimalProductBagging = false.obs;
  var animalProductBaggingList = <animal_product_bagging_import.Response>[].obs;

  getAnimalProductBagging({required String id}) async {
    try {
      isLoadingAnimalProductBagging(true);
      var response = await ProductsServices.getAnimalProductBagging(id);
      if (response.success) {
        animalProductBaggingList.value = response.response;
      }
    } finally {
      isLoadingAnimalProductBagging(false);
    }
  }

  var isLoadingRequestPurchaseAnimalProduct = false.obs;

  requestPurchaseAnimalProduct({
    required String IDAnimalProduct,
    dynamic IDCutting,
    dynamic IDBagging,
    String? Delivery,
    String? Note,
    required BuildContext context,
  }) async {
    try {
      isLoadingRequestPurchaseAnimalProduct(true);
      var response = await ProductsServices.requestPurchaseAnimalProduct(
        IDAnimalProduct,
        IDCutting!,
        IDBagging!,
        Delivery!,
        Note!,
      );
      if (response["Success"]) {
          getProductsAnimalsRequests();
          Get.offNamed(Routes.productsAnimalsRequestsScreen);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              content: Text(
                response["ApiMsg"].toString(),
              ),
            ),
          );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingRequestPurchaseAnimalProduct(false);
    }
  }

  setDataToPurchaseAnimal(BuildContext context) {
    requestPurchaseAnimalProduct(
      context: context,
      IDAnimalProduct: animalProductDetails.value.idAnimalProduct.toString(),
      IDCutting: (cuttingChecked.value && animalProductCuttingList.isNotEmpty)
          ? cuttingListValue.value.toString()
          : '',
      IDBagging: (baggingChecked.value && animalProductBaggingList.isNotEmpty)
          ? baggingListValue.value.toString()
          : '',
      Delivery: deliveryChecked.value ? "1" : "0",
      Note: purchaseAnimalNoteController.value.text,
    );
  }

  var isLoadingAddProductAnimal = false.obs;
  var addAnimalAgeController = TextEditingController().obs;
  var addAnimalPriceController = TextEditingController().obs;
  var addAnimalSizeController = TextEditingController().obs;
  var addAnimalDescriptionController = TextEditingController().obs;
  var addCuttingToggleStatus = true.obs;
  var addBaggingToggleStatus = true.obs;
  var addDeliveryToggleStatus = true.obs;
  var addPhoneToggleStatus = true.obs;
  var addWhatsappToggleStatus = true.obs;
  var productAnimalsTypeList = <String>["SINGLE", "GROUP"].obs;
  var selectedProductAnimalsTypeValue = "SINGLE".obs;

  addProductAnimal(
      {required String IDAnimalSubCategory,
      required String IDCity,
      required String AnimalProductGender,
      required String AnimalProductAge,
      String? AnimalProductSize,
      String? AnimalProductPrice,
      String? AnimalProductDescription,
      required String AnimalProductType,
      required String HasBagging,
      required String HasCutting,
      required String HasDelivery,
      required String AllowPhone,
      required String AllowWhatsapp,
      required File AnimalProductImage,
      List<XFile>? AnimalProductGalleryList,
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
      isLoadingAddProductAnimal(true);
      var response = await ProductsServices().addProductAnimal(
        IDAnimalSubCategory: IDAnimalSubCategory,
        IDCity: IDCity,
        AnimalProductGender: AnimalProductGender,
        AnimalProductSize: AnimalProductSize,
        AnimalProductAge: AnimalProductAge,
        AnimalProductDescription: AnimalProductDescription,
        AnimalProductType: AnimalProductType,
        AnimalProductPrice: AnimalProductPrice,
        HasBagging: HasBagging,
        HasCutting: HasCutting,
        HasDelivery: HasDelivery,
        AllowPhone: AllowPhone,
        AllowWhatsapp: AllowWhatsapp,
        AnimalProductImage: AnimalProductImage,
        AnimalProductGalleryList: AnimalProductGalleryList,
        context: context,
      );
      if (response["Success"]) {
        getProductsMyAnimals();
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.MAIN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(response["ApiMsg"].toString()),
          ),
        );
        animalImageFile.value = File("");
        animalGallery.clear();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.MAIN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(response["ApiMsg"].toString()),
          ),
        );
      }
    } finally {
      isLoadingAddProductAnimal(false);
    }
  }

  var isLoadingEditProductAnimal = false.obs;

  var editAnimalAgeController = TextEditingController().obs;
  var editAnimalPriceController = TextEditingController().obs;
  var editAnimalSizeController = TextEditingController().obs;
  var editAnimalDescriptionController = TextEditingController().obs;
  var editAnimalGallery = <Gallery>[].obs;

  editProductAnimal(
      {
        required String IDAnimalProduct,
        String? IDAnimalSubCategory,
         String? IDCity,
         String? AnimalProductGender,
         String? AnimalProductAge,
        String? AnimalProductSize,
        String? AnimalProductPrice,
        String? AnimalProductDescription,
         String? AnimalProductType,
         String? HasBagging,
         String? HasCutting,
         String? HasDelivery,
         String? AllowPhone,
         String? AllowWhatsapp,
         File? AnimalProductImage,
        List<XFile>? AnimalProductGalleryList,
        required BuildContext context}) async {
    try {
      isLoadingEditProductAnimal(true);
      var response = await ProductsServices().editProductAnimal(
        IDAnimalProduct:IDAnimalProduct,
        IDAnimalSubCategory: IDAnimalSubCategory,
        IDCity: IDCity,
        AnimalProductGender: AnimalProductGender,
        AnimalProductSize: AnimalProductSize,
        AnimalProductAge: AnimalProductAge,
        AnimalProductDescription: AnimalProductDescription,
        AnimalProductType: AnimalProductType,
        AnimalProductPrice: AnimalProductPrice,
        HasBagging: HasBagging,
        HasCutting: HasCutting,
        HasDelivery: HasDelivery,
        AllowPhone: AllowPhone,
        AllowWhatsapp: AllowWhatsapp,
        AnimalProductImage: AnimalProductImage,
        AnimalProductGalleryList: AnimalProductGalleryList,
        context: context,
      );
      if (response["Success"]) {
        getProductsMyAnimals();
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.MAIN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(response["ApiMsg"].toString()),
          ),
        );
        editAnimalImageFile.value = File("");
        editAnimalGallery.clear();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.MAIN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(response["ApiMsg"].toString()),
          ),
        );
      }
    } finally {
      isLoadingEditProductAnimal(false);
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
      var response = await ProductsServices().removeFromAnimalGallery(
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

  var isLoadingProductsMyAnimals = false.obs;
  var productsMyAnimalsList = <product_my_animals_import.Response>[].obs;

  getProductsMyAnimals() async {
    try {
      isLoadingProductsMyAnimals(true);
      var response = await ProductsServices.getProductsMyAnimals();
      if (response.success) {
        productsMyAnimalsList.value = response.response;
      }
    } finally {
      isLoadingProductsMyAnimals(false);
    }
  }

  var isLoadingAddMyProductAnimalStatus = false.obs;

  addMyProductAnimalStatus(
    String IDAnimalProduct,
    String AnimalProductStatus,
    BuildContext context,
  ) async {
    try {
      isLoadingAddMyProductAnimalStatus(true);
      var response = await ProductsServices.addMyProductAnimalStatus(
        IDAnimalProduct,
        AnimalProductStatus,
      );
      if (response["Success"]) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingAddMyProductAnimalStatus(false);
    }
  }


  var isLoadingProductsAnimalsRequests = false.obs;
  var productsAnimalsRequestsList = <products_animals_requests_import.Response>[].obs;

  getProductsAnimalsRequests() async {
    try {
      isLoadingProductsAnimalsRequests(true);
      var response = await ProductsServices.getProductsAnimalsRequests();
      if (response.success) {
        productsAnimalsRequestsList.value = response.response;
      }
    } finally {
      isLoadingProductsAnimalsRequests(false);
    }
  }

  final ImagePicker _picker = ImagePicker();
  Rx<File?> animalImageFile = File("").obs;
  Rx<File?> editAnimalImageFile = File("").obs;

  void addAnimalImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    animalImageFile.value = File(pickedFile!.path);
  }

  void editAnimalImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    editAnimalImageFile.value = File(pickedFile!.path);
  }

  RxList<XFile> animalGallery = <XFile>[].obs;
  RxList<XFile> editNewAnimalGallery = <XFile>[].obs;

  void addAnimalGallery() async {
    List<XFile>? pickedFile = await _picker.pickMultiImage();
    if (pickedFile != null) {
      animalGallery.addAll(pickedFile);
    }
  }
  void pickNewAnimalGallery() async {
    List<XFile>? pickedFile = await _picker.pickMultiImage();
    if (pickedFile != null) {
      editNewAnimalGallery.addAll(pickedFile);
    }
  }
}
