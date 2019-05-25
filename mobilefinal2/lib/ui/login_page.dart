import 'package:flutter/material.dart';
import 'register_page.dart';
import 'home_page.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  TodoProvider todo = TodoProvider();
  List<Todo> userlist = List();
  @override
  void initState() {
    super.initState();
    todo.open().then((d) {
      print("successssssssssssssssssssssssssssssss");
      alluser();
      
    });
  }

  void alluser() {
    todo.userall().then((d) {
      setState(() {
        userlist = d;
      });
    });
  }

  SharedPreferences prefs;

  final _formkey = GlobalKey<FormState>();
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child:
                  Image.asset("resources/vanila.jpg", height: 200, width: 200),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 25.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: TextFormField(
                controller: ctrlUsername,
                decoration: InputDecoration(
                  labelText: "User Id",
                  hintText: "User Id",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill out this form";
                  }
                },
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: TextFormField(
                controller: ctrlpassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  prefixIcon: Icon(Icons.https),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill out this form";
                  }
                },
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                  child: Text("LOGIN"),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      for (int i = 0; i < userlist.length; i++) {
                        if (ctrlUsername.text == userlist[i].user &&
                            ctrlpassword.text == userlist[i].pass) {
                          print("successssssssss");
                          prefs = await SharedPreferences.getInstance();
                          await prefs.setString('name', userlist[i].name);
                          await prefs.setInt('userId', userlist[i].id);
                          if (userlist[i].id == prefs.getInt('userId')) {
                            
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(user: userlist[i]),
                              ),
                            );
                          }
                        } else {
                          return "Invalid user or password";
                        }
                      }
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 235.0),
              child: FlatButton(
                child: Text("Register New Account"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
