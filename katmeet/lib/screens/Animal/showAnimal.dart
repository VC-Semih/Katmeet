import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:katmeet/animal_repository.dart';
import 'package:katmeet/functions/storage_service.dart';
import 'package:katmeet/models/AnimalModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:katmeet/photo_repository.dart';

import '../configuration.dart';

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

  var outputFormat = DateFormat('dd/MM/yyyy');
  AnimalShowsState(this.id);

  final _storageService = new StorageService();

  List<String> images = [
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];
  List<String> s3keys = [];

  @override
  Future<void> initState() {
    super.initState();
    loadAll();
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
                  }
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading ? CircularProgressIndicator() : Stack(
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

          Align(

            alignment: Alignment.center,
            child:
            SingleChildScrollView(
              child:
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Hero(
                          tag: id, child: Image.asset('assets/images/pet-cat2.png')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 40.0, 0.0),
                    child: Divider(
                      color: Color(0xff78909c),
                      height: 30.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                    child: Text(outputFormat.format(_animalModel.birthdate),
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
                  if (_hasPhotos) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
