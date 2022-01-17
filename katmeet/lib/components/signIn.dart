import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import 'dart:developer' as dev;

import '../auth_repository.dart';
import '../user_repository.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  //String _signUpError = "";
  //List<String> _signUpExceptions = [];

  void _signIn() async {
    try {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Signing in...')));
      SignInResult res = await Amplify.Auth.signIn(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim());
      dev.log('Sign In Result: ' + res.toString(),
          name: 'com.amazonaws.amplify');
      String uid = await AuthRepository.attemptAutoLogin();
      String username = _usernameController.text.trim();
      String email = await AuthRepository.getEmailFromAttributes();
      UserRepository.createUser(
          userId: uid,
          username: username,
          email: email
      );
    } on AuthException catch (e) {
      print(e.message);
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error Signing in")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Sign in to Your Account',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(),
                      labelText: 'Enter a Username',
                      hintText: 'SnowFlake',
                      icon: Icon(Icons.star)
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(),
                      labelText: 'Enter a Password',
                      hintText: '123-456-78',
                      icon: Icon(Icons.star)
                  ),
                  obscureText: true,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _signIn();
                          }
                        },
                        child: Text('SIGN IN'),
                        style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent)),
                      ),
              ],
            )));
  }
}
