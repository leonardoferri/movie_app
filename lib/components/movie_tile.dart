import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../provider/movies.dart';
import '../routes/app_routes.dart';

class _ReviewDescription extends StatelessWidget {
  const _ReviewDescription(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              RatingBar.builder(
                itemSize: 25,
                ignoreGestures: true,
                initialRating: movie.rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Text(
                movie.review.trim().length > 196
                    ? '${movie.review.trim().substring(0, 196)}...'
                    : movie.review,
                maxLines: 7,
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black87,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    String poster = movie.imageUrl == null || movie.imageUrl!.trim().isEmpty
        ? "https://ae01.alicdn.com/kf/HTB1knsDhDTI8KJjSsphq6AFppXaf/V-deo-cl-ssico-diretor-cena-clapperboard-filmes-ard-sia-corte-a-o-prop.jpg_Q90.jpg_.webp"
        : movie.imageUrl!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(poster),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0, 0.0),
                child: _ReviewDescription(movie),
              ),
            ),
            Column(
              children: [
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
          ],
        ),
      ),
    );
  }
}
