import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prototype3/models/user_model.dart';
import 'package:prototype3/repository/auth/auth_service.dart';
import 'package:prototype3/repository/auth/bloc/auth_bloc.dart';
import 'package:prototype3/views/home_page.dart';
import 'package:prototype3/views/login_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key)


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter login demo',
        home: const BlocNavigate(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }
}

class BlocNavigate extends StatelessWidget {
  const BlocNavigate({Key? key}) : super(key: key)

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
