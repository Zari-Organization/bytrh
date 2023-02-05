import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../Utils/app_colors.dart';

class CustomButton extends StatelessWidget {
   CustomButton({Key? key, this.title, this.backgroundColor, this.foregroundColor, this.overlayColor,this.onPress}) : super(key: key);
   final title;
   final backgroundColor;
   final foregroundColor;
   final overlayColor ;
   Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10)),
          overlayColor: MaterialStateProperty.all(
            overlayColor.withOpacity(0.1),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.MAIN_COLOR),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
