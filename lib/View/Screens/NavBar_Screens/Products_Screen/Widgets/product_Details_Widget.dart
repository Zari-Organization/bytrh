import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Utils/app_colors.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "18",
                        style: TextStyle(color: AppColors.MAIN_COLOR),
                      ),
                      SizedBox(width: 5),
                      Text("شهر",style: TextStyle(color: AppColors.MAIN_COLOR),),
                    ],
                  ),
                  Text("السن"),
                ],
              ),
            ),
          SizedBox(width: 5),
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
                    "أنثى",
                    style: TextStyle(color: AppColors.MAIN_COLOR),
                  ),
                  Text("النوع"),
                ],
              ),
            ),
          SizedBox(width: 5),
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
                    "290 كجم",
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
