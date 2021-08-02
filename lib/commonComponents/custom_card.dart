import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class CustomCard extends StatefulWidget {
  const CustomCard(
      {required Key key,
      required this.itemid,
      required this.description,
      required this.ds,
      required this.uid})
      : super(key: key);
  final String itemid;
  final String description;
  // Detail(this.document);
  final DocumentSnapshot ds;
  final String uid;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late String uid;
  String txt = '';
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ds['itemid']),
      ),
      body: Container(
          // future: FirebaseAuth.instance.currentUser(),
          // stream: Firestore.instance.collection('items').document(this.uid).snapshots(),
          // builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          //  new ListView.builder(
          // itemCount: snapshot.data.documents.length,
          // padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
          // itemExtent: 25.0,
          // itemBuilder: (context, index) {
          // var documentID;
          // DocumentSnapshot ds = snapshot.data;
          // return new Text(" ${ds['itemid']} ${ds['description']}");
          child: ListTile(
        leading: Icon(Icons.add),
        title: Text(widget.ds['itemid']),
        subtitle: Text(widget.ds['description']),
        // title: Text('GFG title',textScaleFactor: 1.5,),
        trailing: Icon(Icons.done),
        // subtitle: Text('This is subtitle'),
        contentPadding: EdgeInsets.all(5.0),
        selected: true,
        onTap: () {
          setState(() {
            // txt = 'List Tile pressed';
          });
        },
        // Access the fields as defined in FireStore
        // trailing: Icon(Icons.home),
      )

          // };
          // ),
          // }
          ),
    );
  }
}
