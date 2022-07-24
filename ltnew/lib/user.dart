import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ltnew/constants.dart'; 
import 'package:http/http.dart' as http;

class UserLogin extends StatefulWidget {
  const UserLogin({ Key? key }) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  String name = username;

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<String?> openDialog() => showDialog<String>(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text("Username"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Enter your username"
        ),
        controller: controller,
      ),
      actions: [
        TextButton(
          onPressed: submit, 
          child: Text("Save")
        )
      ],
    )
  );

  Future<void> changeUsername(String name) async {
    final headers = {"Content-type": "application/json"};
    final json = '{"username": "$name"}';
    final response = await http.patch(Uri.parse(link+apiKey), headers: headers, body: json);
    print(response.statusCode);
  } 

  void submit() async {
    print(controller.text);
    await changeUsername(controller.text);
    Navigator.of(context).pop(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100, bottom: 20),
              width: 300,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/default.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final name = await openDialog();
                      if (name == null || name.isEmpty) return;
                      setState(() {
                        this.name = name;
                        username = name;
                      });
                    }, 
                    icon: Icon(
                      Icons.edit
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}