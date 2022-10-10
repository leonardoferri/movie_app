import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:uuid/uuid.dart';

import '../models/movie.dart';
import '../provider/movies.dart';

class MovieForm extends StatefulWidget {
  @override
  State<MovieForm> createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  Text labelMovieTitle = const Text("Novo Filme");
  double rate = 0;
  double initialRating = 3;

  void _loadFormData(Movie movie) {
    if (movie != null) {
      _formData['id'] = movie.id!;
      _formData['title'] = movie.title;
      _formData['rating'] = movie.rating.toString();
      _formData['review'] = movie.review;
      _formData['imageUrl'] = movie.imageUrl!;

      labelMovieTitle = Text(movie.title);
      initialRating = movie.rating;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

//    if (ModalRoute.of(context)!.settings.name!.contains('alter')) {
//      final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
//      _loadFormData(movie);
//    }

    if (ModalRoute.of(context)!.settings.arguments != null) {
      final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
      _loadFormData(movie);
    }

    _formData['rating'] = initialRating.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: labelMovieTitle, actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                final isValid = _form.currentState!.validate();

                if (isValid) {
                  _form.currentState!.save();
                  String id = Uuid().v4();
                  Provider.of<MoviesProvider>(context, listen: false).put(
                    Movie(
                        id: _formData['id'],
                        title: _formData['title']!,
                        rating: double.parse(_formData['rating']!),
                        review: _formData['review']!,
                        imageUrl: _formData['imageUrl']),
                  );
                  Navigator.of(context).pop();
                }
              })
        ]),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _form,
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: _formData['title'],
                  decoration:
                      const InputDecoration(labelText: 'Título do filme'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira o título do filme';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['title'] = value!,
                ),
                TextFormField(
                    initialValue: _formData['imageUrl'],
                    decoration: const InputDecoration(labelText: 'URL pôster'),
                    onSaved: (value) => _formData['imageUrl'] = value!),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Sua nota para o filme'),
                ),
                RatingBar.builder(
                  initialRating: initialRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    //rate = rating;
                    _formData['rating'] = rating.toString();
                  },
                  //onSaved: (value) => _formData['rating'] = value!
                ),
                //TextFormField(
                //  initialValue: _formData['rating'],
                //  decoration: const InputDecoration(labelText: 'Nota'),
                //  validator: (value) {
                //    if (value == null || value.isEmpty) {
                //      return 'Por favor insira uma nota para o filme';
                //    }
                //    if (double.parse(value) < 1 || double.parse(value) > 5) {
                //      return 'Por favor insira uma nota entre 1 a 5';
                //    }
                //    return null;
                //  },
                //  onSaved: (value) => _formData['rating'] = value!,
                //),
                TextFormField(
                  maxLines: null,
                  initialValue: _formData['review'],
                  decoration: const InputDecoration(labelText: 'Avaliação'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira uma review para o filme';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['review'] = value!,
                ),
              ]),
            )));
  }
}
