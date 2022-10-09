import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/provider/movies.dart';
import 'package:movie_app/routes/app_routes.dart';
import 'package:provider/provider.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile(this.movie);

  @override
  Widget build(BuildContext context) {
    final poster = movie.imageUrl == null || movie.imageUrl!.isEmpty
        ? const CircleAvatar(child: Icon(Icons.movie))
        : CircleAvatar(backgroundImage: NetworkImage(movie.imageUrl!));
    return ListTile(
      leading: poster,
      title: Text(movie.title),
      subtitle: Text("${movie.rating}/5"),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.MOVIE_FORM, arguments: movie);
                },
                icon: const Icon(Icons.edit),
                color: Colors.black),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir resenha'),
                    content: const Text('Deseja mesmo excluir a resenha?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed) {
                    Provider.of<MoviesProvider>(context, listen: false)
                        .remove(movie.id!);
                  }
                });
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
