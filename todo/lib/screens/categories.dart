// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_final_fields, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:todo/models/category.dart';

import '../components/drawer.dart';
import '../serveces/category_servces.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final TextEditingController _nameContoller = TextEditingController();
  final TextEditingController _descContoller = TextEditingController();
  final TextEditingController _editNameContoller = TextEditingController();
  final TextEditingController _editDescContoller = TextEditingController();
  var _Category = Category();
  var category;
  var _CategryService = CategryService();
  // var _globalKey = GlobalKey<Scaffold>()

  List<Category> categoryList = <Category>[]; // Always the recommended way.
  getAllCategories() async {
    var categories = await _CategryService.readCategory();
    print(categories);
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.id = category['id']; // model & database
        categoryModel.name = category['name'];
        categoryModel.desc = category['description'];
        categoryList.add(categoryModel);
      });
    });
  }

  getCategoryById(BuildContext context, CategoryId) async {
    var category = await _CategryService.getCategoryById(CategoryId);
    setState(() {
      _editNameContoller.text = category[0]['name'] ?? "no name";
      _editDescContoller.text = category[0]['description'] ?? "no description";
    });
    _editCategoryDialog(CategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      drawer: DrawerNavi(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCategoryDialog(),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, i) {
            return Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(categoryList[i].name),
                    InkWell(
                      onTap: () => _deleteCategoryDialog(categoryList[i].id),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                leading: InkWell(
                    onTap: () => getCategoryById(context, categoryList[i].id),
                    child: Icon(Icons.edit, color: Colors.green)),
              ),
            );
          }),
    );
  }

  Future<void> _addCategoryDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new category'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _nameContoller,
                  decoration: InputDecoration(
                    hintText: "Write a Name",
                    label: Text(" Name "),
                  ),
                ),
                TextField(
                  controller: _descContoller,
                  decoration: InputDecoration(
                    hintText: "Write a  Description",
                    label: Text(" Description "),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text('Save'),
              onPressed: () async {
                _Category.name = _nameContoller.text;
                _Category.desc = _descContoller.text;
                // saveCategory(_CategryService);

                var result = await _CategryService.saveCategory(_Category);

                if (result > 0) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Categories()));
                  const snackBar = SnackBar(
                    content: Text('new data added succefully '),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editCategoryDialog(categoryId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Category'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _editNameContoller,
                  decoration: InputDecoration(
                    hintText: "Write a Name",
                    label: Text(" Name "),
                  ),
                ),
                TextField(
                  controller: _editDescContoller,
                  decoration: InputDecoration(
                    hintText: "Write a  Description",
                    label: Text(" Description "),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text('Update'),
              onPressed: () async {
                _Category.id = categoryId;

                _Category.name = _editNameContoller.text;
                _Category.desc = _editDescContoller.text;

                var result = await _CategryService.updateCategory(_Category);
                // .then((value) {
                //print(" category is updated sucessfully and the id is : " +
                //    value.toString());
                // });
                if (result > 0) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Categories()));
                  const snackBar = SnackBar(
                    content: Text(' data updated succefully '),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCategoryDialog(categoryId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: Text('Do You want to delete this category ?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text('delete'),
              onPressed: () async {
                var result = await _CategryService.deleteCategory(categoryId);
                if (result > 0) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Categories()));
                  const snackBar = SnackBar(
                    content: Text(' data deleted succefully '),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
