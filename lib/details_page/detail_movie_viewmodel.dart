import 'dart:async';

import 'package:cubos_desafio_2/details_page/detail_movie_model.dart';
import 'package:cubos_desafio_2/movie.dart';

class DetailMovieViewModel {
  final FavoritesModel model = FavoritesModel();
  final StreamController<bool> favoriteStreamController = StreamController();

  loadIsFavoriteMovie(Movie movie) {
    model.isFavoriteMovie(movie).then((value) => favoriteStreamController.add(value));
  }

  void favoriteMovie(Movie movie) {
    model.favoriteMovie(movie);
    loadIsFavoriteMovie(movie);
  }

  void unfavoriteMovie(Movie movie) {
    model.unfavoriteMovie(movie);
    loadIsFavoriteMovie(movie);
  }
}