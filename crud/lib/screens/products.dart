// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_new, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_field

import 'package:crud/screens/editProducts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final TextEditingController _addController = TextEditingController();
  final TextEditingController _secIdController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getProducts();
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
          title: Text('Products'),
          // leading: Icon(Icons.refresh),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getProducts();
            });
          },
          child: FutureBuilder(
            future: getProducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
              //  print(snapshot.data);
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ProductsData(
                      id: snapshot.data[i]['id'],
                      pro_name: snapshot.data[i]['pro_name'],
                      section_id: snapshot.data[i]['section_id'],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return Center(child: const CircularProgressIndicator());
            },
          ),
        ));
  }

  Future<String?> dialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Add a New Category'),
        content: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: _addController,
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _secIdController,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                addProducts(_addController.text,int.parse(_secIdController.text));

                //_addController == null;

                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Products()));
                getProducts();
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

  Future getProducts() async {
    try {
      var response = await Dio()
          .get('http://api.smart-vision-center.com/api/admin/products');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
    }
  }

// add cateogry
  Future addProducts(String proName, int secId) async {
    var response = await Dio().post(
      'http://api.smart-vision-center.com/api/admin/products',
      data: {
        'pro_name': proName,
        'section_id': secId,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print(response.data);
    print("added new category");
  }
}

// post data with "application/x-www-form-urlencoded" format

class ProductsData extends StatefulWidget {
  final id;
  final pro_name;
  final section_id;

  const ProductsData({
    Key? key,
    required this.id,
    required this.pro_name,
    required this.section_id,
  }) : super(key: key);

  @override
  State<ProductsData> createState() => _ProductsDataState();
}

class _ProductsDataState extends State<ProductsData> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new EditSection(
                        proId: widget.id,
                        proName: widget.pro_name,
                        sectionId: widget.section_id,
                      )));
        },
        leading: Icon(Icons.category),
        title: Text(widget.pro_name),
        // trailing: Icon(Icons.delete),
      ),
    );
  }
}
