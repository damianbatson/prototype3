import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype3/views/auth.dart';
import 'package:provider/provider.dart';
import 'package:prototype3/models/user.dart';

import 'package:prototype3/commonComponents/custom_card.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({required Key key, required this.title})
      : super(key: key);

  final String title;
  static User? user;

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    // final user = Provider.of<AuthService>(context).currentUser();
    final user = auth.FirebaseAuth.instance.currentUser;
    yield* FirebaseFirestore.instance
        .collection('items')
        .doc(user?.uid)
        .collection('items')
        // .orderBy('startDate')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(title)),
      body: StreamBuilder<QuerySnapshot>(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return new ListView.builder(
                itemCount: snapshot.data!.docs.length,
                padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                // itemExtent: 25.0,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  // return new Text(" ${ds['itemid']} ${ds['description']}");
                  return ListTile(
                    // Access the fields as defined in FireStore
                    title: Text("${ds['itemid']} ${ds['description']}"),
                    // subtitle: Text("${ds['description']}"),
                    trailing: Icon(Icons.verified),
                    contentPadding: EdgeInsets.all(5.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomCard(
                            ds: ds,
                            description: '',
                            itemid: '',
                            key: UniqueKey(),
                            uid: '',
                          ),
                        ),
                      );
                    },
                  );
                });
          }),
    );
  }
}
