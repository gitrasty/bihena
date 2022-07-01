import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class databaseConections {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreateDatabase);
    return database;
  }

  _onCreateDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT , date INTEGER , enddate INTEGER , qarz TEXT , tebyny TEXT , image TEXT , phonenumber TEXT , wargr TEXT , kafyl TEXT , jorypara TEXT)");
  }

}

class databaseConections_user {
  setDatabase_user() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite_user');
    var database =
    await openDatabase(path, version: 1, onCreate: _onCreateDatabase_user);
    return database;
  }

  _onCreateDatabase_user(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categoriesuser(id INTEGER PRIMARY KEY, name TEXT , userid INTEGER , date INTEGER , qarz TEXT , tebyny TEXT , phonenumber TEXT , jorypara TEXT ,wargrtwnpedan TEXT)");
  }

}
