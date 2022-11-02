// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Tharid extends StatelessWidget {
  const Tharid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("page 3")),
        body: Center(
            child: ElevatedButton(onPressed: () async {}, child: Text(''))));
  }
}
