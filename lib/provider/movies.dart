import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../models/movie.dart';
import 'package:flutter/material.dart';

class MoviesProvider with ChangeNotifier {
  final dataBaseReference = FirebaseDatabase(
          databaseURL: 'https://movie-app-87aoj-default-rtdb.firebaseio.com/')
      .reference();

  Map<String, Movie> _items = <String, Movie>{};

  int get count {
    return _items.length;
  }

  Future<void> listAll() async {
    final snapshot = await dataBaseReference.child("movies").get();
    if (snapshot.exists && snapshot != null) {
      snapshot.children.forEach((element) {
        Movie m = Movie(
            id: element.key,
            rating: double.parse(element.child("rating").value.toString()),
            review: element.child("review").value.toString(),
            title: element.child("title").value.toString(),
            imageUrl: element.child("imageUrl").value.toString());
        _items.putIfAbsent(m.id!, () => m);
      });
      notifyListeners();
    }
  }

  Movie? byIndex(int i) {
    if (_items.isNotEmpty) {
      return _items.values.elementAt(i);
    }
    return null;
  }

  Future<void> put(Movie movie) async {
    if (movie == null) {
      return;
    }

    if (movie.id != null &&
        movie.id!.trim().isNotEmpty &&
        _items.containsKey(movie.id)) {
      dataBaseReference.child("movies").child(movie.id!).update({
        'id': movie.id,
        'title': movie.title,
        'imageUrl': movie.imageUrl,
        'rating': movie.rating,
        'review': movie.review
      });
      _items.update(movie.id!, (_) => movie);
    } else {
      String id = const Uuid().v4();

      dataBaseReference.child("movies").child(id).set({
        'id': id,
        'title': movie.title,
        'imageUrl': movie.imageUrl,
        'rating': movie.rating,
        'review': movie.review
      });

      _items.putIfAbsent(
          id.toString(),
          () => Movie(
              id: id,
              title: movie.title,
              imageUrl: movie.imageUrl,
              rating: movie.rating,
              review: movie.review));
    }
    notifyListeners();
  }

  Future<void> remove(String id) async {
    if (id.isNotEmpty) {
      await dataBaseReference.child("movies").child(id).remove();
      _items.removeWhere((key, value) => key == id);
      notifyListeners();
    }
  }
}
