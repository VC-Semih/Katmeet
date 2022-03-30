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
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(animalsModelList.length, (index) {
            return
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowAnimal(id: animalsModelList[index].id))),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.indeterminate_check_box_outlined),
                        title: Text(animalsModelList[index].race),
                        subtitle: Text(
                          animalsModelList[index].race,
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          animalsModelList[index].description,
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              ;
          }),
        ),
      ),
    );
  }
}
