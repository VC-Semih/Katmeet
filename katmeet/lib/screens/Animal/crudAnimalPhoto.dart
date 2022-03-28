import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:katmeet/functions/storage_service.dart';
import 'package:katmeet/models/AnimalModel.dart';
import 'package:katmeet/models/PhotosModel.dart';
import 'package:katmeet/widget/refresh_widget.dart';

import '../../photo_repository.dart';
import '../capture.dart';
import '../photo_display.dart';

class CrudAnimalPhoto extends StatefulWidget {
  final AnimalModel animalModel;
  final _storageService = new StorageService();

  CrudAnimalPhoto({Key key, this.animalModel}) : super(key: key);

  @override
  CrudAnimalPhotoState createState() =>
      CrudAnimalPhotoState(animalModel, _storageService);
}

class CrudAnimalPhotoState extends State<CrudAnimalPhoto> {
  final AnimalModel _animalModel;
  final StorageService _storageService;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  var theme1 = Colors.white;
  var theme2 = Color(0xff2E324F);
  var white = Colors.white;
  var black = Colors.black;

  CrudAnimalPhotoState(this._animalModel, this._storageService);

  dynamic _openCameraView(BuildContext context) async {
    try {
      var cameras = await availableCameras();
      if (cameras.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Capture(camera: cameras.first, animalModelID: _animalModel.id,)));
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
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 1000));
    List<PhotosModel> photos = await PhotoRepository.getPhotosByAnimalID(_animalModel.id);
    List<String> s3keys = [];
    if(photos != null) {
      await photos.forEach((element) {
        s3keys.add(element.s3key);
      });
    }
    _storageService.getImagesByS3KeyList(s3keys);
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
        body: Container(child: _galleryGrid()));
  }

  Widget _galleryGrid() {
    return StreamBuilder(
        // Le générateur StreamBuilder va utiliser le contrôleur imageUrlsController qui sera transmis du service StorageService pour fournir des instantanés de nos données.
        stream: _storageService.imageUrlsController.stream,
        builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
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
                          physics: AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  crossAxisCount: 2),
                          // Au lieu d'utiliser un chiffre codé en dur, nous pouvons maintenant faire en sorte que la taille de notre vue GridView soit basée sur la longueur des données de notre instantané.
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return FocusedMenuHolder(
                                menuWidth:
                                    MediaQuery.of(context).size.width * 0.50,
                                blurSize: 5.0,
                                menuItemExtent: 45,
                                menuBoxDecoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                duration: Duration(milliseconds: 100),
                                animateMenuItems: true,
                                blurBackgroundColor: Colors.black54,
                                bottomOffsetHeight: 100,
                                openWithTap: true,
                                menuItems: <FocusedMenuItem>[
                                  FocusedMenuItem(
                                      title: Text("Open"),
                                      trailingIcon: Icon(Icons.open_in_new),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PhotoDisplay(
                                                        imgUrl: snapshot
                                                            .data.values
                                                            .elementAt(
                                                                index))));
                                      }),
                                  FocusedMenuItem(
                                      title: Text("Share"),
                                      trailingIcon: Icon(Icons.share),
                                      onPressed: () {}),
                                  FocusedMenuItem(
                                      title: Text("Favorite"),
                                      trailingIcon: Icon(Icons.favorite_border),
                                      onPressed: () {}),
                                  FocusedMenuItem(
                                      title: Text(
                                        "Delete",
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                      trailingIcon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () async {
                                        final s3key =
                                            snapshot.data.keys.elementAt(index);
                                        try {
                                          RemoveOptions options = RemoveOptions(
                                              accessLevel:
                                                  StorageAccessLevel.protected);
                                          final RemoveResult result =
                                              await Amplify.Storage.remove(
                                                  key: s3key, options: options);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Your photo ${result.key} has been deleted ! ")));
                                          print('Deleted file: ${result.key}');
                                          loadList();
                                        } on StorageException catch (e) {
                                          print('Error deleting file: $e');
                                        }
                                        await PhotoRepository.deletePhotoByS3(
                                            s3Key: s3key);
                                      }),
                                ],
                                onPressed: () {},
                                child: CachedNetworkImage(
                                  imageUrl:
                                      snapshot.data.values.elementAt(index),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator()),
                                ));
                          })));
            } else {
              // Si l'instantané ne comporte aucun élément, nous afficherons un texte indiquant qu'il n'y a rien à afficher.
              return Center(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("No images to display"),
                    ElevatedButton(
                        onPressed: () {
                          loadList();
                        },
                        child: const Text('Reload')),
                  ],
                ),
              ));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
