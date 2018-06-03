import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strings/strings.dart';


import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Contact Phone',
    theme: new ThemeData(primarySwatch: Colors.red),
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull('https://jsonplaceholder.typicode.com/posts'),
        headers: {"Accept": "application/json"});

    setState(() {
      data = JSON.decode(response.body);
    });

    return 'success';
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('contact Phone'),
        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              elevation: 12.0,
              margin: const EdgeInsets.all(8.0),
              child: new ListTile(
                leading: new CircleAvatar(
                  child: new Text(data[index]['title'][1]),
                ),
                title: new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: new Text(hurufgede(data[index]['title']), style: new TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,

                  ),),
                ),
                subtitle: new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: new Text(data[index]['body']),
                ),
              ),
            );
          },
        ));
  }

  String hurufgede(String s) => s.toUpperCase();

}
