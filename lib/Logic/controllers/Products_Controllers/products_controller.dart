import 'dart:developer';
import 'dart:io';
import 'package:bytrh/Routes/routes.dart';
import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/models/media/chat_media.dart';
import 'package:chat_package/models/media/media_type.dart';
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
import '../../../Models/Products_Models/products_animals_chat_messages_model.dart'
    as products_animals_chat_messages_import;
import '../../../Models/Products_Models/products_animals_requests_model.dart'
    as products_animals_requests_import;
import '../../../Models/Products_Models/products_categories_model.dart'
    as products_categories_import;
import '../../../Models/Products_Models/products_chat_list_model.dart'
    as products_chat_list_import;
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

  var inChatScreen = false.obs;

  productsReceiveMessageFromChat(String messageType, String message) {
    if (messageType == "TEXT") {
      productsChatMessages.add(ChatMessage(
        isSender: false,
        text: message,
      ));
      if (inChatScreen.value) {
        scrollController.value.jumpTo(
          scrollController.value.position.maxScrollExtent + 50,
        );
      }
    }
    if (messageType == "IMAGE") {
      productsChatMessages.add(ChatMessage(
        isSender: false,
        chatMedia: ChatMedia(
          url: message,
          mediaType: const MediaType.imageMediaType(),
        ),
      ));
      if (inChatScreen.value) {
        scrollController.value.jumpTo(
          scrollController.value.position.maxScrollExtent + 300,
        );
      }
    }
    if (messageType == "AUDIO") {
      productsChatMessages.add(ChatMessage(
        isSender: false,
        chatMedia: ChatMedia(
          url: message,
          mediaType: const MediaType.audioMediaType(),
        ),
      ));
      if (inChatScreen.value) {
        scrollController.value.jumpTo(
          scrollController.value.position.maxScrollExtent + 90,
        );
      }
    }
    log("Chat Messages List ----> ${productsChatMessages.toString()}");
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
        editAnimalAgeController.value.text =
            response.response.animalProductAge.toString();
        editAnimalSizeController.value.text =
            response.response.animalProductSize.toString();
        editAnimalDescriptionController.value.text =
            response.response.animalProductDescription.toString();
        editAnimalPriceController.value.text =
            response.response.animalProductPrice.toString();
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
      } else {
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
      {required String IDAnimalProduct,
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
        IDAnimalProduct: IDAnimalProduct,
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
      } else {
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
  var productsAnimalsRequestsList =
      <products_animals_requests_import.Response>[].obs;

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

  var isLoadingRequestAdoptionAnimalChat = false.obs;

  requestProductAnimalChat(String IDAnimalProduct, BuildContext context) async {
    try {
      isLoadingRequestAdoptionAnimalChat(true);
      var response = await ProductsServices.requestProductsAnimalChat(
        IDAnimalProduct,
      );
      if (response["Success"]) {
        await getProductsChatDetails(
          response["Response"].toString(),
        );
        Get.toNamed(Routes.productsChatScreen);
      } else {}
    } finally {
      isLoadingRequestAdoptionAnimalChat(false);
    }
  }

  var isLoadingProductsChatDetail = false.obs;
  var productsChatDetails =
      products_animals_chat_messages_import.Response().obs;
  var productsChatDetailsList =
      <products_animals_chat_messages_import.ChatDetail>[].obs;
  var productsChatMessages = <ChatMessage>[].obs;
  var scrollController = ScrollController().obs;

  getProductsChatDetails(String IDAnimalProductChat) async {
    try {
      isLoadingProductsChatDetail(true);
      var response = await ProductsServices.getProductsChatDetails(
        IDAnimalProductChat: IDAnimalProductChat,
      );
      if (response.success) {
        productsChatDetails.value = response.response;
        productsChatDetailsList.value = response.response.chatDetails!;
        productsChatMessages.clear();
        await addApiMessagesToClientChatUi();
      }
    } finally {
      isLoadingProductsChatDetail(false);
    }
  }

  addApiMessagesToClientChatUi() {
    for (int i = 0; i < productsChatDetailsList.length; i++) {
      if (productsChatDetailsList[i].chatType == "TEXT") {
        productsChatMessages.add(ChatMessage(
          isSender:
              productsChatDetailsList[i].chatSender == "BUYER" ? false : true,
          text: productsChatDetailsList[i].chatMessage,
        ));
      } else if (productsChatDetailsList[i].chatType == "IMAGE") {
        productsChatMessages.add(ChatMessage(
          isSender:
              productsChatDetailsList[i].chatSender == "BUYER" ? false : true,
          chatMedia: ChatMedia(
            url: productsChatDetailsList[i].chatMessage,
            mediaType: const MediaType.imageMediaType(),
          ),
        ));
      } else if (productsChatDetailsList[i].chatType == "AUDIO") {
        productsChatMessages.add(ChatMessage(
          isSender:
              productsChatDetailsList[i].chatSender == "BUYER" ? false : true,
          chatMedia: ChatMedia(
            url: productsChatDetailsList[i].chatMessage,
            mediaType: const MediaType.audioMediaType(),
          ),
        ));
      }
    }
  }

  var isLoadingSendAdoptionChatMessage = false.obs;

  sendChatMessageText({
    required String IDAnimalProductChat,
    required String ChatType,
    required String ChatMessage,
  }) async {
    try {
      isLoadingSendAdoptionChatMessage(true);
      var response = await ProductsServices.sendProductsChatMessageText(
        IDAnimalProductChat: IDAnimalProductChat,
        ChatType: ChatType,
        ChatMessage: ChatMessage,
        // context: context,
      );
      log(response["Success"].toString());
      if (response["Success"]) {
        log(response["Success"].toString());
      } else {
        log(response["Success"].toString());
      }
    } finally {
      isLoadingSendAdoptionChatMessage(false);
    }
  }

  sendChatMessageFile({
    required String IDAnimalProductChat,
    required String ChatType,
    XFile? ChatMessage,
    required BuildContext context,
  }) async {
    try {
      isLoadingSendAdoptionChatMessage(true);
      var response = await ProductsServices.sendProductsChatMessageFile(
        IDAnimalProductChat: IDAnimalProductChat,
        ChatType: ChatType,
        ChatMessage: ChatMessage,
        context: context,
      );
      log(response["Success"].toString());
      if (response["Success"]) {
        log(response["Success"].toString());
      } else {
        log(response["Success"].toString());
      }
    } finally {
      isLoadingSendAdoptionChatMessage(false);
    }
  }

  var isLoadingProductsChatList = false.obs;
  var productsChatList = <products_chat_list_import.Response>[].obs;

  getProductsChatList() async {
    try {
      isLoadingProductsChatList(true);
      var response = await ProductsServices.getProductsChatList();
      if (response.success) {
        productsChatList.value = response.response;
      }
    } finally {
      isLoadingProductsChatList(false);
    }
  }

  var isLoadingAddToBookmarks = false.obs;

  addToBookmarks({
    required String id,
    required BuildContext context,
  }) async {
    try {
      isLoadingAddToBookmarks(true);
      var response = await ProductsServices.addToBookmarks(id: id);
      if (response["Success"]) {
        getAnimalProducts(idSubCategory.value);
      }
    } finally {
      isLoadingAddToBookmarks(false);
    }
  }
  var isLoadingProductDeliveryRequest = false.obs;
  var productDeliveryAccepted = true.obs;
  var productDeliveryRejected = false.obs;
  var productDeliveryFeesController = TextEditingController().obs;
  var idAnimalProduct = ''.obs;

  productDeliveryRequest({
    required String IDAnimalProduct,
    required String AnimalProductStatus,
    required BuildContext context,
    String? DeliveryFees,
  }) async {
    try {
      isLoadingProductDeliveryRequest(true);
      var response = await ProductsServices.productDeliveryRequest(
        IDAnimalProduct: IDAnimalProduct,
        AnimalProductStatus: AnimalProductStatus,
        DeliveryFees: DeliveryFees,
      );
      if (response["Success"]) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
        getProductsAnimalsRequests();
      }else{
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
      isLoadingProductDeliveryRequest(false);
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
