import 'package:flutter/material.dart';
import '../components/signIn.dart';
import '../components/signUp.dart';
import '../components/forgotPassword.dart';

class Authenticator extends StatelessWidget {
  Authenticator() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text("KatMeet"),
              leading: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: CircleAvatar(backgroundImage: NetworkImage('https://images.theconversation.com/files/350865/original/file-20200803-24-50u91u.jpg?ixlib=rb-1.1.0&rect=37%2C29%2C4955%2C3293&q=45&auto=format&w=926&fit=clip'),),
              )                  ,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person_add)),
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.person_outline))
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SignUp(),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SignIn(),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ForgotPassword(),
                )
              ],
            )));
  }
}
