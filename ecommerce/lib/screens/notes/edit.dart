// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, prefer_const_constructors_in_immutables, depend_on_referenced_packages, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/component/alert.dart';
import 'package:ecommerce/screens/notes/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditNotes extends StatefulWidget {
  final docId;
  final list;
  EditNotes({Key? key, required this.docId, required this.list})
      : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  String? title, note, imageurl;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    print(widget.list);
    super.initState();
  }

  var file;
  ImagePicker _imagepicker = ImagePicker();
  Reference? ref;
  var notecol = FirebaseFirestore.instance.collection("notes");
  editNo(context) async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      // if (imageurl == null) {
      //   // ignore: curly_braces_in_flow_control_structures
      //   return AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.error,
      //     animType: AnimType.rightSlide,
      //     title: 'Sorry!',
      //     desc: 'please select image .',
      //   ).show();
      // }

      if (file == null) {
        notecol.doc(widget.docId).update({
          'title': title,
          'note': note,
        });
      } else {
        await ref!.putFile(file);
        imageurl = await ref!.getDownloadURL();
        notecol
            .doc(widget.docId)
            .update({'title': title, 'note': note, 'imageurl': imageurl});
      }
    } else {
      print("not vaild data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Edit Notes"),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (value) {
                    title = value;
                  },
                  initialValue: widget.list['title'],
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'This Title Field is required';
                    }
                    if (value.length < 4) {
                      return 'This Title Field is too short';
                    }
                    if (value.length > 50) {
                      return 'This Title Field is too long';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (value) {
                    note = value;
                  },
                  initialValue: widget.list['note'],
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'This Note Field is required';
                    }
                    if (value.length < 4) {
                      return 'This Note Field is too short';
                    }
                    if (value.length > 50) {
                      return 'This Note Field is too long';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Note',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
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
                                    onTap: () async {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera),
                                        Text(" camera")
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.browse_gallery),
                                        Text(" Gallery")
                                      ],
                                    ),
                                    onTap: () async {
                                      var pickedimage =
                                          await _imagepicker.pickImage(
                                              source: ImageSource.gallery);
                                      if (pickedimage != null) {
                                        file = File(pickedimage.path);
                                        var rand = Random()
                                            .nextInt(1000000)
                                            .toString();
                                        var imagename =
                                            rand + basename(pickedimage.path);
                                        ref = FirebaseStorage.instance
                                            .ref("images")
                                            .child(imagename);
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text('upload image')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      showLoading(context);
                      await editNo(context);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text("Edit")),
              )
            ],
          ),
        )),
      ),
    );
  }
}
