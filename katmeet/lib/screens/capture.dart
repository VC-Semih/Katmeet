import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:katmeet/animal_repository.dart';
import 'package:katmeet/auth_repository.dart';
import 'package:katmeet/models/ModelProvider.dart';
import 'package:katmeet/photo_repository.dart';
import 'package:katmeet/user_repository.dart';

// A screen that allows users to take a picture using a given camera.
class Capture extends StatefulWidget {
  final CameraDescription camera;
  final String animalModelID;

  const Capture({
    Key key,
    @required this.camera,
    this.animalModelID,
  }) : super(key: key);

  @override
  CaptureState createState() => CaptureState(animalModelID);
}

class CaptureState extends State<Capture> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  final String _animalModelID;

  CaptureState(this._animalModelID);

  _toast(context, message) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_enhance),
        backgroundColor: Colors.white,
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
            // Attempt to take a picture and log where it's been saved.
            var file = await _controller.takePicture();
            print("Capture saved:");
            print(file.path);
            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen(imagePath: file.path, animalModelID: _animalModelID,),
              ),
            );
          } on Exception catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String animalModelID;

  const DisplayPictureScreen({Key key, this.imagePath, @required this.animalModelID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        backgroundColor: Theme.of(context).primaryColor,
        // Provide an onPressed callback.
        onPressed: () {
          print("Uploading file...");
          print(imagePath);
          var extension =
              imagePath.substring(imagePath.length - 3, imagePath.length);
          var key = new DateTime.now().microsecondsSinceEpoch.toString() +
              ".$extension";
          S3UploadFileOptions options =
              S3UploadFileOptions(accessLevel: StorageAccessLevel.protected);
          try {
            File local = File(imagePath);
            Amplify.Storage.uploadFile(key: key, local: local, options: options).then((UploadFileResult result) {
            PhotoRepository.createPhoto(s3Key: key, animalID: animalModelID);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Your photo has been uploaded ! ")
              ));
              print("file uploaded");
              print(result.key);
              Navigator.pop(context);
            }).catchError((error) {
              Navigator.pop(context);
              print(error);
            });
          } on Exception catch (e) {
            Navigator.pop(context);
            print(e);
          }
        },
      ),
      appBar: AppBar(title: Text('Upload Photo')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
