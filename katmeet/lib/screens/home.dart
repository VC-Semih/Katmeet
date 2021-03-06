import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katmeet/animal_repository.dart';
import 'package:katmeet/auth_repository.dart';
import 'package:katmeet/functions/storage_service.dart';
import 'package:katmeet/models/AnimalModel.dart';
import 'package:katmeet/models/PhotosModel.dart';
import 'package:katmeet/models/TypeAnimal.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/user_repository.dart';
import 'package:katmeet/widget/refresh_widget.dart';
import '../photo_repository.dart';
import 'Animal/showAnimal.dart';
import 'SideBar.dart';
import 'configuration.dart';


class HomePage extends StatefulWidget {
  final _storageService = new StorageService();
  HomePage({Key key, @required this.auth}) : super(key: key);
  @override
  HomePageState createState() => HomePageState(_storageService);
  final AmplifyAuthCognito auth;
}
class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final StorageService _storageService;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  UserModel userModel;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  UserModel user;
  List<AnimalModel> animalsModelList;
  bool _loading = true;
  List<String> s3keys = [];
  List<PhotosModel> photosModel = [];
  Map<String, String> animalS3 = new Map<String, String>();

  TypeAnimal curentAnimalType = null;

  HomePageState(this._storageService);

  @override
  void initState() {
    super.initState();
    _loading = true;
    AuthRepository.getEmailFromAttributes().then((email) => {
          UserRepository.getUserByEmail(email).then((user) => {
                setState(() {
                  _loading = false;
                  userModel = user;
                })
              })
        });
    loadAnimals();
  }
  Future<void> loadAnimals() async {
    await Future.delayed(Duration(milliseconds: 1000));
    keyRefresh.currentState?.show();
    if(curentAnimalType == null){
      AnimalRepository.getAllAnimals().then((value) =>
      {
        setState(() {
          animalsModelList = value;
          loadAll();
        })
      });
    }else{
      AnimalRepository.getAnimalsByType(curentAnimalType).then((value) => {
        setState(() {
          animalsModelList = value;
          loadAll();
        })
      });
    }
  }
  Future<void> loadAll() {
    if(animalsModelList != null) {
      for (AnimalModel animal in animalsModelList) {
        PhotoRepository.getPhotosByAnimalID(animal.id).then((photos) =>
        {
          if (photos != null)
            {
              setState(() {
                s3keys.add(photos.first.s3key);
                animalS3.putIfAbsent(animal.id, () => photos.first.s3key);
                _storageService.getImages();
                _loading = false;
              })
            } else {
            setState(() {
              _storageService.getImagesByS3KeyList(s3keys);
              _loading = false;
            })
          }
        });
      }
    } else {
      setState(() {
        _storageService.getImagesByS3KeyList(s3keys);
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)..rotateY(isDrawerOpen? -0.5:0),
      duration: Duration(milliseconds: 250),

      decoration: BoxDecoration(
          color: Colors.grey[200],

          borderRadius: BorderRadius.circular(isDrawerOpen?40:0.0)

      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen?IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: (){
                      setState(() {
                        xOffset=0;
                        yOffset=0;
                        scaleFactor=1;
                        isDrawerOpen=false;
                      });
                    },

                  ): IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        setState(() {
                          xOffset = 230;
                          yOffset = 150;
                          scaleFactor = 0.6;
                          isDrawerOpen=true;
                        });
                      }),
                  Column(
                    children: [
                      _loading ? CircularProgressIndicator() : Text(userModel != null ? userModel.username : "loading..."),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryGreen,
                          ),
                          Text('Laon'),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar()
                ],
              ),
            ),

            Container(height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: () {
                      setState(() {
                        switch (categories[index]['name']){
                          case "Dogs":
                            curentAnimalType = TypeAnimal.DOG;
                            loadAnimals();
                            break;
                          case "Cats":
                            curentAnimalType = TypeAnimal.CAT;
                            loadAnimals();
                            break;
                          default:
                            curentAnimalType = null;
                            loadAnimals();
                            break;
                        }
                      });
                    },
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset(
                                categories[index]['iconPath'],
                                height: 50,
                                width: 50,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(categories[index]['name'])
                          ],
                    ),
                  ));
                },

              ),
            ),
          RefreshWidget(onRefresh: loadAnimals,
            child: Container(
              height: 500,
              child: _loading ? CircularProgressIndicator() :
              animalsModelList != null ?
              StreamBuilder(
                  stream: _storageService.imageUrlsController.stream,
                  builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
                    if (snapshot.data == null) {
                      return CircularProgressIndicator();
                    }
                    return ListView.builder(
                        itemCount: animalsModelList.length,
                        itemBuilder: (BuildContext context,int index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalShows(id:animalsModelList[index].id)));
                            },
                            child:
                            Container(
                              height: 240,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: animalS3[animalsModelList[index].id] != null && snapshot.data.keys.toList().indexOf(animalS3[animalsModelList[index].id]) >= 0 ?
                                          BoxDecoration(
                                              color: Colors.blueGrey[300],
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: shadowList,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: new CachedNetworkImageProvider(snapshot.data.values.elementAt(snapshot.data.keys.toList().indexOf(animalS3[animalsModelList[index].id])))
                                              )
                                          ) :
                                          BoxDecoration(color: Colors.blueGrey[300],
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: shadowList,
                                          ),
                                          margin: EdgeInsets.only(top: 50),
                                        ),
                                        if (animalS3[animalsModelList[index].id] == null) ...[
                                          if (animalsModelList[index].type == TypeAnimal.CAT) ...[
                                            Align(
                                              child: Hero(
                                                  tag:index,child: Image.asset('assets/images/pet-cat2.png')),
                                            )
                                          ] else ...[
                                            Align(
                                              child: Hero(
                                                  tag:index,child: Image.asset('assets/images/pet-dog.png')),
                                            )
                                          ]
                                        ]
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            animalsModelList[index].race,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),),
                                        margin: EdgeInsets.only(top: 60,bottom: 20),
                                        decoration: BoxDecoration(color: Colors.white,
                                            boxShadow: shadowList,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight: Radius.circular(20)
                                            )
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );}
                    );
                  }
              ) : Text("You have no animals"),

            )),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}