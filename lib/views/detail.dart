import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Detail extends StatefulWidget {

  const Detail({Key key, this.itemid, this.description, @required this.ds, this.uid}) : super(key: key);
  final String itemid;
  final String description;
  // Detail(this.document);
  final DocumentSnapshot ds;
  final String uid;


  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String uid;

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    // return null;
        return Scaffold(
          appBar: AppBar(
            title: Text('item'),
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
                  // Access the fields as defined in FireStore
                  title: Text(widget.ds["itemid"]),
                  subtitle: Text(widget.ds["description"]),
                  // trailing: Icon(Icons.home),
                  // contentPadding: EdgeInsets.all(5.0),
                )
              // };
              // ),
          // }
        )
    );
  }
}