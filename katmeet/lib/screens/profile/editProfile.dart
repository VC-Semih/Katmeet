import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var imageFile;
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
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
    );
    UserRepository.updateUser(newUser);
  }

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
  void _openGallery(BuildContext context) async {
    var picture = await _picker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
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
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCameraView(context);
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
        })
      })
    });

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
  



    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body:
      Form(
        key: _formKey,
        child: Column(children:<Widget>[
            Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(child: Image.asset('https://i.natgeofe.com/n/9135ca87-0115-4a22-8caf-d1bdef97a814/75552.jpg', height: 150, width: 150, fit: BoxFit.cover,),),
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
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40), )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



