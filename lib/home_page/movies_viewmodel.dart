import 'dart:async';

import 'package:cubos_desafio_2/home_page/movies_model.dart';

import '../movie.dart';

class MoviesViewModel {
  final model = MoviesModel();
  final StreamController<List<Movie>> moviesStreamController = StreamController();

  int moviesPage = 1;

  Future<List<Movie>> get movies => model.movies;

  loadMovies(bool reset) {
    if (reset)
      moviesPage = 1;

    model.fetchMovies(moviesPage);
    movies.then((value) {
      value.forEach((element) => model.previousMovies.add(element));
      moviesStreamController.add(model.previousMovies);
    });

    moviesPage++;
  }
}