import 'package:flutter/material.dart';
import 'package:movie_app/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../components/movie_tile.dart';
import '../provider/movies.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MoviesProvider movies = Provider.of(context);
    movies.listAll();
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Filmes'), actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.MOVIE_FORM);
            },
            icon: const Icon(Icons.add)),
      ]),
      body: ListView.builder(
        itemCount: movies.count,
        itemBuilder: ((context, index) =>
            CustomListItem(movies.byIndex(index)!)),
      ),
    );
  }
}
