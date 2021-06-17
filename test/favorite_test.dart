import 'package:cubos_desafio_2/details_page/detail_movie_model.dart';
import 'package:cubos_desafio_2/internal_storage.dart';
import 'package:cubos_desafio_2/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FavoritesModel should handle favorite movies', (WidgetTester tester) async {
    final model = FavoritesModel(internalStorageAdapter: MockStorage());
    final movie = Movie(0, 'title', '2021-06-10', '', 'overview', '0.0');

    expect(model.isFavoriteMovie(movie), completion(isFalse));
    model.favoriteMovie(movie);
    expect(model.isFavoriteMovie(movie), completion(isTrue));
    model.unfavoriteMovie(movie);
    expect(model.isFavoriteMovie(movie), completion(isFalse));
  });
}

class MockStorage extends InternalStorage {
  List<int> favoriteMovies = [];

  @override
  favoriteMovie(int movieId) {
    favoriteMovies.add(movieId);
  }

  @override
  Future<bool> isMovieFavorite(int movieId) {
    final indexOfFavorite = favoriteMovies.indexOf(movieId);
    return Future.value(indexOfFavorite != -1);
  }

  @override
  unfavoriteMovie(int movieId) {
    favoriteMovies.remove(movieId);
  }

}
