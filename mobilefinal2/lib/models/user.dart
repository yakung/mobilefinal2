import 'dart:async';
import 'package:sqflite/sqflite.dart';


final String tableTodo = "Account";
final String columnId = "_id";
final String columnUser = "_user";
final String columnPass = "_password";
final String columnName = "_name";
final String columnAge = "_age";


class Todo{
  int id;
  String user;
  String pass;
  String name;
  String age;


  Todo({String user, String name, String pass, String age}){
    this.user = user;
    this.pass = pass;
    this.name = name;
    this.age = age;
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      columnUser:user,
      columnPass :pass,
      columnName :name,
      columnAge: age,
    };
    if(id != null){
      map[columnId] = id;
    }
    return map;
  }
  Todo.fromMap(Map<String,dynamic> map){
    this.id = map[columnId];
    this.user = map[columnUser];
    this.pass = map[columnPass];
    this.name = map[columnName];
    this.age = map[columnAge]; 
  }
}

class TodoProvider{
  Database db;
  Future open() async{
    var dbpath = await getDatabasesPath();
    String path = dbpath + "\Account.db";
    db = await openDatabase(path, version:1,
    onCreate: (Database db , int version) async{
      await db.execute('''
      create table $tableTodo (
        $columnId integer primary key autoincrement,
        $columnUser text not null unique,
        $columnPass text not null,
        $columnName text not null,
        $columnAge text not null
        )
      ''');
    });
  }
  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }
  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(
      tableTodo,
      columns: [columnId,columnUser,columnPass],
      where: "$columnId = ?",
      whereArgs: [id] 
      );
      if (maps.length > 0){
        return new Todo.fromMap(maps.first);
      }
      return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: "$columnId = ?",
    whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),where: "$columnId = ?",
    whereArgs: [todo.id]);
  }
  Future<List<Todo>> userall() async{
    List<Map> data = await db.query(tableTodo,
    );
    return data.map((d) => Todo.fromMap(d)).toList();
  }
    Future<int> deleteAll() async {
    return await db.rawDelete('DELETE FROM Account');
  }
  
  Future close() async => db.close();
}