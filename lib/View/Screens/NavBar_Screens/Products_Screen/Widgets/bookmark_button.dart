import 'package:bytrh/Logic/controllers/Products_Controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../Utils/app_colors.dart';

class BookMarkButton extends StatelessWidget {
  BookMarkButton({
    Key? key,
    required this.statusActive,
    required this.function,
  }) : super(key: key);
  final bool statusActive;
  final Function function;
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    if(GetStorage().read<String>('AccessToken') == null){
      return const SizedBox();
    }
    else{
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 35,
                offset: Offset(0, 15),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: AppColors.WHITE_COLOR,
            radius: 15,
            child: IconButton(
              onPressed: () => function(),
              splashRadius: 20,
              icon: Icon(
                statusActive ? Icons.favorite : Icons.favorite_border,
                color:
                statusActive ? AppColors.RED_COLOR : AppColors.BLACK_COLOR,
                size: 15,
              ),
            ),
          ),
        ),
      );
    }
  }
}
