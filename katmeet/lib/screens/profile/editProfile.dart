import 'dart:math';
import 'dart:ui';
import 'dart:io';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katmeet/functions/storage_service.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/user_repository.dart';
import '../capture.dart';
import '../configuration.dart';
import 'package:katmeet/auth_repository.dart';

enum ImageSourceType { gallery, camera }


class FormProfile extends StatefulWidget {
  @override
  _FormProfile createState() => _FormProfile(_storageService);
  final _storageService = new StorageService();

}

class _FormProfile extends State<FormProfile>  {


  UserModel userModel;
  File _image;
  String _s3key;
  final StorageService _storageService;

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final phone = TextEditingController();
  final adresse = TextEditingController();
  final aboutme = TextEditingController();

  _FormProfile(this._storageService);

  void _updateUserInfo() async{
    UserModel newUser;
    if(_s3key.isNotEmpty) {
      newUser = userModel.copyWith(
        id: userModel.id,
        username: userModel.username,
        email: userModel.email,
        phoneNumber: phone.text.trim(),
        adress: adresse.text.trim(),
        aboutMe: aboutme.text.trim(),
        profilePictureS3Key: _s3key,
      );
    }else{
      newUser = userModel.copyWith(
          id: userModel.id,
          username: userModel.username,
          email: userModel.email,
          phoneNumber: phone.text.trim(),
          adress: adresse.text.trim(),
          aboutMe: aboutme.text.trim(),
      );
    }
    UserRepository.updateUser(newUser);
  }

  Future<File> takePhoto(ImageSource source) async {
    final XFile image = await _picker.pickImage(source: source);
    final File file = File(image.path);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  // Implementing the image picker
  Future<void> _openImagePicker(ImageSource source) async {
    final XFile pickedImage =
    await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openImagePicker(ImageSource.gallery);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        takePhoto(ImageSource.camera);
                      },
                    )
                  ],
                ),
              ));
        });
  }



  var theme1 = Colors.white;
  var theme2 = Color(0xff2E324F);
  var white = Colors.white;
  var black = Colors.black;
  bool switchColor = false;

  @override
  Future<void> initState() {
    super.initState();

    AuthRepository.getEmailFromAttributes().then((email) => {
      UserRepository.getUserByEmail(email).then((user) => {
        setState(() {
          userModel = user;

          phone.text = userModel.phoneNumber;
          adresse.text = userModel.adress;
          aboutme.text = userModel.aboutMe;
          _storageService.getImageByS3Key(userModel.profilePictureS3Key);
        })
      })
    });
    SystemChannels.textInput.invokeMethod('TextInput.hide');

  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ListView(
        padding: EdgeInsets.all(32),
        shrinkWrap: true,
        reverse: true,
        children: <Widget>[
          Form(
          key: _formKey,
          child: Column(children:<Widget>[
            Stack(
              children: <Widget>[
                _image != null ?
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(_image),
                  ):
                _profilePicture(),
                Positioned(bottom: 1, right: 1 ,
                    child:
                    Container(
                      height: 40, width: 40,
                      child: new IconButton(
                        icon: new Icon(Icons.camera_alt),
                        onPressed: () {  _showSelectionDialog(context);},
                      ),
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
              child: TextFormField(
                controller: phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal.shade100,
                  border: OutlineInputBorder(),
                  labelText: "Phone",
                ),
                onChanged: (text) {

                },
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
              child: TextFormField(
                controller: adresse,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal.shade100,
                  border: OutlineInputBorder(),
                  labelText: 'Adresse',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter an adress';
                  }
                  return null;
                },
                onSaved: (phone) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
              child: TextFormField(
                controller: aboutme,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal.shade100,
                  border: OutlineInputBorder(),
                  labelText: 'About me',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please describe yourself';
                  }
                  return null;
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 5.0),
              clipBehavior: Clip.antiAlias,
              color: primaryGreen,
            ),
            Card(

            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 100,
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(color: primaryGreen,borderRadius: BorderRadius.circular(20)),
                        child:OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Uploading...")
                              ));
                              if(_image != null){ //Only if image is not null we upload
                                var extension = _image.path.substring(_image.path.length - 3, _image.path.length);
                                var key = new DateTime.now().microsecondsSinceEpoch.toString() + ".$extension";
                                S3UploadFileOptions options = S3UploadFileOptions(accessLevel: StorageAccessLevel.protected);
                                try {
                                  File local = File(_image.path);
                                  Amplify.Storage.uploadFile(key: key, local: local, options: options).then((UploadFileResult result) {
                                    print(result.key);
                                    setState(() {
                                      _s3key = result.key;
                                    });
                                    _updateUserInfo();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text("Uploaded !")
                                    ));
                                  }).catchError(print);
                                } on Exception catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Something went wrong !")
                                  ));
                                  print(e);
                                }
                              }else{
                                _updateUserInfo();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Uploaded !")
                                ));
                              }
                            }
                          },
                          child: Center(child: Text('Edit',style: TextStyle(color: Colors.white,fontSize: 24),)),
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40), )
                ),
              ),
            )
          ],
          ),)
        ].reversed.toList(),
      ),
    ),
  );
  Widget _profilePicture() {
    return StreamBuilder(
        stream: _storageService.imageUrlController.stream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if(snapshot.hasData){
            if(snapshot.data.length != 0) {
              return CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                fit: BoxFit.contain,
                imageUrl: snapshot.data,
                imageBuilder: (context, imageProvider) {
                  return CircleAvatar(
                    radius: 70,
                    backgroundImage: imageProvider,
                  );
                },
              );
            }else{
              return CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage('https://i.natgeofe.com/n/9135ca87-0115-4a22-8caf-d1bdef97a814/75552.jpg'),
              );
            }
          }else{
            return CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }
}


