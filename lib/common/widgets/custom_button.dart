import 'package:flutter/material.dart';
import 'package:quiz_memberid/core/style/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.color,
      this.height,
      this.width,
      this.foregroundColor,
      required this.func,
      required this.text});
  final Color? color;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final String text;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          side: BorderSide(color: AppColors.primaryColor, width: 1),
          elevation: 0,
          fixedSize: Size(width ?? 280, height ?? 32),
          backgroundColor: color ?? AppColors.primaryColor,
          foregroundColor: foregroundColor ?? Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      onPressed: func,
      child: Text(text),
    );
  }
}
