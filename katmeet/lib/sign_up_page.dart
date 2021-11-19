import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'auth_credentials.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials> didProvideCredentials;
  final VoidCallback shouldShowLogin;
  SignUpPage({Key? key, required this.didProvideCredentials, required this.shouldShowLogin})
   : super(key: key);
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();

  String date = "";
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            // Sign Up Form
            _signUpForm(),

            // Login Button
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: widget.shouldShowLogin,
                  child: const Text('Already have an account? Login.')),
            )
          ])),
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
              icon: Icon(Icons.person), labelText: 'Nom complet'),
        ),

        // Email TextField
        TextField(
          controller: _emailController,
          decoration:
              const InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
        ),

        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
              icon: Icon(Icons.lock_open), labelText: 'Mot de passe'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        TextFormField(
          readOnly: true,
          controller: _dateController,
          decoration: const InputDecoration(
          icon: Icon(Icons.date_range),
          labelText: 'Date',
        ),
        onTap: () async {
          await showDatePicker(
            context: context,
            initialDate: DateTime(DateTime.now().year-18),
            firstDate: DateTime(DateTime.now().year-100),
            lastDate: DateTime(DateTime.now().year-18),
          ).then((selectedDate) {
            if (selectedDate != null) {
              _dateController.text =
              DateFormat('dd/MM/yyyy').format(selectedDate);
            }
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer votre date de naissance.';
          }
          return null;
        }),
        // Sign Up Button
        FlatButton(
            onPressed: _signUp,
            child: Text('Sign Up'),
            color: Theme.of(context).accentColor)
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final date = _dateController.text.trim();

    print('username: $username');
    print('email: $email');
    print('password: $password');
    print('date naissance: $date');

    final credentials = SignUpCredentials(
      username: username, 
      email: email, 
      password: password,
      date: date
    );
    widget.didProvideCredentials(credentials);
  }

}
