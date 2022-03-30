import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../configuration.dart';

class ShowAnimal extends StatelessWidget {
  final String id;

  const ShowAnimal({Key key, this.id}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryGreen,
          title: Text("Animal Description"),
          leading: Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
              child:CircleAvatar(backgroundImage: NetworkImage('https://images.theconversation.com/files/350865/original/file-20200803-24-50u91u.jpg?ixlib=rb-1.1.0&rect=37%2C29%2C4955%2C3293&q=45&auto=format&w=926&fit=clip'),),),),
        body: Container(
          child:
          Scaffold(
            body: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()),
            ),
          ),
        ));
  }
}