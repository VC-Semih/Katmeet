import 'dart:math';
import 'dart:ui';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/user_repository.dart';
import '../capture.dart';
import '../configuration.dart';
import 'package:katmeet/auth_repository.dart';

enum ImageSourceType { gallery, camera }


class FormProfile extends StatefulWidget {
  @override
  _FormProfile createState() => _FormProfile();


}

class _FormProfile extends State<FormProfile>  {


  UserModel userModel;
  PickedFile _imageFile;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final phone = TextEditingController();
  final adresse = TextEditingController();
  final aboutme = TextEditingController();


  void _updateUserInfo() async{

    UserModel newUser = userModel.copyWith(
        id: userModel.id,
        username: userModel.username,
        email: userModel.email,
        phoneNumber: phone.text.trim(),
        adress: adresse.text.trim() ,
        aboutMe: aboutme.text.trim(),
        profilePictureS3Key: _image.path
    );
    UserRepository.updateUser(newUser);
  }



  Future<File> takePhoto(ImageSource source) async {
    final XFile image = await _picker.pickImage(source: source);
    final File file = File(image.path);
    return file;
  }
  File _image;

  final _pickerImage = ImagePicker();
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
                  child: ClipOval(
                    child: Image.file(_image,fit: BoxFit.fill)) ,
                ):
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: Image.asset('https://i.natgeofe.com/n/9135ca87-0115-4a22-8caf-d1bdef97a814/75552.jpg', height: 150, width: 150, fit: BoxFit.cover,),
                  ),
                ),
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
                              _updateUserInfo();

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
}


