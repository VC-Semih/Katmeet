import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:katmeet/functions/storage_service.dart';
import 'package:katmeet/screens/Profile.dart';
import 'package:katmeet/widget/refresh_widget.dart';

import 'capture.dart';

class Photos extends StatefulWidget {
  Photos({Key key, @required this.auth}) : super(key: key);

  @override
  PhotosState createState() => PhotosState(_storageService);

  final AmplifyAuthCognito auth;
  final _storageService = new StorageService();
}

class PhotosState extends State<Photos> {
  final StorageService _storageService;

  PhotosState(this._storageService);

  dynamic _openCameraView(BuildContext context) async {
    try {
      var cameras = await availableCameras();
      if (cameras.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Capture(camera: cameras.first)));
      } else {
        print("No cameras found");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    loadList();
  }

  Future loadList() async {
    _storageService.getImages();
    S3ListOptions options =
    S3ListOptions(accessLevel: StorageAccessLevel.protected);
    Amplify.Storage.list(path: 'protected', options: options).then((result) {
      print("Storage items");
      print(result.items);
    }).catchError(print);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openCameraView(context),
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Capture a photo',
          child: Icon(Icons.add_a_photo),
        ),
        appBar: AppBar(
          title: Text("Photos"),
          actions: [
            PopupMenuButton(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text('Profile'),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text('Logout'),
                        onTap: () {
                          widget.auth.signOut(request: null);
                        },
                      ),
                    ]),
          ],
          leading: Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: Image.asset('assets/kat.png')),
        ),
        body: Container(child: _galleryGrid()));
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
        break;
    }
  }

  Widget _galleryGrid() {
    return StreamBuilder(
        // Le générateur StreamBuilder va utiliser le contrôleur imageUrlsController qui sera transmis du service StorageService pour fournir des instantanés de nos données.
        stream: _storageService.imageUrlsController.stream,
        builder: (context, snapshot) {
          // L'interface utilisateur exige que l'instantané possède des données afin d'afficher quelque chose de pertinent à l'utilisateur.
          if (snapshot.hasData) {
            // Nous devons également déterminer si les données possèdent effectivement des éléments. Dans l'affirmative, nous poursuivons la génération de la vue GridView.
            if (snapshot.data.length != 0) {
              return RefreshWidget(
                  onRefresh: loadList,
                  child: Container(
                  margin: EdgeInsets.only(
                      left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: 2),
                      // Au lieu d'utiliser un chiffre codé en dur, nous pouvons maintenant faire en sorte que la taille de notre vue GridView soit basée sur la longueur des données de notre instantané.
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: snapshot.data[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator()),
                        );
                      })));
            } else {
              // Si l'instantané ne comporte aucun élément, nous afficherons un texte indiquant qu'il n'y a rien à afficher.
              return Center(child: Text('No images to display.'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
