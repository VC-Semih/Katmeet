import 'package:flutter/material.dart';

Color primaryGreen = Color(0xff416d6d);
Color Black = Color(0xff000000);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];
List<Map> categories = [
  {'name': 'Cats', 'iconPath': 'assets/images/cat.png'},
  {'name': 'Dogs', 'iconPath': 'assets/images/dog.png'},
  {'name': 'All', 'iconPath': 'assets/images/catdog.png'},
];
