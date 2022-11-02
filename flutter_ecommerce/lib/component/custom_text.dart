// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final AlignmentGeometry alignment;
  const CustomText(
      {Key? key,
      this.text = '',
      this.size = 16,
      this.color = Colors.black,
      this.alignment = Alignment.topLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: alignment,
        child: Text(
          text,
          style: TextStyle(fontSize: size, color: color),
        ));
  }
}
