import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.tileColor,
    this.borderRadius,
    this.trailing,
    this.titleColor= AppColors.MAIN_COLOR,
    this.iconColor= AppColors.MAIN_COLOR,
  }) : super(key: key);

  String icon;
  String title;
  Function()? onTap;
  Color? titleColor ;
  Color? iconColor ;
  Color? tileColor ;
  double? borderRadius ;
  Widget? trailing ;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius??0)
      ),
      elevation: 0.2,
      child: ListTile(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius??0)
        ),
        tileColor: tileColor,
        leading: SvgPicture.asset(
          icon,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: titleColor,
            // fontWeight: FontWeight.bold,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
