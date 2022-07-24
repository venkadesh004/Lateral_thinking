import 'package:flutter/material.dart';
import 'package:ltnew/childrenspage.dart';
import 'package:ltnew/parentspage.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:convert'; 
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:ltnew/constants.dart';
import 'package:ltnew/selectionpage.dart';
  
// import 'package:usage_stats/usage_stats.dart';

class User {

  const User({
    required this.name,
    required this.username,
    required this.gameplay
  });

  final String name;
  final String username;
  final List gameplay;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      gameplay: json['gameplay']
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({ Key? key }) : super(key: key);


  Future<User> userData() async {
    // widget.storage.readKey().then((value) {
    //   _apiKey = value;
    // });
    final response = await http
        .get(Uri.parse(link+ apiKey));

    if (response.statusCode == 200) {
      print(response.body);
      username = User.fromJson(jsonDecode(response.body)).username;
      name = User.fromJson(jsonDecode(response.body)).name;
      gameplay = User.fromJson(jsonDecode(response.body)).gameplay;
      print(username+" "+name);
      print(gameplay);
      return User.fromJson(jsonDecode(response.body));
    } else { 
      throw Exception('Failed to load album');
    }
  }

  late Future<User> user;

  static const String _title = 'Lateral Thinking Project'; 
  @override
  Widget build(BuildContext context) {
    userData();
    return MaterialApp(
      title: _title,
      home: SelectionPage(),
    );
  }
}