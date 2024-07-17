import 'package:carrot_flutter/my_database.dart';
import 'package:carrot_flutter/mysql_db.dart';
import 'package:flutter/material.dart';
//import 'package:database_practice/my_database.dart';
//import 'package:database_practice/mysql_db.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  late MyDatabase _database;
  var _bConnection = false;
  var _name = 'Database';

  @override
  void initState(){
    super.initState();
    MysqlDb.initializeDB().then((value) => {
      _database = value,
      _name = _database.getName(),
      _bConnection = true,
      print('connection success!'),
      setState((){})
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('${_name} Example'),
      ),
      body: Column(children: [
        _viewTextField(),
        _viewCommandButton(),
        _dataListView()
      ],),
    );
  }

  List<Map<String, dynamic>> users = [];

  Widget _dataListView(){
    if(_bConnection == false) return CircularProgressIndicator();


    if(users.length > 0){
      return SingleChildScrollView(
        child: DataTable(columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('AGE')),
        ],
        rows: users.map((user){
          return DataRow(cells: [
            DataCell(Text(user['name'])),
            DataCell(Text(user['age'].toString())),
          ],);
        }).toList())
      );
    } else{
      return Text('No data');
    }
  }

  Widget _viewCommandButton(){
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: ()async{ users = await _database.selectAll(); setState(() {});}, child: Text('전체 검색')),
        ElevatedButton(onPressed: ()async{ await _database.deleteAll(); setState(() {});}, child: Text('전체 삭제')),
      ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: ()async{ users = await _database.selectUser(nameValue.text); setState(() {});}, child: Text('검색')),
        ElevatedButton(onPressed: ()async{ await _database.insertUser(nameValue.text, int.parse(ageValue.text)); setState(() {});}, child: Text('삽입')),
        ElevatedButton(onPressed: ()async{ await _database.updateUser(nameValue.text, int.parse(ageValue.text)); setState(() {});}, child: Text('수정')),
        ElevatedButton(onPressed: ()async{ await _database.deleteUser(nameValue.text); setState(() {});}, child: Text('삭제')),
      ],
      ),
    ],);
  }


  TextEditingController nameValue = TextEditingController(text: '홍길동');
  TextEditingController ageValue = TextEditingController(text: '0');

  Widget _viewTextField(){
    return Row(mainAxisAlignment:  MainAxisAlignment.center,
    children: [
      Text('이름: '), SizedBox(width: 200, height: 35, child: TextField(controller: nameValue, textAlign:  TextAlign.center)),
      Text('나이: '), SizedBox(width: 100, height: 35, child: TextField(controller: ageValue, textAlign:  TextAlign.center, keyboardType: TextInputType.number)),
    ],);
  }
}