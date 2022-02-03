import 'dart:ui';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'configuration.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}
class _Profile extends State<Profile> {
  AuthUser _user;
  @override
  void initState() {
    super.initState();
    Amplify.Auth.getCurrentUser().then((user) {
      setState(() {
        _user = user;
      });
    }).catchError((error) {
      print((error as AuthException).message);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: new Column(
              children: <Widget>[

                Card(
                  child: new Stack(
                    alignment: AlignmentDirectional.center,//add this line
                    children: <Widget>[
                    Image.asset('assets/images/pet-cat2.png'),
                      new Container(
                        width: 200.0,
                        height: 200.0,
                      ),
                      new Container(
                        alignment: new FractionalOffset(0.0, 0.0),
                        decoration: new BoxDecoration(
                          border: new Border.all(
                            color: Colors.blue.withOpacity(0.5),
                            width: 20, // it's my slider variable, to change the size of the circle
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      new Container(
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 80.0,vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: primaryGreen,
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        _user.username,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 80.0,vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: primaryGreen,
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                _user.username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 80.0,vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: primaryGreen,
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                _user.username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: primaryGreen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Adopted",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "4",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(

                            children: <Widget>[
                              Text(
                                "Given",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "12",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: primaryGreen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Adopted",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "4",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(

                            children: <Widget>[
                              Text(
                                "Given",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "12",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 120,
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 70,
                          decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.favorite_border,color: Colors.white,),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(color: primaryGreen,borderRadius: BorderRadius.circular(20)),
                            child: Center(child: Text('Adoption',style: TextStyle(color: Colors.white,fontSize: 24),)),
                          ),
                        )
                      ],
                    )
                    ,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40), )
                    ),
                  ),
                )
         ])
      ));
  }
}
