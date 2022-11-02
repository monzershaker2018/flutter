// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBConnection {
  static const _databaseName = "todolist3.db";
  static const _databaseVersion = 1;

  static const table = 'Categories';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnDescription = 'description';
///////////////////////////
  static const todoTable = 'Todo';

  static const todoColumnId = 'id';
  static const todoColumnTitle = 'title';
  static const todoColumnDescription = 'description';
  static const todoColumnDate = 'date';
  static const todoColumnCategory = 'category';
  static const todoColumnIsFinshed = 'isFinshed';

  // make this a singleton class
  // DBConnection._privateConstructor();
  // static final DBConnection instance = DBConnection._privateConstructor();

  // this opens the database (and creates it if it doesn't exist)
  setDataBase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS $table');
    print('Categories table is droped');
    await db.execute('DROP TABLE IF EXISTS $todoTable');
    print('todo table is droped');
    await db.execute('''
      create table IF NOT EXISTS $table (
        $columnId integer primary key autoincrement,
        $columnName text not null,
        $columnDescription text not null
       )''');
    print('Categories table is created');

    await db.execute('''
       create table IF NOT EXISTS $todoTable (
        $todoColumnId integer primary key autoincrement,
        $todoColumnTitle text not null,
        $todoColumnDescription text not null,
        $todoColumnDate text not null,
        $todoColumnCategory text not null,
        $todoColumnIsFinshed integer not null
       )''');
    print('todo table is created');

    // print("Category tabel creted");

    //print("Todo tabel creted");
  }
}
