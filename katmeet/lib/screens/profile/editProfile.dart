
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/user_repository.dart';
import '../configuration.dart';
import 'package:katmeet/auth_repository.dart';


class FormProfile extends StatefulWidget {
  @override
  _FormProfile createState() => _FormProfile();
}

class _FormProfile extends State<FormProfile> {
  UserModel userModel;

  var theme1 = Colors.white;
  var theme2 = Color(0xff2E324F);
  var white = Colors.white;
  var black = Colors.black;
  bool switchColor = false;


  

  @override
  Future<void> initState() {
    super.initState();

    AuthRepository.getEmailFromAttributes().then((email) => {
      UserRepository.getUserByEmail(email).then((user) => {
        setState(() {
          userModel = user;
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
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(child: Image.asset('https://i.natgeofe.com/n/9135ca87-0115-4a22-8caf-d1bdef97a814/75552.jpg', height: 150, width: 150, fit: BoxFit.cover,),),
                ),
                Positioned(bottom: 1, right: 1 ,
                    child:
                Container(
                  height: 40, width: 40,
                  child: new IconButton(
                    icon: new Icon(Icons.camera_alt),
                    onPressed: () { },
                  ),
                  decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
              child: TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.teal.shade100,
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a Username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal.shade100,
                  border: OutlineInputBorder(),
                  labelText: 'Date of birth',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a Username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
              child: TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.teal.shade100,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a Username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal.shade100,
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a Username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal.shade100,
                  border: OutlineInputBorder(),
                  labelText: 'Adresse',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a Username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal.shade100,
                  border: OutlineInputBorder(),
                  labelText: 'About me',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a Username';
                  }
                  return null;
                },
              ),
            ),



            Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              clipBehavior: Clip.antiAlias,
              color: primaryGreen,
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
                        child: Center(child: Text('Edit',style: TextStyle(color: Colors.white,fontSize: 24),)),
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

