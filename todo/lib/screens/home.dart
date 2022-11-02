// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo.dart';
import 'package:todo/serveces/todo_servces.dart';

import '../components/drawer.dart';
import '../serveces/category_servces.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getAllTodo();
    getAllCategories();
  }

  // start of text edtingContoroller
  var _todo = Todo();
  var _todoServices = TodoService();

  var _todoNameController = TextEditingController();
  var todoDescController = TextEditingController();
  var _todoDateController = TextEditingController();
  // end of textEditingController

// start of get all categories
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
  // end of get all category method

//start of picker date
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
  //end of picker date

// start of get all todos method
  var _todoService = TodoService();
  List<Todo> todoList = <Todo>[]; // Always the recommended way.
  getAllTodo() async {
    var todos = await _todoService.readCategory();
    print(todos);
    todos.forEach((category) {
      setState(() {
        var todoModel = Todo();
        todoModel.id = category['id']; // model & database
        todoModel.title = category['title'];
        todoModel.desc = category['description'];
        todoModel.date = category['date'];
        todoModel.category = category['category'];
        todoModel.isFinshed = category['isFinshed'];
        todoList.add(todoModel);
      });
    });
  }
// end of get all todos method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TodoList"),
      ),
      drawer: DrawerNavi(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodo()));
        },
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, i) {
            // ignore: prefer_const_literals_to_create_immutables
            return InkWell(
              onTap: () => editTodoDialog(todoList[i].id, todoList[i].title,
                  todoList[i].desc, todoList[i].date, todoList[i].category),
              child: Card(
                elevation: 6,
                child: ListTile(
                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(todoList[i].title),
                        Text(todoList[i].date),
                      ]),
                  subtitle: Text(todoList[i].category),
                ),
              ),
            );
          }),
    );
  }

  editTodoDialog(todoId, todoTitle, todoDes, todoDate, todoCategory) async {
    setState(() {
      _todoNameController.text = todoTitle;
      _todoDateController.text = todoDate;
      todoDescController.text = todoDes;
      _selectedValue = todoCategory;
    });

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Update Todo'),
            content: SingleChildScrollView(
                child: ListBody(
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
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () async {
                      _todo.id = todoId;
                      _todo.title = _todoNameController.text;
                      _todo.desc = todoDescController.text;
                      _todo.date = _todoDateController.text;
                      _todo.category = _selectedValue.toString();
                      _todo.isFinshed = 0;

                      // print(_todo);
                      var result = await _todoServices.updateCategory(_todo);
                      print(result);
                      if (result > 0) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));

                        const snackBar = SnackBar(
                          content: Text(' data updated succefully '),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text('Save')),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _deleteTodo(context, todoId);
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                )
              ],
            )));
      },
    );
  }

  _deleteTodo(BuildContext context, todoId) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: Text('Do You want to delete this Todo ?'),
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
                var result = await _todoService.deleteCategory(todoId);
                if (result > 0) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
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
