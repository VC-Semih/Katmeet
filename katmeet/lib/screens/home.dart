import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:katmeet/auth_repository.dart';
import 'package:katmeet/models/UserModel.dart';
import 'package:katmeet/user_repository.dart';
import 'SideBar.dart';
import 'configuration.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.auth}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
  final AmplifyAuthCognito auth;
}
class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  UserModel userModel;
  bool _loading;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

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
                      _loading ? CircularProgressIndicator() : Text(userModel.username),
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

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search),
                  Text('Search pet to adopt'),
                  Icon(Icons.settings)

                ],
              ),
            ),

            Container(height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context,index){
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowList,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Image.asset(categories[index]['iconPath'],       height: 50,
                            width: 50,color: Colors.grey[700],),
                        ),
                        Text(categories[index]['name'])
                      ],
                    ),
                  );
                },

              ),
            ),


            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2()));

              },
              child: Container(
                height: 240,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.blueGrey[300],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: shadowList,
                            ),
                            margin: EdgeInsets.only(top: 50),
                          ),
                          Align(
                            child: Hero(
                                tag:1,child: Image.asset('assets/images/pet-cat2.png')),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
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
            ),
            Container(
              height: 240,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: shadowList,
                          ),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        Align(
                          child: Image.asset('assets/images/pet-cat1.png'),
                        )

                      ],
                    ),
                  ),
                  Expanded(child: Container(
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
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}