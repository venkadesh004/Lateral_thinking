import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:ltnew/applicationpage.dart';
import 'package:ltnew/user.dart';
import 'dart:convert'; 
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:ltnew/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  // final FileStorage storage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const platform = const MethodChannel('com.flutter.epic/epic');

  Future<User> userData() async {
    // widget.storage.readKey().then((value) {
    //   _apiKey = value;
    // });
    final response = await http
        .get(Uri.parse(link+ apiKey));

    if (response.statusCode == 200) {
      username = User.fromJson(jsonDecode(response.body)).username;
      print(username);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<User> user;

  @override
  void initState() {
    super.initState();
    user = userData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Printy();
              print(userData());
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const UserLogin())
              );
            }, 
            icon: Icon(
              Icons.account_circle_outlined
            )
          )
        ],
        backgroundColor: Color.fromRGBO(0, 87, 255, 1),
        elevation: 0,
      ),
      body: MainContainer(userData: user)
    );
  }

  void Printy() async {
    String value;

    try {
      value = await platform.invokeMethod('Printy');
    } catch(e) {
      print(e);
    }

    // print(value);
  }
}

class MainContainer extends StatelessWidget {
  const MainContainer({
    Key? key,
    required this.userData
  }) : super(key: key);

  final Future<User> userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 87, 255, 1),
            Color.fromRGBO(17, 203,	247, 1)
          ]
        )
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          CenterCircle(),
          AppList()
        ],
      ),
    );
  }
}

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/key.txt');
  }

  Future<String> readKey() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return 'Error';
    }
  }

  Future<File> writeKey(int counter) async {
    final file = await _localFile;
    return file.writeAsString('$counter');
  }
}

class AppList extends StatelessWidget {
  AppList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double length = gameplay.length*100;
    return Container(
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Container(
        width: 300,
        height: length,
        child: ListView.builder(
          itemCount: gameplay.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                AppDetail(logo: 'default', name: gameplay[index]["gameName"], time: gameplay[index]["gameTime"].toString()+" Minutes"),
                BaseLine()
              ],
            );
          }
        ),
      ),
    );
  }
}

class BaseLine extends StatelessWidget {
  const BaseLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 1,
      color: Colors.black,
    );
  }
}

class AppDetail extends StatelessWidget {
  const AppDetail({
    Key? key,
    required this.logo,
    required this.name,
    required this.time,
  }) : super(key: key);

  final String logo;
  final String name;
  final String time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => ApplicationPageNew(name: name, time: time, imageName: logo,))
        );
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.only(top: 10, left: 30, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/'+logo+'.png')
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.black
                    ),
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }
}

class CenterCircle extends StatelessWidget {
  const CenterCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM y').format(now);
    return Center(
      child: Container(
        width: 300,
        height: 300,
        margin: EdgeInsets.only(
          top: 50
        ),
        decoration: BoxDecoration(
          // color: Colors.red,
          color: Color.fromRGBO(11, 105, 222, 1),
          borderRadius: BorderRadius.circular(150)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              formattedDate,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(
                "Total Usage: 5 Hours 30 Minutes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}