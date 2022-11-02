// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/serveces/todo_servces.dart';

class TodoByCategory extends StatefulWidget {
  final category;

  TodoByCategory({Key? key, required this.category}) : super(key: key);

  @override
  State<TodoByCategory> createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  @override
  void initState() {
    super.initState();
    getTodoByCategories();
  }

  TodoService _todoService = TodoService();
  List<Todo> _todoList = <Todo>[];
  getTodoByCategories() async {
    var todos = await _todoService.readDataBy(widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        model.date = todo['date'];
        model.desc = todo['description'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 6,
              child: ListTile(
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(_todoList[i].title),
                      Text(_todoList[i].date),
                    ]),
                subtitle: Text(_todoList[i].desc),
              ),
            );
          }),
    );
  }
}
