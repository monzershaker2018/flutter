// ignore_for_file: prefer_const_declarations, avoid_print
import 'package:flutter_ecommerce/model/product_provider_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = 'cart';
final String columnName = 'name';
final String columnImage = 'imageurl';
final String columnPrice = 'price';
final String columnQuintity = 'quintity';

class CartProvider {
  static late Database _database;

   Future<Database> get database async {
    final databasePath = await getDatabasesPath();
    final status = await databaseExists(databasePath);
    if (!status) {
      _database = await openDatabase(join(databasePath, 'cart_database.db'),
          onCreate: (database, version) {
        return database.execute('''
create table $tableName ( 
$columnName text not null, 
$columnImage text not null, 
$columnPrice integer not null,
$columnQuintity text not null)
  ''');
      }, version: 1);
    }
    return _database;
  }

  Future<bool> insertCart(ProductProviderModel productProviderModel) async {
    final db = await database;
    try {
      await db.insert(
        tableName,
        productProviderModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print(productProviderModel);
    } on Error {
      throw Error();
    }
    return true;
  }

  // update
  Future<int> update(ProductProviderModel productProviderModel) async {
    final db = await database;
    return await db.update(tableName, productProviderModel.toMap(),
        where: '$columnName = ?', whereArgs: [productProviderModel.name]);
  }

  //delete
  Future<int> delete(String name) async {
    final db = await database;
    return await db
        .delete(tableName, where: '$columnName = ?', whereArgs: [name]);
  }

// get all prodet
  Future<List<ProductProviderModel>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return ProductProviderModel(
        name: maps[i]['name'],
        imageurl: maps[i]['imageurl'],
        price: maps[i]['price'],
        quintity: maps[i]['quintity'],
      );
    });
  }
}
