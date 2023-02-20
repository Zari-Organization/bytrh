import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../Routes/routes.dart';
import '../../../../../Utils/app_icons.dart';

class TermConsultationsCartIcon extends StatelessWidget {
  TermConsultationsCartIcon({Key? key}) : super(key: key);
   final termConsultationsController = Get.find<TermConsultationsController>();
  @override
  Widget build(BuildContext context) {
    return  IconButton(
        splashRadius: 25,
        onPressed: () async {
          termConsultationsController.getConsultationsCart();
          await Get.toNamed(Routes.termConsultationsCartScreen);
        },
        icon: SvgPicture.asset(AppIcons.cart_icon),
    );
  }
}
