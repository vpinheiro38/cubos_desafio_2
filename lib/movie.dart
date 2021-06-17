class Movie {
  int id;
  String title;
  String releasedDate;
  String posterUrl;
  String overview;
  String voteAverage;
  bool favorite;

  Movie(this.id, this.title, this.releasedDate, this.posterUrl, this.overview, this.voteAverage, {this.favorite = false});

  Movie.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    title = json['title'] != null ? json['title'] : '--',
    releasedDate = json['release_date'] != null ? json['release_date'] : '----------',
    posterUrl = json['poster_path'] != null ? 'https://image.tmdb.org/t/p/w300${json['poster_path']}' : '',
    overview = json['overview'] != null ? json['overview'] : '--',
    voteAverage = (json['vote_average'] != null ? json['vote_average'] : 0).toString(),
    favorite = false;

  Map<String, dynamic> toMap() {
    return { 'id': id };
  }
}
