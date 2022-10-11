// To parse this JSON data, do
//
//     final castResponse = castResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CastResponse {
  CastResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  final int id;
  final List<Cast> cast;
  final List<Cast> crew;

  factory CastResponse.fromJson(String str) =>
      CastResponse.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory CastResponse.fromMap(Map<String, dynamic> json) => CastResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
      );

  // Map<String, dynamic> toMap() => {
  //     "id": id,
  //     "cast": List<dynamic>.from(cast.map((x) => x.toMap())),
  //     "crew": List<dynamic>.from(crew.map((x) => x.toMap())),
  // };
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String creditId;
  final int? order;
  final String? department;
  final String? job;

  get fullProfilePath {
    if (this.profilePath != null)
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        castId: json["cast_id"] == null ? null : json["cast_id"],
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"],
        order: json["order"] == null ? null : json["order"],
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
      );

  // Map<String, dynamic> toMap() => {
  //     "adult": adult,
  //     "gender": gender,
  //     "id": id,
  //     "known_for_department": departmentValues.reverse[knownForDepartment],
  //     "name": name,
  //     "original_name": originalName,
  //     "popularity": popularity,
  //     "profile_path": profilePath == null ? null : profilePath,
  //     "cast_id": castId == null ? null : castId,
  //     "character": character == null ? null : character,
  //     "credit_id": creditId,
  //     "order": order == null ? null : order,
  //     "department": department == null ? null : departmentValues.reverse[department],
  //     "job": job == null ? null : job,
  // };
}

// en

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
