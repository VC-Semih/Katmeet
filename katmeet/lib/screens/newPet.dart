import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katmeet/models/ModelProvider.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/screens/Profile.dart';

import '../auth_repository.dart';
import '../user_repository.dart';

class NewPet extends StatefulWidget {
  const NewPet({Key key}) : super(key: key);

  @override
  NewPetState createState() => NewPetState();
}

class NewPetState extends State<NewPet> {
  UserModel userModel;
  bool _loading;

  var theme1 = Colors.white;
  var theme2 = Color(0xff2E324F);
  var white = Colors.white;
  var black = Colors.black;
  bool switchColor = false;

  @override
  Future<void> initState() {
    super.initState();
    _loading = true;
    AuthRepository.getEmailFromAttributes().then((email) => {
          UserRepository.getUserByEmail(email).then((user) => {
                setState(() {
                  userModel = user;
                  _loading = false;
                })
              })
        });
  }

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
      body: SingleChildScrollView(
        child: _loading
            ? loadingWidget(_loading)
            : Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 12.0, 50.0, 8.0),
                      child: const MyCustomForm(),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _race = TextEditingController();
  final _description = TextEditingController();
  TypeAnimal _animalType = TypeAnimal.CAT;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Animal type"),
          Row(children: <Widget>[
            Expanded(
                child: ListTile(
              title: const Text('CAT'),
              leading: Radio<TypeAnimal>(
                value: TypeAnimal.CAT,
                groupValue: _animalType,
                onChanged: (TypeAnimal value) {
                  setState(() {
                    _animalType = value;
                  });
                },
                activeColor: Colors.teal.shade700,
              ),
            )),
            Expanded(
                child: ListTile(
              title: const Text('DOG'),
              leading: Radio<TypeAnimal>(
                value: TypeAnimal.DOG,
                groupValue: _animalType,
                onChanged: (TypeAnimal value) {
                  setState(() {
                    _animalType = value;
                  });
                },
                activeColor: Colors.teal.shade700,
              ),
            )),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
            child: TextFormField(
              controller: _race,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.teal.shade100,
                border: OutlineInputBorder(),
                labelText: "Race",
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your animal\'s race';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _description,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.teal.shade100,
                border: OutlineInputBorder(),
                labelText: "Description",
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your animal\'s description';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
