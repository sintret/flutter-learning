import 'package:flutter/material.dart';

void main() {

  List<MyList> myListing = new List.generate(1200, (i)=> new MyList(subject: 'subject ${i}',message: 'message ${i}'));

  /* runApp(new Listing(myLists: <MyList>[
    new MyList(subject: 'test',message: 'message'),
  ]));*/

  runApp(new Listing(myLists: myListing));
}


class MyList{

  final String subject;
  final String message;

  MyList({this.subject,this.message});
}

typedef ChangeItem(MyList myList, bool inList);

class ListItem extends StatelessWidget {

  final MyList myList;
  final bool inList;
  final ChangeItem onChangeItem;

  ListItem({MyList myList,this.inList,this.onChangeItem}) : myList = myList, super(key : new ObjectKey(myList));

  Color _color(){
    return inList ? Colors.blueAccent : Colors.red;
  }

  TextStyle _textStyle(){

    return inList ? new TextStyle(
        color: Colors.black,
        decoration: TextDecoration.lineThrough
    ) : null;
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: (){
        onChangeItem(myList, !inList);
      },
      leading: new CircleAvatar(
        backgroundColor: _color(),
        child: new Text(myList.subject[0]),
      ),
      title: new Text(myList.subject,style: _textStyle()),
      subtitle: new Text(myList.message),
    );
  }
}

class Listing extends StatefulWidget {
  final List<MyList> myLists;

  Listing({Key key, this.myLists}) : super(key:key);

  @override
  _ListingState createState() => new _ListingState();
}

class _ListingState extends State<Listing> {

  Set<MyList> _myList = new Set<MyList>();

  void _tapMyList(MyList myListing, bool inList){

    setState(() {

      if(inList){
        _myList.add(myListing);
      } else {
        _myList.remove(myListing);
      }

    });

    print(_myList);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Listing',
      home: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(icon: new Icon(Icons.menu), onPressed: null),
          title: new Text('Listing'),
        ),
        body:  new ListView(
          children: widget.myLists.map((MyList myList){
            return new ListItem(
                myList: myList,
                inList: _myList.contains(myList),
                onChangeItem: _tapMyList);
          }).toList(),
        ),
      ),

    );
  }
}
