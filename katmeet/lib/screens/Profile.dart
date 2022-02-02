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
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey[300],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  )
                ],
              )),
          Container(
            margin:EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                    Navigator.pop(context);
                  }),
                  IconButton(icon: Icon(Icons.share), onPressed: (){

                  })
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Align(

              alignment: Alignment.topCenter,
              child: Hero(
                  tag: 1,
                  child: Image.asset('assets/images/pet-cat2.png')),
            ),
          ),

          Align(
            alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: 450.0,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: primaryGreen,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                            "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                          ),
                        ),
                        radius: 60,
                      ),
                      SizedBox(
                        height: 5.0,
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
                      ) ,

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
                                      "test",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                ),
              )
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
        ],
      ),
    );
  }
}
