import 'package:flutter/material.dart';

void main() {
  runApp(new LongList());
}

abstract class ListItem {}

class Heading implements ListItem {
  final String name;

  Heading({this.name});
}

class Message implements ListItem {
  final String subject;
  final String message;

  Message({this.subject, this.message});
}

class ListTap extends StatefulWidget {

  @override
  _ListTapState createState() => new _ListTapState();
}

class _ListTapState extends State<ListTap> {

  String myText = '';
  final items = new List<ListItem>.generate(
      1200,
          (i) => (i % 6 == 0)
          ? new Heading(name: 'Heading ${i}')
          : new Message(subject: 'My # ${i}', message: 'from message ${i}'));
  final String title = 'Basic List';


  @override
  Widget build(BuildContext context) {
    Color _getColor(BuildContext context){

    }

    return new MaterialApp(
      title: title,
      home: new MyScaffold(
        title: this.title,
        body: new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is Heading) {
                return new ListTile(
                  onTap: (){
                    setState(() {
                      ///myStle = new MyStle(title1: item.name,title2: myText);
                      myText = item.name;
                    });
                  },
                  title: new Text(
                    item.name,
                    style: Theme.of(context).textTheme.headline,
                  ),
                );
              } else if (item is Message) {
                return new ListTile(
                  onTap: (){
                    setState(() {
                      // myStle = new MyStle(title1: item.subject,title2: myText);
                      myText = item.subject;
                    });
                  },
                  title: new Text(item.subject),
                  subtitle: new Text(item.message),
                );
              }
            }),
      ),
    );
  }
}

typedef void CartChangedCallback(String name, String title);




class LongList extends StatelessWidget {
  final items = new List<ListItem>.generate(
      1200,
          (i) => (i % 6 == 0)
          ? new Heading(name: 'Heading ${i}')
          : new Message(subject: 'My # ${i}', message: 'from message ${i}'));
  final String title = 'Basic List';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: title,
      home: new MyScaffold(
        title: this.title,
        body: new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is Heading) {
                return new ListTile(
                  title: new Text(
                    item.name,
                    style: Theme.of(context).textTheme.headline,
                  ),
                );
              } else if (item is Message) {
                return new ListTile(
                  title: new Text(item.subject),
                  subtitle: new Text(item.message),
                );
              }
            }),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final items = new List<String>.generate(1200, (i) => 'The List ${i}');
  final String title = 'Basic List';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: title,
        home: new MyScaffold(
            title: this.title,
            body: new ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return new ListTile(
                    title: new Text('${items[index]}'),
                  );
                })));
  }
}

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new ListTile(
          leading: new IconButton(icon: new Icon(Icons.map), onPressed: null),
          title: new Text("Map"),
        ),
        new ListTile(
          leading:
          new IconButton(icon: new Icon(Icons.message), onPressed: null),
          title: new Text("Message"),
        )
      ],
    );
  }
}

class MyScaffold extends StatelessWidget {
  final String title;
  final body;

  MyScaffold({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(icon: new Icon(Icons.menu), onPressed: null),
        title: new Text(title),
      ),
      body: body,
    );
  }
}
