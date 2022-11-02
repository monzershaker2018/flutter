// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final ImagePicker picker = ImagePicker();
  var file;
  uploadImage(ImageSource source) async {
    var pickimage = await picker.pickImage(source: source);

    if (pickimage != null) {
      file = File(pickimage.path);
      // get image name
      var imagename = basename(pickimage.path);
      // upload image
      final storageRef = FirebaseStorage.instance.ref(imagename);
      await storageRef.putFile(file);
      // get image url
      var url = storageRef.getDownloadURL();
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
