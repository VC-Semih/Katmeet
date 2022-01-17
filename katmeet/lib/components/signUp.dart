import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _verifyPasswordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isSignedUp = false;

  SignUpState();

  void _signUp() async {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Signing Up...")));
    Map<String, String> userAttributes = {"email": _emailController.text};
    try {
      await Amplify.Auth.signUp(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
          options: CognitoSignUpOptions(userAttributes: userAttributes));
      setState(() {
        _isSignedUp = true;
      });
    } on AuthException catch (error) {
      setState(() {
        _isSignedUp = false;
      });
      print(error.message);
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Sign up failed, do you already have an account?")));
    } on Exception catch (error) {
      print(error);
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("An unknown error occurred")));
    }
  }

  void _confirm() async {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Confirming...')));
    try {
      await Amplify.Auth.confirmSignUp(
          username: _usernameController.text.trim(),
          confirmationCode: _confirmController.text.trim());
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Confirmed, you can now login.')));
      setState(() {
        _isSignedUp = false;
      });
    } on AuthException catch (error) {
      print(error.message);
      setState(() {
        _isSignedUp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Visibility(
                    visible: _isSignedUp,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text('Enter Confirmation Code',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _confirmController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue.shade100,
                              border: OutlineInputBorder(),
                              labelText: 'Enter confirmation code',
                              hintText: 'Confirmeow',
                              icon: Icon(Icons.star)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter confirmation code';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25.0),
                        ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _confirm();
                                  }
                                },
                                child: Text('CONFIRM ACCOUNT'),
                          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent)),

                        ),

                        ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isSignedUp = false;
                                  });
                                },
                                child: Text('CANCEL'),
                          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent)),
                              ),
                      ],
                    )),
                SizedBox(height: 30.0),
                Visibility(
                  visible: !_isSignedUp,

                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Create a New Account',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 24)),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _usernameController,
                        decoration:
                            InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                border: OutlineInputBorder(),
                                labelText: 'Enter a Username',
                                hintText: 'SnowFlake',
                                icon: Icon(Icons.star)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _emailController,
                        decoration:
                            InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                border: OutlineInputBorder(),
                                labelText: 'Enter your Email',
                                hintText: 'SnowFlake@katmeet.com',
                                icon: Icon(Icons.star)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an Email Address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                border: OutlineInputBorder(),
                                labelText: 'Enter a Password',
                                hintText: '123-456-78',
                                icon: Icon(Icons.star)),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _verifyPasswordController,
                        decoration:
                            InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                border: OutlineInputBorder(),
                                labelText: 'Verify Password',
                                hintText: '123-456-78',
                                icon: Icon(Icons.star)),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please verify password';
                          }
                          if (value.contains(_passwordController.text.trim())) {
                            return null;
                          } else {
                            return 'Passwords do not match';
                          }
                        },
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _signUp();
                                }
                              },
                              child: Text('SIGN UP'),
                        style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent)),
                      ),
                              
                      ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isSignedUp = true;
                                });
                              },
                              child: Text('CONFIRM ACCOUNT'),
                        style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent)),
                            ),

                    ],
                  ),
                )
              ],
            )));
  }
}
