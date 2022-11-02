// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/component/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final AlignmentGeometry alignment;
  final void Function()? onPress;
  final double padding;
  const CustomButton(
      {Key? key,
      this.text = '',
      this.color = Colors.black,
      this.alignment = Alignment.topLeft,
      required this.onPress,
      this.padding = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onPress,
      child: CustomText(
        color: Colors.white,
        text: text,
        alignment: alignment,
        size: 20,
      ),
    );
  }
}
