import 'package:cubos_desafio_2/container_background.dart';
import 'package:cubos_desafio_2/details_page/detail_movie_viewmodel.dart';
import 'package:cubos_desafio_2/movie.dart';
import 'package:flutter/material.dart';

class DetailMovieView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailMovieViewState();
}

class _DetailMovieViewState extends State<DetailMovieView> {
  final viewModel = DetailMovieViewModel();

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    viewModel.loadIsFavoriteMovie(movie);

    return Scaffold(
      body: ContainerBackground(
        Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildPoster(context, movie),
                  _buildTitle(movie),
                  _buildDetails(movie),
                  _buildOverview(movie.overview)
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  _buildPoster(BuildContext context, Movie movie) {
    final height = (440 * MediaQuery.of(context).size.width) / 300;

    return Stack(
      children: [
        Container(
          decoration: _posterDecoration(movie.posterUrl),
          height: height,
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: const ShapeDecoration(
                color: Color.fromARGB(100, 255, 255, 255),
                shape: CircleBorder(),
              ),
              child: IconButton(
                iconSize: 35,
                icon: const Icon(Icons.arrow_left),
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _posterDecoration(String posterUrl) {
    if (posterUrl == '') {
      return BoxDecoration();
    } else {
      return BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(posterUrl),
            fit: BoxFit.fill
        )
      );
    }
  }

  _buildTitle(Movie movie) {
    return Container(
      color: Color.fromARGB(100, 0, 0, 0),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Text(
        movie.title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
    );
  }

  _buildDetails(Movie movie) {
    return Container (
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildReleasedDate(movie.releasedDate)),
          Expanded(child: _buildScore(movie.voteAverage)),
          Expanded(child: StreamBuilder<bool>(
            stream: viewModel.favoriteStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasData) {
                return _buildFavoriteButton(snapshot.data ?? false, movie);
              }

              return CircularProgressIndicator();
            },
          ))
        ],
      ),
    );
  }

  _buildReleasedDate(String date) {
    final day = date.substring(8, 10);
    final month = date.substring(5, 7);
    final year = date.substring(0, 4);

    return Column(
      children: [
        Text(
          '$day/$month',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        Text(
          '$year',
          style: TextStyle(fontSize: 20, color: Colors.white),
        )
      ],
    );
  }

  _buildScore(String score) {
    return Column(
      children: [
        Text(
          '$score',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        Text(
          'Score',
          style: TextStyle(fontSize: 20, color: Colors.white),
        )
      ],
    );
  }
  
  _buildFavoriteButton(bool favorite, Movie movie) {
    return GestureDetector(
      onTap: () {
        setState(() {
          favorite ? viewModel.unfavoriteMovie(movie) : viewModel.favoriteMovie(movie);
        });
      },
      child: Icon(
          Icons.star,
          color: favorite ? Colors.white : Color.fromARGB(50, 255, 255, 255),
          size: 40),
    );
  }

  _buildOverview(String overview) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Text(
        overview,
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }
}