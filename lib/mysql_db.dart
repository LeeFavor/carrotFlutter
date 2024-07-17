import 'package:mysql_client/mysql_client.dart';
import 'my_database.dart';

class MysqlDb extends MyDatabase{
  late MySQLConnection _conn;

  String getName(){return "MySQL";}

  MysqlDb(this._conn);

  static Future<MyDatabase> initializeDB() async{
    var conn = await MySQLConnection.createConnection(host: '10.0.2.2', port: 3306, userName: 'madang', password: 'madang', databaseName: 'madangdb');

    await conn.connect();

    return MysqlDb(conn);
  }

  Future<List<Map<String, dynamic>>> selectAll() async{
    List<Map<String, dynamic>> list =[];
    var result = await _conn.execute('select * from users');
    for(var row in result.rows){
      list.add(row.assoc());
    }
    return list;
  }
  Future<List<Map<String, dynamic>>> selectUser(String name) async{
    List<Map<String, dynamic>> list =[];
    var result = await _conn.execute('select * from users where name = :name', {"name":name});
    for(var row in result.rows){
      list.add(row.assoc());
    }
    return list;
  }

  Future insertUser(String name, int age) async{
    await _conn.execute('insert into users(name, age) values(:name, :age)', {"name":name, "age":age});
  }

  Future<void> updateUser(String name, int age) async{
    await _conn.execute('update users set age = :age where name = :name', {"age":age,"name":name});
  }

  Future<void> deleteUser(String name) async{
    await _conn.execute('delete from users where name = :name', {"name":name});
  }

  Future<void> deleteAll() async{
    await _conn.execute('delete from users');
  }
  Future<void> close() async{
    await _conn.close();
  }
}