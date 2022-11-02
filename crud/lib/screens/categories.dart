// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_new, prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_null_comparison, avoid_print, prefer_final_fields

import 'package:crud/screens/editCategory.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController _addController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            dialog(context);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Categories'),
          // leading: Icon(Icons.refresh),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getCategories();
            });
          },
          child: FutureBuilder(
            future: getCategories(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return CategoriesData(
                      cat_id: snapshot.data[i]['id'],
                      cat_name: snapshot.data[i]['sec_name'],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return Center(child: const CircularProgressIndicator());
            },
          ),
        )

        //  FutureBuilder(
        //   future: getCategories(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (snapshot.hasData) {
        //       print(snapshot.data);
        //       return ListView.builder(
        //         itemCount: snapshot.data.length,
        //         itemBuilder: (BuildContext context, int i) {
        //           return CategoriesData(
        //             id: snapshot.data[i]['id'],
        //             cat_name: snapshot.data[i]['sec_name'],
        //           );
        //         },
        //       );
        //     } else {
        //       print("no data");
        //       return Center(child: Text('no data found'));
        //     }
        //   },
        // ),
        );
  }

  Future<String?> dialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Add a New Category'),
        content: TextFormField(
          autofocus: true,
          controller: _addController,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                addCategory(_addController.text);
                print("added new category");
                //_addController == null;

                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CategoriesScreen()));
                getCategories();
              });

              final snackBar = SnackBar(
                content: const Text('Added Data Successfully'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future getCategories() async {
    try {
      Response response = await Dio()
          .get('http://api.smart-vision-center.com/api/admin/sections');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
    }
  }

// add cateogry
  Future addCategory(String name) async {
    Response response = await Dio().post(
      'http://api.smart-vision-center.com/api/admin/sections',
      data: {
        'sec_name': name,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print(response.data);
  }
}

// post data with "application/x-www-form-urlencoded" format

class CategoriesData extends StatefulWidget {
  final cat_id;
  final cat_name;

  const CategoriesData({Key? key, required this.cat_id, required this.cat_name})
      : super(key: key);

  @override
  State<CategoriesData> createState() => _CategoriesDataState();
}

class _CategoriesDataState extends State<CategoriesData> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new EditCategoriesScreen(
                        category_id: widget.cat_id.toString(),
                        category_name: widget.cat_name,
                      )));
        },
        leading: Icon(Icons.category),
        title: Text(widget.cat_name),
        // trailing: Icon(Icons.delete),
      ),
    );
  }
}
