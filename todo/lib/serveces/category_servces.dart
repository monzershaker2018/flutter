// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:todo/repos/repo.dart';

import '../models/category.dart';

class CategryService {
  Repo repo = Repo();
  CategryService() {
    // repo = Repo();
  }

  saveCategory(Category category) async {
    return await repo.insertData("Categories", category.categoryMap());
  }

  readCategory() async {
    return await repo.readData();
  }

  getCategoryById(id) async {
    return await repo.readDataById(id);
  }

  updateCategory(Category category) async {
    return await repo.updateData(category.categoryMap());
  }

  deleteCategory(id) async{
    return await repo.deleteData(id);

  }
}
