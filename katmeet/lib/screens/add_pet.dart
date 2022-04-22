import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'capture.dart';
import 'configuration.dart';

class AddPet extends StatefulWidget {
  AddPet({Key key, @required this.auth}) : super(key: key);
  @override
  AddPetState createState() => AddPetState();

  final AmplifyAuthCognito auth;
}

class AddPetState extends State<AddPet> {
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
    S3ListOptions options =
    S3ListOptions(accessLevel: StorageAccessLevel.guest);
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
          backgroundColor: primaryGreen,
          tooltip: 'Capture a photo',
          child: Icon(Icons.add_a_photo),
        ),
        appBar: AppBar(
          title: Text("Photos"),
          actions: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  widget.auth.signOut(request: null);
                })
          ],
          leading: Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: Image.asset('assets/kat.png')),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [],
              ),
            )
          ],
        ));
  }
}
