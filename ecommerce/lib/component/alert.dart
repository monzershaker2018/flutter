// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Container(
          height: 50,
          // ignore: prefer_const_constructors
          child: Center(
            child: const CircularProgressIndicator(),
          ),
        ));
      });
}
