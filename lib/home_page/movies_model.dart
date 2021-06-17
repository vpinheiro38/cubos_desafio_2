import 'package:cubos_desafio_2/api.dart';
import 'package:cubos_desafio_2/movie.dart';

class MoviesModel {
  final API api;
  late Future<List<Movie>> _movies;
  List<Movie> previousMovies = [];

  MoviesModel({this.api: const API()});

  Future<List<Movie>> get movies => _movies;

  fetchMovies(int page) {
    _movies = api.fetchMovies(page);
  }
}
