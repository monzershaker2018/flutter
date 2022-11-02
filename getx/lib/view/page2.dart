// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/lang/local_controller.dart';
import 'package:getx/view/page3.dart';

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.find();
    return Scaffold(
        appBar: AppBar(title: Text("homepage".tr)),
        body: Padding(
          padding: const EdgeInsets.all(58.0),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    // Get.defaultDialog(
                    //     title: "Success",
                    //     middleText: " user added success",
                    //     textCancel: "Cancel",
                    //     textConfirm: "Confirm");
                    controller.updateLang('ar');
                  },
                  child: Text("arabic".tr)),
              ElevatedButton(
                onPressed: () {
                  // Get.bottomSheet(
                  //     backgroundColor: Colors.blue,
                  //     exitBottomSheetDuration: Duration(milliseconds: 500),
                  //     enterBottomSheetDuration: Duration(milliseconds: 500),
                  //     Container(
                  //       height: 170,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(20),
                  //         topRight: Radius.circular(20),
                  //       )),
                  //     ));
                  controller.updateLang('en');
                },
                child: Text("english".tr),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       Get.snackbar("Success", "User Added Succeffuly",
              //           icon: Icon(Icons.done),
              //           backgroundColor: Colors.green,
              //           snackPosition: SnackPosition.BOTTOM);
              //     },
              //     child: Text('Snack BAr')),
              ElevatedButton(
                  onPressed: () {
                    Get.to(Tharid(), arguments: {
                      'name': 'Monzer',
                      'age': '20',
                    });
                  },
                  child: Text('Snack BAr')),
            ],
          ),
        ));
  }
}
