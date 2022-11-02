// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'package:sqflite/sqflite.dart';
import 'package:todo/repos/db_connection.dart';

class TodoRepo {
  DBConnection dbConnection = DBConnection();

// only have a single app-wide reference to the database
  var _database;

  Future<Database> get db async {
    if (_database == null) {
      _database = await dbConnection.setDataBase();
      return _database;
    } else {
      return _database;
    }
  }

// insert data to table
  insertData(table, data) async {
    var connection = await db;
    return await connection.insert(table, data);
  }

// read data from the table
  Future<List> readData() async {
    var connection = await db;
    return await connection.query("Todo");
  }

  readDataById(id) async {
    var connection = await db;
    return await connection.query('Todo', where: 'id=?', whereArgs: [id]);
  }

  updateData(data) async {
    var connection = await db;
    return await connection
        .update('Todo', data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(id) async {
    var connection = await db;
    return await connection.rawDelete('DELETE FROM Todo WHERE id = $id');
  }

  readDataByColumnName(
    table,
    columnName,
    columnValue,
  ) async {
    var connection = await db;
    return await connection
        .query(table, where: "$columnName=?", whereArgs: [columnValue]);
  }
}
