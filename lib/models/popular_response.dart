// To parse this JSON data, do
//
//     final popularMovies = popularMoviesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'movie.dart';

// PopularMovies popularMoviesFromMap(String str) =>
//     PopularMovies.fromMap(json.decode(str));

// String popularMoviesToMap(PopularMovies data) => json.encode(data.toMap());

class PopularMovies {
  PopularMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  factory PopularMovies.fromJson(String str) =>
      PopularMovies.fromMap(json.decode(str));

  factory PopularMovies.fromMap(Map<String, dynamic> json) => PopularMovies(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  // Map<String, dynamic> toMap() => {
  //     "page": page,
  //     "results": List<dynamic>.from(results.map((x) => x.toMap())),
  //     "total_pages": totalPages,
  //     "total_results": totalResults,
  // };
}

// class Movie {
//     Movie({
//         required this.adult,
//         required this.backdropPath,
//         required this.genreIds,
//         required this.id,
//         required this.originalLanguage,
//         required this.originalTitle,
//         required this.overview,
//         required this.popularity,
//         required this.posterPath,
//         required this.releaseDate,
//         required this.title,
//         required this.video,
//         required this.voteAverage,
//         required this.voteCount,
//     });

//     final bool adult;
//     final String backdropPath;
//     final List<int> genreIds;
//     final int id;
//     final OriginalLanguage originalLanguage;
//     final String originalTitle;
//     final String overview;
//     final double popularity;
//     final String posterPath;
//     final DateTime releaseDate;
//     final String title;
//     final bool video;
//     final double voteAverage;
//     final int voteCount;

//     factory Movie.fromMap(Map<String, dynamic> json) => Movie(
//         adult: json["adult"],
//         backdropPath: json["backdrop_path"],
//         genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
//         id: json["id"],
//         originalLanguage: originalLanguageValues.map[json["original_language"]],
//         originalTitle: json["original_title"],
//         overview: json["overview"],
//         popularity: json["popularity"].toDouble(),
//         posterPath: json["poster_path"],
//         releaseDate: DateTime.parse(json["release_date"]),
//         title: json["title"],
//         video: json["video"],
//         voteAverage: json["vote_average"].toDouble(),
//         voteCount: json["vote_count"],
//     );

//     Map<String, dynamic> toMap() => {
//         "adult": adult,
//         "backdrop_path": backdropPath,
//         "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
//         "id": id,
//         "original_language": originalLanguageValues.reverse[originalLanguage],
//         "original_title": originalTitle,
//         "overview": overview,
//         "popularity": popularity,
//         "poster_path": posterPath,
//         "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
//         "title": title,
//         "video": video,
//         "vote_average": voteAverage,
//         "vote_count": voteCount,
//     };
// }

// enum OriginalLanguage { EN, TE, JA, FR }

// final originalLanguageValues = EnumValues({
//     "en": OriginalLanguage.EN,
//     "fr": OriginalLanguage.FR,
//     "ja": OriginalLanguage.JA,
//     "te": OriginalLanguage.TE
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
