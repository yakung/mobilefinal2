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
  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();
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
                controller: _user,
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
                controller: _pass,
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
                    print(userlist[2].pass);
                    print(userlist[2].user);
                    print(_user.text);
                    print(_pass.text);
                    print(userlist[2].pass==_user.text);
                    if (_formkey.currentState.validate()) {
                      for (int i = 0; i < userlist.length; i++) {
                        
                        if (!(_user.text == userlist[i].user &&
                            _pass.text == userlist[i].pass)) {
                          print("yess");
                          prefs = await SharedPreferences.getInstance();
                          await prefs.setString('name', userlist[i].name);
                          await prefs.setInt('userId', userlist[i].id);
                          
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(user: userlist[i]),
                              ),
                            );
                          }
                         else {
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
