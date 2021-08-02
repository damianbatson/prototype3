import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prototype3/commonComponents/custom_card.dart';
import 'package:prototype3/commonComponents/task.dart';
import 'package:prototype3/views/login_page.dart';
import 'package:prototype3/views/myhomepage.dart';
import 'package:prototype3/views/myprofilepage.dart';
import 'package:prototype3/views/auth.dart';
import 'package:provider/provider.dart';
import 'package:prototype3/commonComponents/detail_card.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  // final String title;
  // final String uid;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController taskTitleInputController;
  late TextEditingController taskDescripInputController;
  late FirebaseFirestore user;
  late FirebaseFirestore currentUser;
  late String uid;
  int _currentIndex = 0;
  final List<Widget> _children = [
    MyHomePage(
      key: UniqueKey(),
      title: '',
    ),
    MyProfilePage(
      key: UniqueKey(),
      title: '',
    ),
    MyProfilePage(
      key: UniqueKey(),
      title: '',
    ),
  ];

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
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signOut();
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          TextButton(
            child: Text('Logout',
                style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  _showDialog() async {
    await showDialog<String>(
      builder: (context) => AlertDialog(
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
          TextButton(
              child: Text('Cancel'),
              onPressed: () {
                taskTitleInputController.clear();
                taskDescripInputController.clear();
                Navigator.pop(context);
              }),
          TextButton(
              child: Text('Add'),
              onPressed: () async {
                if (taskDescripInputController.text.isNotEmpty &&
                    taskTitleInputController.text.isNotEmpty) {
                  final user = FirebaseAuth.instance.currentUser;
                  // final user = Provider.of<AuthService>(context).currentUser();
                  FirebaseFirestore.instance
                      .collection('items')
                      .doc(user?.uid)
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
      context: context,
    );
  }
}
