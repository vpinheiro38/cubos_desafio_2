abstract class InternalStorage {
  favoriteMovie(int movieId);
  unfavoriteMovie(int movieId);
  Future<bool> isMovieFavorite(int movieId);
}