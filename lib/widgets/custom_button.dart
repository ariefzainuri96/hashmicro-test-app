import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool disable;
  final Color? backgroundColor;
  final Color? outlinedColor;
  final Function() onPressed;
  final bool isOutlined;
  final double borderRadius;
  final EdgeInsets? padding;
  final Color? customTextColor;
  final double? elevation;

  const CustomButton(
      {super.key,
      required this.title,
      this.disable = false,
      this.backgroundColor,
      this.outlinedColor,
      required this.onPressed,
      this.isOutlined = false,
      this.borderRadius = 8,
      this.padding,
      this.customTextColor,
      this.elevation});

  Color get _outlinedColor =>
      disable ? const Color(0xFFCBCCCD) : outlinedColor ?? Colors.blueAccent;
  Color get _backgroundColor => backgroundColor ?? Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: padding ?? const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color: _outlinedColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        onPressed: disable ? null : onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 14,
              color: disable ? const Color(0xff6B6B6B) : _outlinedColor),
        ),
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: const Color(0xFFCBCCCD),
          backgroundColor: _backgroundColor,
          padding: padding ?? const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
      onPressed: disable ? null : onPressed,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            color: disable ? const Color(0xff6B6B6B) : Colors.white),
      ),
    );
  }
}
