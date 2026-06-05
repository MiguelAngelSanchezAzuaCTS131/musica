import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {

  final List<String> favoriteAlbums = [];

  void addFavorite(String album) {

    favoriteAlbums.add(album);

    notifyListeners();
  }

  void removeFavorite(String album) {

    favoriteAlbums.remove(album);

    notifyListeners();
  }
}