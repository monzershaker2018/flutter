// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_print, unnecessary_new

import 'package:crud/screens/categories.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditCategoriesScreen extends StatefulWidget {
  final String category_id;
  final String category_name;

  EditCategoriesScreen(
      {Key? key, required this.category_name, required this.category_id})
      : super(key: key);

  @override
  State<EditCategoriesScreen> createState() => _EditCategoriesScreenState();
}

class _EditCategoriesScreenState extends State<EditCategoriesScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                              updateCategory(widget.category_id.toString(),
                                  _controller.text);
                              print(_controller.text +
                                  widget.category_id.toString());
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new CategoriesScreen()));
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
                              deleteCategory(widget.category_id.toString());
                              // updateAlbum(_controller.text);
                              print(widget.category_id);

                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new CategoriesScreen()));
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

  Future updateCategory(String id, String sec_name) async {
    try {
      var response = await Dio().put(
        'http://api.smart-vision-center.com/api/admin/sections',
        data: {'id': id, 'sec_name': sec_name},
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

  Future deleteCategory(String id) async {
    try {
      var response = await Dio().delete(
        'http://api.smart-vision-center.com/api/admin/sections/$id',
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
