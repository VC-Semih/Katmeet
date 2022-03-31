import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katmeet/animal_repository.dart';
import 'package:katmeet/models/AnimalModel.dart';

import '../configuration.dart';

class AnimalShows extends StatefulWidget {
  @override
  AnimalShowsState createState() => AnimalShowsState();

  final String id;

  const AnimalShows({Key key, this.id}) : super(key: key);
}

class AnimalShowsState extends State<AnimalShows> {
  AnimalModel _animalModel;

  @override
  Future<void> initState() {
    super.initState();
    AnimalRepository.getAnimalById(widget.id).then((value) => {
    setState((){
      _animalModel = value;
        }),
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
            margin: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  IconButton(icon: Icon(Icons.share), onPressed: () {})
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(
                  tag: 1, child: Image.asset('assets/images/pet-cat2.png')),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child:
            SingleChildScrollView(
              child:
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 0.0),
                    child: Divider(
                      color: Color(0xff78909c),
                      height: 30.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 100.0, 8.0, 4.0),
                    child: Text(_animalModel.birthdate.day.toString()+"/"+_animalModel.birthdate.month.toString()+"/"+_animalModel.birthdate.year.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: primaryGreen,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                    child: Text("Race " +_animalModel.race != null ? _animalModel.race : "Hello ! I am using Katmeet",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: primaryGreen,
                            fontSize: 20.0,
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

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
