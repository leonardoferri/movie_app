import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/movie_initialize.dart';
import 'package:uuid/uuid.dart';

import '../models/movie.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class MoviesProvider with ChangeNotifier {
  static const _baseUrl = 'https://movie-app-fc645-default-rtdb.firebaseio.com';
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

  Future<void> put(Movie movie) async {
    if (movie == null) {
      return;
    }

    print(movie.toJson());

    FirebaseFirestore.instance.collection("movie_reviews").add(movie.toJson());

    //final id = json.decode(response.id);
    //print("id response: " + id);

    if (movie.id != null &&
        movie.id!.trim().isNotEmpty &&
        _items.containsKey(movie.id)) {
      _items.update(movie.id!, (_) => movie);
    } else {
      //http.post('$_baseUrl/movies.json', body: {});
      // final response = await http.post(
      //   Uri.parse("$_baseUrl/movies"),
      //   body: movie.toJson(),
      // );

      //final id = json.decode(response.body)['name'];
      //https://img.elo7.com.br/product/original/264E932/big-poster-filme-blade-runner-1982-lo002-tamanho-90x60-cm-blade-runner-1982.jpg

      // add
      // _items.putIfAbsent(
      //     id,
      //     () => Movie(
      //         id: id,
      //         title: movie.title,
      //         imageUrl: movie.imageUrl,
      //         rating: movie.rating,
      //         review: movie.review));
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
