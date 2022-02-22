import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:katmeet/models/ModelProvider.dart';
import 'package:katmeet/screens/drawerScreen.dart';
import 'package:katmeet/screens/home.dart';
import 'amplifyconfiguration.dart';
import 'screens/auth.dart';

void main() {
  runApp(MyAppState());
}

class MyAppState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyApp();
}

class MyApp extends State<MyAppState> {
  AmplifyAuthCognito auth = AmplifyAuthCognito();
  AmplifyStorageS3 storage = AmplifyStorageS3();
  AmplifyAnalyticsPinpoint analytics = AmplifyAnalyticsPinpoint();
  AmplifyDataStore dataStore = AmplifyDataStore(modelProvider: ModelProvider.instance);
  AmplifyAPI api = AmplifyAPI();

  bool configured = false;
  bool authenticated = false;

  @override
  initState() {
    super.initState();

    Amplify.addPlugins([auth, storage, analytics, dataStore, api]);
    Amplify.configure(amplifyconfig).then((value) {
      print("Amplify Configured");
      setState(() {
        configured = true;
      });
    }).catchError(print);
  }

  Future<void> _checkSession() async {
    print("Checking Auth Session...");
    try {
      var session = await auth.fetchAuthSession();
      authenticated = session.isSignedIn;
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      // if not signed in this should be caught
      // either way we will setup HUB events
      print(error);
    }
    _setupAuthEvents();
  }

  void _setupAuthEvents() {
    Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch (hubEvent.eventName) {
        case "SIGNED_IN":
          {
            print("HUB: USER IS SIGNED IN");
            setState(() {
              authenticated = true;
            });
          }
          break;
        case "SIGNED_OUT":
          {
            print("HUB: USER IS SIGNED OUT");
            setState(() {
              authenticated = false;
            });
          }
          break;
        case "SESSION_EXPIRED":
          {
            print("HUB: USER SESSION EXPIRED");
            setState(() {
              authenticated = false;
            });
          }
          break;
        default:
          {
            print("HUB: CONFIGURATION EVENT");
          }
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Katmeet',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: new FutureBuilder<void>(
          future: _checkSession(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                body: Stack(
                  children: [
                    DrawerScreen(),
                    authenticated ? HomePage(auth: auth) : Authenticator()
                  ],
                ),
              ); authenticated ? HomePage(auth: auth) : Authenticator();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
