
import 'package:flutter/material.dart';
import 'package:prototype3/views/auth.dart';

class Provider extends InheritedWidget {
  const Provider({Key key, Widget child, this.auth}) : super(key: key, child: child);
  final AuthService auth;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Provider of(BuildContext context) => (
    context.dependOnInheritedWidgetOfExactType<Provider>());
  }

