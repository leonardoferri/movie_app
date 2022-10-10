import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.dart';
import 'package:movie_app/routes/app_routes.dart';
import 'package:movie_app/screens/movie_form.dart';
import 'package:movie_app/screens/movie_list.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MoviesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.HOME: (_) => const MovieList(),
          AppRoutes.MOVIE_FORM: (_) => MovieForm()
        },
      ),
    );
  }
}
