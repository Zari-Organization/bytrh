import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Utils/app_colors.dart';
import '../../../../../Logic/controllers/Products_Controllers/products_controller.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({Key? key}) : super(key: key);
  final productsController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if(productsController.animalProductDetails.value.animalProductAge!=null)
            Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.BLACK_COLOR)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    productsController.animalProductDetails.value.animalProductAge,
                    style: TextStyle(color: AppColors.MAIN_COLOR),
                  ),
                  Text("السن"),
                ],
              ),
            ),
          SizedBox(width: 5),
          if(productsController.animalProductDetails.value.animalProductGender!=null)
            Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.BLACK_COLOR)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productsController.animalProductDetails.value.animalProductGender,
                    style: TextStyle(color: AppColors.MAIN_COLOR),
                  ),
                  Text("النوع"),
                ],
              ),
            ),
          SizedBox(width: 5),
          if(productsController.animalProductDetails.value.animalProductSize!=null)
            Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.BLACK_COLOR)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productsController.animalProductDetails.value.animalProductSize.toString(),
                    style: TextStyle(color: AppColors.MAIN_COLOR),
                  ),
                  Text("الوزن"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
