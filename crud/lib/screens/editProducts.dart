// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_constructors_in_immutables, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:crud/screens/products.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditSection extends StatefulWidget {
  final proId;
  final proName;
  final sectionId;

  const EditSection(
      {Key? key,
      required this.proId,
      required this.proName,
      required this.sectionId})
      : super(key: key);

  @override
  State<EditSection> createState() => _EditSectionState();
}

class _EditSectionState extends State<EditSection> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Categories'),
      ),
      body: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                //initialValue: widget.category_name,
                controller: _controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"))),
                  SizedBox(width: 10),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              updateProduct(widget.proId, _controller.text,
                                  widget.sectionId);

                              print(widget.proId +
                                  _controller.text +
                                  widget.sectionId);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Products()));
                            });
                            final snackBar = SnackBar(
                              content: const Text('Data Updated Successfully'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Text("Save"))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              deleteProduct(widget.proId);
                              // updateAlbum(_controller.text);
                              print(widget.proId);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Products()));
                            });
                            final snackBar = SnackBar(
                              content: const Text('Data Deleted Successfully'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Text("Delete"))),
                ],
              ),
            ),
          ]),
    );
  }

  Future updateProduct(int proId, String proName, int secId) async {
    try {
      var response = await Dio().put(
        'http://api.smart-vision-center.com/api/admin/products',
        data: {'id': proId, 'pro_name': proName, 'section_id': secId},
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

// delete cateogry

  Future deleteProduct(int id) async {
    try {
      var response = await Dio().delete(
        'http://api.smart-vision-center.com/api/admin/products/$id',
        data: {'id': id},
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
