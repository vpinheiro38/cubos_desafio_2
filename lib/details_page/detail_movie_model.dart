import 'package:cubos_desafio_2/internal_storage.dart';
import 'package:cubos_desafio_2/movie.dart';
import 'package:cubos_desafio_2/sql_adapter.dart';

class FavoritesModel {
  final InternalStorage internalStorage;

  FavoritesModel({InternalStorage? internalStorageAdapter})
    : internalStorage = internalStorageAdapter ?? SQLAdapter();

  Future<bool> isFavoriteMovie(Movie movie) {
    return internalStorage.isMovieFavorite(movie.id);
  }

  void favoriteMovie(Movie movie) {
    internalStorage.favoriteMovie(movie.id);
  }

  void unfavoriteMovie(Movie movie) {
    internalStorage.unfavoriteMovie(movie.id);
  }
}