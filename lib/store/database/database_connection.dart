



import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class databaseConections_store {
  setDatabase_store() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite_store');
    var database =
    await openDatabase(path, version: 1, onCreate: _onCreateDatabase_store);
    return database;
  }

  _onCreateDatabase_store(Database database, int version) async {
    await database.execute(
        "CREATE TABLE store(id INTEGER PRIMARY KEY, name TEXT , barcode INTEGER , date INTEGER , nrx TEXT , nrxyfroshtn TEXT , namecompany TEXT, phonenumbercompany TEXT , jorypara TEXT)");
  }

}
