// ignore_for_file: prefer_const_constructors, avoid_print, depend_on_referenced_packages

import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final ImagePicker picker = ImagePicker();
  File? file;
  uploadImage(ImageSource source) async {
    var pickimage = await picker.pickImage(source: source);

    if (pickimage != null) {
      file = File(pickimage.path);
      var rand = Random().nextInt(1000000);
      // get image name
      var imagename = basename(pickimage.path);
      var newname = '$rand$imagename';
      // upload image
      final storageRef = FirebaseStorage.instance.ref("images/$newname");
      await storageRef.putFile(file!);
      // get image url
      var url = await storageRef.getDownloadURL();
      print(url);
    } else {
      print("please select image");
    }
  }

  @override
  void initState() {
    super.initState();
    //addUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: ElevatedButton(
                child: Text(" upload image"),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('please select : '),
                              InkWell(
                                onTap: () async {
                                  uploadImage(ImageSource.camera);
                                },
                                child: Icon(Icons.camera),
                              ),
                              InkWell(
                                child: Icon(Icons.browse_gallery),
                                onTap: () async {
                                  uploadImage(ImageSource.gallery);
                                },
                              ),
                              ElevatedButton(
                                child: const Text('Close BottomSheet'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                })));
  }
}
