import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/screens/profile/editProfile.dart';
import 'package:katmeet/user_repository.dart';
import 'configuration.dart';
import 'package:katmeet/auth_repository.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  UserModel userModel;
  bool _loading;

  var theme1 = Colors.white;
  var theme2 = Color(0xff2E324F);
  var white = Colors.white;
  var black = Colors.black;
  bool switchColor = false;

  @override
  Future<void> initState() {
    super.initState();
    _loading = true;
    AuthRepository.getEmailFromAttributes().then((email) => {
          UserRepository.getUserByEmail(email).then((user) => {
                setState(() {
                  userModel = user;
                  _loading = false;
                })
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: theme1,
        elevation: 0.0,
        leading: Icon(
          Icons.arrow_back,
          color: black,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite_border,
              color: black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 8.0),
            child: Icon(
              Icons.more_vert,
              color: black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _loading ? loadingWidget(_loading) : Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 12.0, 50.0, 8.0),
                child: Stack(
                  alignment: const Alignment(0.9, 0.9),
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
                    Container(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset("assets/images/pet-cat2.png"),
                      alignment: Alignment.bottomRight,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Text(userModel.username != null ? userModel.username : "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: primaryGreen,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 4.0),
              child: Text(userModel.email,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: primaryGreen,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 4.0),
              child: Text(userModel.phoneNumber != null ? userModel.phoneNumber : "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: primaryGreen,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 4.0),
              child: Text(userModel.adress != null ? userModel.adress : "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: primaryGreen,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 0.0),
              child: Divider(
                color: Color(0xff78909c),
                height: 30.0,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
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
              margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
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
                           userModel.aboutMe != null ? userModel.aboutMe : "Hello ! I am using Katmeet",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
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
                        child:OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> FormProfile()));
                          },
                          child: Center(child: Text('Edit',style: TextStyle(color: Colors.white,fontSize: 24),)),
                        ),
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
      ),
    );
  }
}

Widget loadingWidget(_loading) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 12.0, 50.0, 8.0),
      child:
        Center(
            child: CircularProgressIndicator()
        ));
}
