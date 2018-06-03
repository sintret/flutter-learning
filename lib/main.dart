import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strings/strings.dart';

import 'package:flutter/material.dart';

void main() {
  String title = 'List Phone App';
  runApp(new MaterialApp(
    title: title,
    theme: new ThemeData(primarySwatch: Colors.red),
    home: new HomePage(title: title),
  ));
}

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyList> _items = <MyList>[];

  //Set<MyList> _items = new Set<MyList>();
  //List _items = [];

  Future _newDialog() async {
    MyList myList =
        await Navigator.of(context).push(new MaterialPageRoute<MyList>(
            builder: (BuildContext context) {
              return new DialogAddItem(myNumber: _items.length == null ? 1 : (_items.length+ 1) );
            },
            fullscreenDialog: true));

    setState(() {
      _items.add(myList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(icon: new Icon(Icons.menu), onPressed: null),
        title: new Text(widget.title),
      ),
      body: new ListView.builder(
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index) {
            return new FlatButton(
              child: new ListTile(
                title: new Text(_items[index].text),
                trailing: new Text(_items[index].number.toString()),
                onTap: null,
              ),
              onPressed: () {
                setState(() {
                  _items.removeAt(index);
                });
              },
            );
          }),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _newDialog();
        },
        tooltip: 'Add data',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class MyList {
  String text;
  int number;

  MyList({this.text, this.number});

  MyList.empty() {
    text = "";
    number = 0;
  }
}

class DialogAddItem extends StatefulWidget {

  final int myNumber;
  DialogAddItem({this.myNumber});
  @override
  _DialogAddItemState createState() => _DialogAddItemState();
}

class _DialogAddItemState extends State<DialogAddItem> {
  bool isCanSave = false;
  MyList _data = new MyList.empty();

  void _setSaveData(bool save) {
    if (save != isCanSave) {
      setState(() {
        isCanSave = save;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Item'),
        actions: <Widget>[
          new FlatButton(
              onPressed: (){
                isCanSave ? Navigator.of(context).pop(_data) : null;
              },
              child: new Text(
                'ADD + ',
                style: new TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: new Form(
          child: new ListView(
        children: <Widget>[
          new TextField(
            decoration: const InputDecoration(labelText: 'Text'),
            onChanged: (String value) {
              _data.text  = value;
              _data.number = widget.myNumber;
              _setSaveData(value.isNotEmpty);

            },
          )
        ].toList(),
      )),
    );
  }
}
