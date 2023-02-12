import 'package:flutter/material.dart';
import '../../Utils/app_colors.dart';

class TitledTextField extends StatelessWidget {
  TitledTextField({
    Key? key,
    required this.title,
    this.titleStyle,
    this.hintText,
    this.suffixIcon,
    this.perfix,
    this.controller,
    this.onPress,
    this.onChange,
    this.keyboardType,
    this.maxLines=1,
    this.textDirection,
    this.fillColor = AppColors.GREY_Light_COLOR,
    this.obscureText = false,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  String? hintText;
  final TextEditingController? controller;
  Widget? suffixIcon;
  Widget? perfix;
  Function()? onPress;
  Function(String)? onChange;
  TextInputType? keyboardType;
  TextDirection? textDirection;
  int maxLines;
  TextStyle? titleStyle;
  Color? fillColor;
  bool obscureText;
  bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        const SizedBox(height: 8),
        TextFormField(
          textDirection: textDirection,
          maxLines: maxLines,
          enabled: enabled,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onTap: onPress,
          controller: controller,
          onChanged: onChange,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.GREY_COLOR),
            prefixIcon: perfix,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
