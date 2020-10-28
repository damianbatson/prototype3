import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prototype3/views/provider.dart';
import 'package:prototype3/views/auth.dart';
import 'package:prototype3/views/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;
  FirebaseFirestore user;
  FirebaseFirestore currentUser;
  String uid;

  @override
  void initState() {
    taskTitleInputController = new TextEditingController();
    taskDescripInputController = new TextEditingController();
    // this.getCurrentUser();
    // this.setUser();
    super.initState();
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final AuthService auth = Provider.of(context).auth;
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentUser() async {
    // final BaseAuth auth = AuthProvider.of(context).auth;
    // await auth.currentUser();
    // currentUser = await FirebaseAuth.instance.currentUser();
    setState(() {
      // this.uid = currentUser.uid;
    });
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.currentUserUID();
    yield* FirebaseFirestore.instance
        .collection('items')
        .doc(uid)
        .collection('items')
        // .orderBy('startDate')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout',
                style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        // final uid = await AuthProvider.of(context).auth.getCurrentUID();
        stream: getUsersTripsStreamSnapshots(context),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text("Loading...");
          return new ListView.builder(
              itemCount: snapshot.data.docs.length,
              padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
              // itemExtent: 25.0,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                // return new Text(" ${ds['itemid']} ${ds['description']}");
                return ListTile(
                  // Access the fields as defined in FireStore
                  title: Text("${ds['itemid']} ${ds['description']}"),
                  // subtitle: Text("${ds['description']}"),
                  trailing: Icon(Icons.home),
                  contentPadding: EdgeInsets.all(5.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(ds: ds),
                      ),
                    );
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          children: <Widget>[
            Text("Please fill all fields to create a new task"),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Task Title*'),
                controller: taskTitleInputController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Task Description*'),
                controller: taskDescripInputController,
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                taskTitleInputController.clear();
                taskDescripInputController.clear();
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Add'),
              onPressed: () async {
                if (taskDescripInputController.text.isNotEmpty &&
                    taskTitleInputController.text.isNotEmpty) {
                  final uid = await Provider.of(context).auth.currentUserUID();
                  // FirebaseAuth auth = FirebaseAuth.instance;
                  // String uid = auth.currentUser.uid;
                  FirebaseFirestore.instance
                      .collection('items')
                      .doc(uid)
                      .collection('items')
                      .add({
                        "itemid": taskTitleInputController.text,
                        "description": taskDescripInputController.text
                      })
                      .then((result) => {
                            Navigator.pop(context),
                            taskTitleInputController.clear(),
                            taskDescripInputController.clear(),
                          })
                      .catchError((err) => print(err));
                }
              })
        ],
      ),
    );
  }
}
