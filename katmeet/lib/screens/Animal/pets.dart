import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katmeet/animal_repository.dart';
import 'package:katmeet/functions/storage_service.dart';
import 'package:katmeet/models/AnimalModel.dart';
import 'package:katmeet/models/ModelProvider.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/photo_repository.dart';
import 'package:katmeet/screens/Animal/showAnimal.dart';

import '../../auth_repository.dart';
import '../../user_repository.dart';
import '../add_pet.dart';
import '../configuration.dart';


class MyPets extends StatefulWidget {
  final _storageService = new StorageService();

  MyPets({Key key}) : super(key: key);

  @override
  MyPetState createState() => MyPetState(_storageService);
}

class MyPetState extends State<MyPets> {
  final StorageService _storageService;

  UserModel userModel;
  List<AnimalModel> animalsModelList;
  bool _loading = true;
  List<String> s3keys = [];
  List<PhotosModel> photosModel = [];
  Map<String, String> animalS3 = new Map<String, String>();

  var theme1 = Colors.white;
  var theme2 = Color(0xff2E324F);
  var white = Colors.white;
  var black = Colors.black;

  MyPetState(this._storageService);

  @override
  Future<void> initState() {
    super.initState();
    AuthRepository.getEmailFromAttributes().then((email) => {
      UserRepository.getUserByEmail(email).then((user) => {
        AnimalRepository.getAnimalsByOwner(user.id).then((value) => {
          setState((){
            userModel = user;
            animalsModelList = value;
          }),
          loadAll()
        })
      })
    });
  }

  Future<void> loadAll() {
    if(animalsModelList != null) {
      for (AnimalModel animal in animalsModelList) {
        PhotoRepository.getPhotosByAnimalID(animal.id).then((photos) =>
        {
          if (photos != null)
            {
              setState(() {
                s3keys.add(photos.first.s3key);
                animalS3.putIfAbsent(animal.id, () => photos.first.s3key);
                _storageService.getImagesByS3KeyList(s3keys);
                _loading = false;
              })
            } else {
              setState(() {
                _storageService.getImagesByS3KeyList(s3keys);
                _loading = false;
              })
            }
        });
      }
    } else {
      setState(() {
        _storageService.getImagesByS3KeyList(s3keys);
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: theme1,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _loading ? CircularProgressIndicator() :
            animalsModelList != null ?
            StreamBuilder(
              stream: _storageService.imageUrlsController.stream,
              builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                    itemCount: animalsModelList.length,
                    itemBuilder: (BuildContext context,int index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalShows(id:animalsModelList[index].id)));
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
                                      decoration: animalS3[animalsModelList[index].id] != null && snapshot.data.keys.toList().indexOf(animalS3[animalsModelList[index].id]) >= 0 ?
                                      BoxDecoration(
                                          color: Colors.blueGrey[300],
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: shadowList,
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new CachedNetworkImageProvider(snapshot.data.values.elementAt(snapshot.data.keys.toList().indexOf(animalS3[animalsModelList[index].id])))
                                          )
                                      ) :
                                      BoxDecoration(color: Colors.blueGrey[300],
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: shadowList,
                                      ),
                                      margin: EdgeInsets.only(top: 50),
                                    ),
                                    if (animalS3[animalsModelList[index].id] == null) ...[
                                      if (animalsModelList[index].type == TypeAnimal.CAT) ...[
                                        Align(
                                          child: Hero(
                                              tag:index,child: Image.asset('assets/images/pet-cat2.png')),
                                        )
                                      ] else ...[
                                        Align(
                                          child: Hero(
                                              tag:index,child: Image.asset('assets/images/pet-dog.png')),
                                        )
                                      ]
                                    ]
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
                );
              }
            ) : Text("You have no animals")
      );
  }
}
