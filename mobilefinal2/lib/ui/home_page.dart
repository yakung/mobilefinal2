import 'package:flutter/material.dart';
import 'package:mobilefinal2/models/user.dart';
import 'package:mobilefinal2/ui/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './text_file.dart';
import 'friends_page.dart';
import 'login_page.dart';

class Home extends StatefulWidget {
  final Todo user;
  Home({Key key, this.user}) : super(key: key);
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  int index = 0;
  String name = '';
  String quaot;
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name' ?? '');
    quaot = await Txtfile().readCounter();
    // Force refresh input
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Todo user = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(name),
              Text("this is my quait ${quaot}"),
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    child: Text('PROFILE SETUP'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(user: user),
                        ),
                      );
                    },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    child: Text('MY FRIENDS'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Friend(user: user),
                        ),
                      );
                    },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    child: Text('SIGN OUT'),
                    onPressed: () async {
                      prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                  )),
            ]),
      ),
    );
  }
}
