import 'details_page/detail_movie_view.dart';
import 'home_page/movies_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MoviesView(),
      routes: {
        'details': (context) => DetailMovieView()
      },
    );
  }
}