import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/movie_initialize.dart';
import 'package:uuid/uuid.dart';

import '../models/movie.dart';
import 'package:flutter/material.dart';

class MoviesProvider with ChangeNotifier {
  final Map<String, Movie> _items = {...MOVIE_INITIALIZE};

  List<Movie> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Movie? byIndex(int i) {
    if (_items.isNotEmpty) {
      return _items.values.elementAt(i);
    }
    return null;
  }

  void put(Movie movie) {
    if (movie == null) {
      return;
    }

    if (movie.id != null &&
        movie.id!.trim().isNotEmpty &&
        _items.containsKey(movie.id)) {
      _items.update(movie.id!, (_) => movie);
    } else {
      final id = const Uuid().v4();

      // add
      _items.putIfAbsent(
          id,
          () => Movie(
              id: id,
              title: movie.title,
              imageUrl: movie.imageUrl,
              rating: movie.rating,
              review: movie.review));
    }

    notifyListeners();
  }

  void remove(String id) {
    if (id.isNotEmpty) {
      _items.remove(id);
      notifyListeners();
    }
  }
}
