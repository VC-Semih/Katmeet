import 'dart:async';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

class StorageService {
  // Nous commençons par initialiser un contrôleur StreamController qui va gérer les URL des images récupérées dans Amazon S3.
  final imageUrlsController = StreamController<Map<String, String>>();
  final imageUrlController = StreamController<String>();

  // Cette fonction va lancer le processus de récupération des images devant être affichées dans GalleryPage.
  void getImages() async {
    try {
      // Étant donné que nous voulons afficher toutes les photos que les utilisateurs ont chargées, 
      // nous spécifions le niveau d'accès comme StorageAccessLevel.protected.
      final listOptions =
          S3ListOptions(accessLevel: StorageAccessLevel.protected);
      // Nous demandons ensuite à Storage de répertorier toutes les photos pertinentes étant donné les options S3ListOptions.
      final result = await Amplify.Storage.list(options: listOptions);

      // Si le résultat de la liste est probant,
      // nous devons obtenir la véritable URL de téléchargement de chaque photo car le résultat de la liste contient uniquement une liste de clés et non la véritable URL de la photo.
      final getUrlOptions =
          GetUrlOptions(accessLevel: StorageAccessLevel.protected);
      // Nous utilisons .map pour itérer sur chaque élément du résultat de la liste et renvoyer l'URL de téléchargement de chaque élément de manière asynchrone.
      final List<List<String>> imageUrls =
          await Future.wait(result.items.map((item) async {
        final urlResult =
            await Amplify.Storage.getUrl(key: item.key, options: getUrlOptions);
        return [item.key, urlResult.url];
      }));

      final Map<String, String> imageUrlMap = new Map.fromIterable(imageUrls, key: (v) => v[0], value: (v) => v[1]);

      // Enfin, nous envoyons simplement la liste des URL dans le flux afin qu'elle soit étudiée.
      imageUrlsController.add(imageUrlMap);
    
    // Si nous rencontrons une erreur, il nous suffit de l'imprimer.
    } on Exception catch (e) {
      print('Storage List error - $e');
    }
  }

  void getImageByS3Key(String s3key) async {
    try{
      final listOptions = S3ListOptions(accessLevel: StorageAccessLevel.protected);
      final getUrlOptions = GetUrlOptions(accessLevel: StorageAccessLevel.protected);
      final urlResult = await Amplify.Storage.getUrl(key: s3key, options: getUrlOptions);
      final String imageUrl = urlResult.url;

      imageUrlController.add(imageUrl);
    } on Exception catch (e) {
      print('Storage List error - $e');
    }
  }

  void getImagesByS3KeyList(List<String> s3keys) async {
    try {
      final getUrlOptions =
      GetUrlOptions(accessLevel: StorageAccessLevel.protected);
      final List<List<String>> imageUrls =
      await Future.wait(s3keys.map((item) async {
        final urlResult =
        await Amplify.Storage.getUrl(key: item, options: getUrlOptions);
        return [item, urlResult.url];
      }));

      final Map<String, String> imageUrlMap =
      new Map.fromIterable(imageUrls, key: (v) => v[0], value: (v) => v[1]);
      imageUrlsController.add(imageUrlMap);
    } on Exception catch (e) {
      print('getImagesByS3KeyList error - $e');
    }
  }
}