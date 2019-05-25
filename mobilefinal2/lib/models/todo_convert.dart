import 'package:http/http.dart' as http;
import 'dart:convert';

class Todos {
  int id;
  int userId;
  String title;
  bool completed;

  Todos({this.id, this.userId, this.title, this.completed});

  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

class TodoList {
  final List<Todos> todo;
  TodoList({
    this.todo,
  });
  factory TodoList.fromJson(List<dynamic> parsedJson) {
    List<Todos> todo = new List<Todos>();
    todo = parsedJson.map((i) => Todos.fromJson(i)).toList();

    return TodoList(
      todo: todo,
    );
  }
}

class TodoProviders {
  Future<List<Todos>> loadTodo(String id) async {
    List<Todos> filterTodo = List<Todos>();
    http.Response resp = await http
        .get("https://jsonplaceholder.typicode.com/users/todos?userId="+id);
    final jresp = json.decode(resp.body);
    TodoList todoList = TodoList.fromJson(jresp);
    for (int i = 0; i < todoList.todo.length; i++) {
      if (todoList.todo[i].userId.toString() == id) {
        filterTodo.add(todoList.todo[i]);
      }
    }

    return filterTodo;
  }
}