import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:katmeet/animal_repository.dart';
import 'package:katmeet/functions/storage_service.dart';
import 'package:katmeet/models/AnimalModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:katmeet/models/TypeAnimal.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/photo_repository.dart';
import 'package:katmeet/screens/Animal/edit.dart';

import '../../auth_repository.dart';
import '../../user_repository.dart';
import '../Profile.dart';
import '../configuration.dart';
import 'crudAnimalPhoto.dart';

class AnimalShows extends StatefulWidget {
  @override
  AnimalShowsState createState() => AnimalShowsState(id);

  final String id;

  const AnimalShows({Key key, this.id}) : super(key: key);
}

class AnimalShowsState extends State<AnimalShows> {
  AnimalModel _animalModel;
  final String id;
  bool _loading = true;
  bool _hasPhotos = false;
  bool isAnimalOwner = false;

  var outputFormat = DateFormat('dd/MM/yyyy');
  AnimalShowsState(this.id);

  final _storageService = new StorageService();

  List<String> images = [];
  List<String> s3keys = [];

  UserModel userModel;


  @override
  Future<void> initState() {
    super.initState();
    AuthRepository.getEmailFromAttributes().then((email) => {
      UserRepository.getUserByEmail(email).then((user) => {
        setState((){
          userModel = user;
        }),
        loadAll()
      })
    });
  }

  Future<void> loadAll() {
    List<String> s3list = [];
    AnimalRepository.getAnimalById(id).then((value) => {
          PhotoRepository.getPhotosByAnimalID(value.id).then((photos) => {
                if (photos != null)
                  {
                    photos.forEach((photo) {
                      s3list.add(photo.s3key);

                    }),
                    _storageService
                        .getListImagesByS3keyList(s3list)
                        .then((imageList) => {
                          Future.delayed(Duration(seconds: 2)).then((event) => {
                            setState(() {
                              _animalModel = value;
                              s3keys = s3list;
                              _hasPhotos = true;
                              images = imageList;
                              _loading = false;
                            })
                          })
                        })
                  }else{
                  setState(() {
                    _animalModel = value;
                    _hasPhotos = false;
                    _loading = false;
                  })
                },
                if(value.animalOwner == userModel.id) {
                  setState((){
                    isAnimalOwner = true;
                  })
                },
                print(value.animalOwner)
              })
        });
  }
  var theme1 = Colors.white;
  var theme2 = Color(0xff2E324F);
  var white = Colors.white;
  var black = Colors.black;
  bool switchColor = false;
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
      body: _loading ? CircularProgressIndicator() : Stack(
        children:
        [
            SingleChildScrollView(
              child:

              Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[ Container(
                      color: Colors.blueGrey[300],
                      width: MediaQuery.of(context).size.width,
                      child: _hasPhotos ?
                      CachedNetworkImage(
                        imageUrl:images.first,
                        placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator()),
                      ) : null,
                    )],
                  ),
                  if(!_hasPhotos)...[
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Hero(
                          tag: id, child: _animalModel.type == TypeAnimal.CAT ?
                      Image.asset('assets/images/pet-cat2.png') :
                      Padding(padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0), child: Image.asset('assets/images/pet-dog.png'),)),
                    ),
                  )] else...[
                    Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0))
                  ],
                  if(isAnimalOwner) ...[
                  Center(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FormAnimal(id: _animalModel.id,)));// Respond to button press
                          },
                          icon: Icon(Icons.mode_edit, size: 18),
                          label: Text("Edit"),
                        ),
                        SizedBox(width: 5),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CrudAnimalPhoto(animalModel: _animalModel)));// Respond to button press
                          },
                          icon: Icon(Icons.photo_album, size: 18),
                          label: Text("Edit images"),
                        ),
                      ],
                    ),
                  )] else ...[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton.icon(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(userid: _animalModel.animalOwner)));
                          }, icon: Icon(Icons.contact_page, size: 18,), label: Text("Uploader profile"))
                        ],
                      ),
                    )
                  ],
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                    child: Text("Description " +  _animalModel.race != null ? _animalModel.race : "Hello ! I am using Katmeet",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: primaryGreen,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                    child: Text(outputFormat.format(DateTime.parse(_animalModel.birthdate.toString())),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: primaryGreen,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                    child: Text("Description " +  _animalModel.description != null ? _animalModel.description : "Hello ! I am using Katmeet",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: primaryGreen,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  if (_hasPhotos) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 15.0),
                      child: CarouselSlider(
                        options: CarouselOptions(autoPlay: true),
                        items: images.map((item) => Center(
                          child: CachedNetworkImage(
                            imageUrl:item,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator()),
                          ))).toList(),
                      ),
                    )],
                  Center(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 70,
                          decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(20)),
                          child:
                          TextButton.icon(
                            onPressed: () {
                              // Respond to button press
                            },
                            icon: Icon(Icons.favorite_border,color: Colors.red,),
                            label: Text("1",style: TextStyle(
                              color: Colors.black,//for text color
                            ),)
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

              ),
            ),

        ],
      ),
    );
  }
}
