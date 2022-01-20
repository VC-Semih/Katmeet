import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoDisplay extends StatelessWidget {
  final String imgUrl;

  const PhotoDisplay({Key key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My photo"),
          leading: Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: Image.asset('assets/kat.png')),
        ),
        body: Container(
          child:
            Scaffold(
              body: CachedNetworkImage(
              imageUrl: imgUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()),
            ),
            ),
        ));
  }
}