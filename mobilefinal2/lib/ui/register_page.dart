import 'package:flutter/material.dart';
import '../models/user.dart';
import 'login_page.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Registerstate();
  }
}

class Registerstate extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _user = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TodoProvider todo = TodoProvider();
  List<Todo> userlist = List();
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  @override
  void initState() {
    super.initState();

    todo.open().then((d) {
      alluser();
      print("success");
    });
  }

  void alluser() {
    todo.userall().then((d) {
      setState(() {
        userlist = d;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Resgister"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: TextFormField(
                controller: _user,
                decoration: InputDecoration(
                  hintText: "User Id",
                  labelStyle: TextStyle(color: Colors.blue),
                  icon: Icon(Icons.supervisor_account),
                ),
                validator: (user) {
                  if (user.isEmpty) {
                    return ("user is required");
                  } else if (user.length < 6 || user.length > 12) {
                    return "user must be 6-12 character";
                  }
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  hintText: "Name",
                  labelStyle: TextStyle(color: Colors.blue),
                  icon: Icon(Icons.account_circle),
                ),
                validator: (name) {
                  int count = 0;
                  if (name.isEmpty) {
                    return "กรุณาใ่ชื่อ";
                  }
                  for (int i = 0; i < name.length; i++) {
                    if (name[i] == " ") {
                      count = 1;
                    }
                  }
                  if (count == 0) {
                    return "กรุณากรอกให้ถูก";
                  }
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: TextFormField(
                controller: _age,
                decoration: InputDecoration(
                  hintText: "Age",
                  icon: Icon(Icons.assignment),
                ),
                keyboardType: TextInputType.text,
                validator: (age) {
                  if (age.isEmpty) {
                    return "กรุณาใส่อายุ";
                  } else if (int.parse(age) < 10 || int.parse(age) > 80) {
                    return "อยู่ในช่วงกำหนด";
                  } else if (!isNumeric(age)) {
                    return "กรุณาเป็นตัวเลข";
                  }
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: TextFormField(
                controller: _pass,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(Icons.lock),
                ),
                validator: (pass) {
                  if (pass.length < 6 && pass.isEmpty) {
                    return "false";
                  }
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
              child: RaisedButton(
                child: Text(
                  "CONTINUE",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () async {
                  bool flag = true;
                  if (_formkey.currentState.validate()) {
                    if (userlist.length == 0) {
                      print("success");
                      await todo.open();
                      Todo data = Todo(
                        name: _name.text,
                        age: _age.text,
                        pass: _pass.text,
                        user: _user.text,
                      );
                      todo.insert(data).then((d) {
                        todo.insert(data).then((d) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        });
                      });
                    } else {
                      for (int i = 0; i < userlist.length; i++) {
                        if (_user.text == userlist[i].user) {
                          flag = false;
                          break;
                        }
                      }
                      if (flag) {
                        print("successs");
                        await todo.open();
                        Todo data = Todo(
                          name: _name.text,
                          age: _age.text,
                          pass: _pass.text,
                          user: _user.text,
                        );
                        todo.insert(data).then((d) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        });
                      } else {
                        print("not success");
                      }
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
