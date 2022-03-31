import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katmeet/animal_repository.dart';
import 'package:katmeet/models/AnimalModel.dart';
import 'package:katmeet/models/ModelProvider.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/screens/Animal/showAnimal.dart';

import '../../auth_repository.dart';
import '../../user_repository.dart';
import '../add_pet.dart';
import '../configuration.dart';


class MyPets extends StatefulWidget {
  @override
  MyPetState createState() => MyPetState();
}

class MyPetState extends State<MyPets> {

  UserModel userModel;
  List<AnimalModel> animalsModelList;

  @override
  Future<void> initState() {
    super.initState();
    AuthRepository.getEmailFromAttributes().then((email) => {
      UserRepository.getUserByEmail(email).then((user) => {
        AnimalRepository.getAnimalsByOwner(user.id).then((value) => {
          setState((){
            userModel = user;
            animalsModelList = value;
            print(animalsModelList.length);
          })
        })
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Pets",
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: primaryGreen,
        ),
        body:
        ListView.builder(
            itemCount: animalsModelList.length,
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AnimalShows(id:animalsModelList[index].id)));
                },
                child:
                Container(
                  height: 240,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Colors.blueGrey[300],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: shadowList,
                              ),
                              margin: EdgeInsets.only(top: 50),
                            ),
                            Align(
                              child: Hero(
                                  tag:1,child: Image.asset('assets/images/pet-cat2.png')),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  animalsModelList[index].race,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),),
                            margin: EdgeInsets.only(top: 60,bottom: 20),
                            decoration: BoxDecoration(color: Colors.white,

                                boxShadow: shadowList,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)

                                )
                            ),

                          ))

                    ],
                  ),

                ),
              );}
        ),
      ),
    );
  }
}
