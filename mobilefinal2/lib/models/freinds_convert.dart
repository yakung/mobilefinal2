import 'package:http/http.dart' as http;
import 'dart:convert';

class Friends {
  int id;
  String email;
  String name;
  String phone;
  String website;

  Friends({this.id, this.name, this.email, this.phone, this.website});

  factory Friends.fromJson(Map<String, dynamic> json) {
    return new Friends(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}

class FriendList {
  final List<Friends> friends;
  FriendList({
    this.friends,
  });
  factory FriendList.fromJson(List<dynamic> parsedJson) {
    List<Friends> friends = new List<Friends>();
    friends = parsedJson.map((i) => Friends.fromJson(i)).toList();

    return new FriendList(
      friends: friends,
    );
  }
}

class FriendProvider {
  Future<List<Friends>> loadDatas(String url) async {
    http.Response resp = await http.get(url);
    final jresp = json.decode(resp.body);
    FriendList friendList = FriendList.fromJson(jresp);
    return friendList.friends;
  }
}