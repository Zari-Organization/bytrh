import 'package:bytrh/Utils/app_colors.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
   FilterButton({Key? key, required this.title}) : super(key: key);
   String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xffFAFAFA)),
        foregroundColor: MaterialStateProperty.all(AppColors.BLACK_COLOR),
      ),
      onPressed: () {},
      child: Text(title),
    );
  }
}
