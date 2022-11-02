// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_final_fields, unused_element

import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/serveces/todo_servces.dart';

import '../serveces/category_servces.dart';
import 'package:intl/intl.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  var _todo = Todo();
  var _todoServices = TodoService();

  var _todoNameController = TextEditingController();
  var todoDescController = TextEditingController();
  var _todoDateController = TextEditingController();

  var _selectedValue;

  List<DropdownMenuItem> categoryList =
      <DropdownMenuItem>[]; // Always the recommended way.
  getAllCategories() async {
    var categoryService = CategryService();
    var categories = await categoryService.readCategory();
    //  print(categories);
    categories.forEach((category) {
      setState(() {
        categoryList.add(DropdownMenuItem(
          value: category['name'],
          child: Text(category['name']),
        ));
      });
    });
  }

  var _dateTime = DateTime.now();

  _todoDate(BuildContext context) async {
    var pickerDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickerDate != null) {
      setState(() {
        _dateTime = pickerDate;
        _todoDateController.text = DateFormat('yyy-MM-dd').format(pickerDate);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextField(
                controller: _todoNameController,
                decoration: InputDecoration(
                  hintText: "write a Name",
                  label: Text(' Name'),
                ),
              ),
              TextField(
                controller: todoDescController,
                decoration: InputDecoration(
                  hintText: " write a Description",
                  label: Text(' Description'),
                ),
              ),
              TextField(
                controller: _todoDateController,
                decoration: InputDecoration(
                  hintText: "",
                  label: Text('Date'),
                  prefixIcon: InkWell(
                      onTap: () => _todoDate(context),
                      child: Icon(Icons.date_range)),
                ),
              ),
              DropdownButtonFormField<dynamic>(
                hint: Text('Select a Category'),
                value: _selectedValue,
                items: categoryList,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async{
                    _todo.title = _todoNameController.text;
                    _todo.desc = todoDescController.text;
                    _todo.date = _todoDateController.text;
                    _todo.category = _selectedValue.toString();
                    _todo.isFinshed = 0;

                    // print(_todo);
                    var result = await _todoServices.saveTodo(_todo);
                    print(result);
                    if (result > 0) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddTodo()));

                      const snackBar = SnackBar(
                        content: Text('new data added succefully '),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
