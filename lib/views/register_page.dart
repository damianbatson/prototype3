import 'dart:math';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prototype3/bloc/bloc/auth_bloc.dart';
import 'package:prototype3/models/user_model.dart';
import 'package:prototype3/repository/auth_repository.dart';
import 'package:prototype3/views/home_page.dart';
import 'package:prototype3/views/login_page.dart';
import 'package:provider/provider.dart';

enum FormType {
  login,
  register,
}

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final emailTextController = new TextEditingController();
  final passwordTextController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<User?> signUp(
      {required String email, required String password}) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // try {
      // final authService = Provider.of<AuthService>(context, listen: false);
      // if (_formType == FormType.login) {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      // print('Signed in: $userId');
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    }
    return null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Register'),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        }, 
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is Loading) {
            // Showing the loading indicator while the user is signing in
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UnAuthenticated) {
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs() + buildSubmitButtons(),
                ),
              ),
            );
          }
          return Container();
        }
        )
        )
        );
  }

  List<Widget> buildInputs() {
    return <Widget>[
      TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        controller: emailTextController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return value != null && !EmailValidator.validate(value)
              ? 'Enter a valid email'
              : null;
        },
        // onSaved: (String value) => _email = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        controller: passwordTextController,
        obscureText: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return value != null && value.length < 6
              ? "Enter min. 6 characters"
              : null;
        },
        // onSaved: (String value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    // if (_formType == FormType.register) {
    return <Widget>[
      ElevatedButton(
        key: Key('signUp'),
        child: Text('Register', style: TextStyle(fontSize: 20.0)),
        onPressed: () {
          _createAccountWithEmailAndPassword(context);
        },
      ),
      TextButton(
        child: Text('Login to account', style: TextStyle(fontSize: 20.0)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      ),
    ];
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          emailTextController.text,
          passwordTextController.text,
        ),
      );
    }
  }
}
