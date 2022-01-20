import 'dart:async';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

class StorageService {
  // Nous commençons par initialiser un contrôleur StreamController qui va gérer les URL des images récupérées dans Amazon S3.
  final imageUrlsController = StreamController<List<String>>();

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
      final List<String> imageUrls =
          await Future.wait(result.items.map((item) async {
            ///TODO: Get key and and pass it into the controller
        final urlResult =
            await Amplify.Storage.getUrl(key: item.key, options: getUrlOptions);
        return urlResult.url;
      }));

      // Enfin, nous envoyons simplement la liste des URL dans le flux afin qu'elle soit étudiée.
      imageUrlsController.add(imageUrls);
    
    // Si nous rencontrons une erreur, il nous suffit de l'imprimer.
    } on Exception catch (e) {
      print('Storage List error - $e');
    }
  }
}