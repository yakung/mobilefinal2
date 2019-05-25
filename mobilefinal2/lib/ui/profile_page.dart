import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'package:flutter/material.dart';
import './text_file.dart';
import 'home_page.dart';

class Profile extends StatefulWidget {
  final Todo user;
  Profile({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _user = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _quaot = TextEditingController();
  TodoProvider todo = TodoProvider();
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  SharedPreferences prefs;
  String name;

  @override
  void initState() {
    super.initState();
    todo.open().then((r) {
      print("open success");
    });
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name' ?? '');
    // Force refresh input
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    Todo user = widget.user;
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _user,
                  decoration: InputDecoration(labelText: "User Id"),
                  validator: (user) {
                    if (user.length < 6 || user.length > 12)
                      return "Userid must be 6-12 character";
                  },
                ),
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "John Wick",
                  ),
                  validator: (name) {
                    int count = 0;
                    for (int i = 0; i < name.length; i++) {
                      if (name[i] == " ") {
                        count = 1;
                      }
                    }
                    if (count == 0) {
                      return "Please fill name correctly";
                    }
                  },
                ),
                TextFormField(
                  controller: _age,
                  decoration: InputDecoration(
                    labelText: "Age",
                  ),
                  validator: (value) {
                    if (!isNumeric(value)) return "Age incorrect";
                    if (int.parse(value) < 10 || int.parse(value) > 80)
                      return "Age must be between 10 and 80";
                  },
                ),
                TextFormField(
                  controller: _pass,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.length < 6) return "Password must be more than 6";
                  },
                ),
                TextFormField(
                  controller: _quaot,
                  maxLines: 5,
                  decoration: InputDecoration(labelText: "Quaot"),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("Save"),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            if (_user.text.length > 0) {
                              user.user = _user.text;
                            }
                            if (_name.text.length > 0) {
                              user.name = _name.text;
                            }
                            if (_age.text.length > 0) {
                              user.age = _age.text;
                            }
                            if (_pass.text.length > 0) {
                              user.pass = _pass.text;
                            }
                            if (_quaot.text.length > 0) {
                              Txtfile().writeCounter(_quaot.text);
                            }
                            prefs = await SharedPreferences.getInstance();
                            await prefs.setString('name', _name.text);
                            todo.update(user).then((r){
                             Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Home(user: user),
                                ),
                              );
                            });
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}