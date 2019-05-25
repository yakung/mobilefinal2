import 'package:flutter/material.dart';
import 'package:mobilefinal2/models/todo_convert.dart';

import '../models/user.dart';
import 'friends_page.dart';

class TodoScreen extends StatefulWidget {
  int id;
  String name;
  Todo user;
  TodoScreen({Key key, this.id, this.name, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TodoScreenState();
  }
}

class TodoScreenState extends State<TodoScreen> {
  TodoProviders todoProvider = TodoProviders();

  Widget listTodos(BuildContext context, AsyncSnapshot snapshot) {
    int id = widget.id;
    print(id);
    List<Todos> todo = snapshot.data;
    return Expanded(
      child: ListView.builder(
        itemCount: todo.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Text(
                    todo[index].id.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    todo[index].title,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(todo[index].completed ? "Completed" : ""),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    String name = widget.name;
    Todo myself = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Text("Back"),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Friend(
                                user: myself,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: todoProvider.loadTodo(id.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return listTodos(context, snapshot);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}