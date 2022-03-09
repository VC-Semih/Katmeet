import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:katmeet/animal_repository.dart';
import 'package:katmeet/models/ModelProvider.dart';
import 'package:katmeet/models/UserModel.dart';

import '../../auth_repository.dart';
import '../../user_repository.dart';
import '../configuration.dart';

class NewPet extends StatefulWidget {
  const NewPet({Key key}) : super(key: key);

  @override
  NewPetState createState() => NewPetState();
}

class NewPetState extends State<NewPet> {
  UserModel userModel;
  bool _loading;

  final _formKey = GlobalKey<FormState>();
  final _race = TextEditingController();
  final _description = TextEditingController();
  TypeAnimal _animalType = TypeAnimal.CAT;

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

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(currentDate.year - 130),
        lastDate: DateTime(currentDate.year + 1));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
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
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(32),
            shrinkWrap: true,
            reverse: true,
            children: <Widget>[
              Form(
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
                      padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 4.0),
                    ),
                    Text("Animal birthdate"),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: primaryGreen,
                                borderRadius: BorderRadius.circular(40)),
                            child: OutlinedButton(
                              onPressed: () => _selectDate(context),
                              child: Center(
                                  child: Text(
                                DateFormat("dd/MM/yyyy").format(currentDate).toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                            ),
                          ),
                        )
                      ],
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
                            AnimalRepository.createAnimal(
                              type: _animalType,
                              race: _race.text,
                              description: _description.text,
                              birthdate: currentDate,
                              animalOwner: userModel,
                            ).then((value) => {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Your animal has been added !')),
                              )
                            });
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              )
            ].reversed.toList(),
          ),
        ));
  }
}

// Create a Form widget.
