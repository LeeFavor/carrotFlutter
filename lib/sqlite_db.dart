import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'my_database.dart';

class SqliteDb extends MyDatabase{
  late Database _db;

  String getName(){
    return "SQLite";
  }

  SqliteDb(this._db);

  static Future<MyDatabase> initializeDB() async{
    final path = join(await getDatabasesPath(), 'my_database.db');

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async{
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
    );
    return SqliteDb(db);
  }
  
  Future<List<Map<String, dynamic>>> selectAll() async{
    return await _db.rawQuery('select * from users');
  }
  Future<List<Map<String, dynamic>>> selectUser(String name) async{
    return await _db.rawQuery('select * from users where name = ?', [name]);
    
  }

  Future insertUser(String name, int age) async{
    await _db.execute('insert into users(name, age) values(?, ?)', [name, age]);
  }

  Future<void> updateUser(String name, int age) async{
    await _db.execute('update users set age = ? where name = ?', [age, name]);
  }

  Future<void> deleteUser(String name) async{
    await _db.execute('delete from users where name = ?', [name]);
  }

  Future<void> deleteAll() async{
    await _db.execute('delete from users');
  }
  Future<void> close() async{
    await _db.close();
  }
}

