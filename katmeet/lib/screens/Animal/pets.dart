import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:katmeet/animal_repository.dart';
import 'package:katmeet/models/AnimalModel.dart';
import 'package:katmeet/models/UserModel.dart';

import '../../auth_repository.dart';
import '../../user_repository.dart';
import '../add_pet.dart';


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
        userModel = user,
      }),
    AnimalRepository.getAnimalsByOwner(userModel).then((animals) => {
    print(animals)
    })
    });


  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Pets",
      home: Scaffold(
        appBar: AppBar(

        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }),
        ),
      ),
    );
  }
}