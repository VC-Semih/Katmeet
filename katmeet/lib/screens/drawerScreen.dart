import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:katmeet/auth_repository.dart';
import 'package:katmeet/models/ModelProvider.dart';
import 'package:katmeet/screens/Animal/pets.dart';
import 'package:katmeet/screens/Profile.dart';
import 'package:katmeet/screens/Animal/newPet.dart';
import 'package:katmeet/screens/profile/editProfile.dart';
import '../user_repository.dart';
import 'chat/dart.dart';
import 'configuration.dart';


class DrawerScreen extends StatefulWidget {

  DrawerScreen({Key key, @required this.auth}) : super(key: key);
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
  final AmplifyAuthCognito auth;
}

class _DrawerScreenState extends State<DrawerScreen> {

  UserModel userModel;

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
    return Container(
      color: primaryGreen,
      padding: EdgeInsets.only(top:100,bottom: 70,left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage('assets/kat.png') as ImageProvider,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('KatMeet',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ],
              )
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10,),
              Icon(FontAwesomeIcons.userAlt,color: Colors.white,size: 30,),
              SizedBox(width: 10,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
                },
                child: Text(
                  'Profile', //title
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  //aligment
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10,),
              Icon(FontAwesomeIcons.paw,color: Colors.white,size: 30,),
              SizedBox(width: 10,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewPet()));
                },
                child: Text(
                  'Add pet', //title
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  //aligment
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10,),
              Icon(FontAwesomeIcons.paw,color: Colors.white,size: 30,),
              SizedBox(width: 10,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyPets()));
                },
                child: Text(
                  'Pets', //title
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  //aligment
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10,),
              Icon(FontAwesomeIcons.solidComment,color: Colors.white,size: 30,),
              SizedBox(width: 10,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(username:userModel.username )));
                },
                child: Text(
                  'Chat', //title
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  //aligment
                ),
              ),
            ],
          ),
          Row(

            children: [
              Icon(Icons.settings,color: Colors.white,),
              SizedBox(width: 10,),
              Text('Settings',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              Container(width: 2,height: 20,color: Colors.white,),
              SizedBox(width: 10,),
              TextButton(
                onPressed: () {
                  AuthRepository.signOut();
                },
                child: Text(
                  'Log Out', //title
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  //aligment
                ),
              ),

            ],

          )
        ],
      ),

    );
  }
}
