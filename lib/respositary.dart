import 'package:sqflite/sqlite_api.dart';

import 'DatabaseConection.dart';

class Respositary {
  databaseConections? _databaseConnection;

  Respositary() {
    ///intailize database conections
    _databaseConnection = databaseConections();
  }

  Database? _database;

  ///cheack if database is exsite or note
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection!.setDatabase();
    return _database;
  }

  ///inserting data to tabele

  insertData(table, data) async {
    var conection = await database;
    return await conection!.insert(table, data);
  }

  ///read data frome table
  readData(table) async {
    var conection = await database;
    return await conection!.query(table);
  }

  ///delete data from table
  deleteData(table, itemId) async {
    var conection = await database;
    return await conection!.rawDelete("DELETE FROM $table WHERE id =$itemId");
  }

  ///update data frome table
  updateData(table, data) async {
    var conection = await database;
    return await conection!
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  readdatabyId(table, itemid) async {
    var connection = await database;
    return await connection!.query(table, where: 'id=?', whereArgs: [itemid]);
  }

  searchdata(table, String keyword) async {
    var conection = await database;
    return await conection!
        .query(table, where: 'name LIKE ?', whereArgs: ['%$keyword%']);
  }

  ///photo save
  // savephoto(table) {
  //   var dbClint=db.
  // }
}

class Respositary_user {
  databaseConections_user? _databaseConnection_user;

  Respositary_user() {
    ///intailize database conections
    _databaseConnection_user = databaseConections_user();
  }

  Database? _database;

  ///cheack if database is exsite or note
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection_user!.setDatabase_user();
    return _database;
  }

  ///inserting data to tabele

  insertData(table, data) async {
    var conection = await database;
    return await conection!.insert(table, data);
  }

  ///read data frome table
  readData(table) async {
    var conection = await database;
    return await conection!.query(table);
  }

  ///delete data from table
  deleteData(table, itemId) async {
    var conection = await database;
    return await conection!.rawDelete("DELETE FROM $table WHERE id =$itemId");
  }

  ///update data frome table
  updateData(table, data) async {
    var conection = await database;
    return await conection!
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  readdatabyId(table, itemid) async {
    var connection = await database;
    return await connection!.query(table, where: 'id=?', whereArgs: [itemid]);
  }

  searchdata(table, String keyword) async {
    var conection = await database;
    return await conection!
        .query(table, where: 'name LIKE ?', whereArgs: ['%$keyword%']);
  }

///photo save
// savephoto(table) {
//   var dbClint=db.
// }
}
