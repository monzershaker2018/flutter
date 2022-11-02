// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:todo/models/todo.dart';

import '../repos/todo_repo.dart';

class TodoService {
  TodoRepo todoRepo = TodoRepo();

  saveTodo(Todo todo) async {
    return await todoRepo.insertData("Todo", todo.categoryMap());
  }

  readCategory() async {
    return await todoRepo.readData();
  }

  getCategoryById(id) async {
    return await todoRepo.readDataById(id);
  }

  updateCategory(Todo todo) async {
    return await todoRepo.updateData(todo.categoryMap());
  }

  deleteCategory(id) async {
    return await todoRepo.deleteData(id);
  }

  readDataBy(category) async {
    return await todoRepo.readDataByColumnName("Todo", "category", category);
  }
}
