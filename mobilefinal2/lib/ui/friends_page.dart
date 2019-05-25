import 'package:flutter/material.dart';
import 'package:mobilefinal2/models/freinds_convert.dart';
import 'package:mobilefinal2/models/user.dart';
import 'package:mobilefinal2/ui/todo_page.dart';

import 'home_page.dart';



class Friend extends StatefulWidget {
  final Todo user;
  Friend({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FriendState();
  }
}

class FriendState extends State<Friend> {
  FriendProvider friendProvider = FriendProvider();
  @override

  Widget listFriends(BuildContext context, AsyncSnapshot snapshot) {
    List<Friends> friends = snapshot.data;
    return Expanded(
      child: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(child: Column(
            children: <Widget>[
              Text(
                      "${friends[index].id} : ${friends[index].name}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    Text(
                      friends[index].email,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      friends[index].phone,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      friends[index].website,
                      style: TextStyle(fontSize: 16),
                    ),
            ],
          ), onPressed: () {

          },);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Todo myself = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend"),
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
                          builder: (context) => Home(user: myself),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: friendProvider
                  .loadDatas("https://jsonplaceholder.typicode.com/users"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return listFriends(context, snapshot);
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