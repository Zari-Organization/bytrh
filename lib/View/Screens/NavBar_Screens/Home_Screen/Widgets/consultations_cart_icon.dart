import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../Routes/routes.dart';
import '../../../../../Utils/app_icons.dart';

class ConsultationsCartIcon extends StatelessWidget {
   ConsultationsCartIcon({Key? key}) : super(key: key);
   final instantConsultationsController =
   Get.find<InstantConsultationsController>();
  @override
  Widget build(BuildContext context) {
    return  IconButton(
        splashRadius: 25,
        onPressed: () async {
           instantConsultationsController.getConsultationsCart();
          await Get.toNamed(Routes.instantsConsultationsCartScreen);
        },
        icon: SvgPicture.asset(AppIcons.cart_icon),
    );
  }
}
