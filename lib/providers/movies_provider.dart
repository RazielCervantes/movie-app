import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '8d738a15ac5ef13da7f2e4b534b9a786';
  String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'en-US';

  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;
  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _lenguage, 'page': '$page'});

    try {
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      return e.toString();
    }

    // var url = Uri.https(_baseUrl,endpoint,
    //     {'api_key': _apiKey, 'language': _lenguage, 'page': '$page'});

    // final response = await http.get(url);
    // return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nownowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovie = nownowPlayingResponse.results;
    notifyListeners();

    //opcion 1
    // var url = Uri.https(_baseUrl, '3/movie/now_playing',
    //     {'api_key': _apiKey, 'language': _lenguage, 'page': '1'});

    // try {
    //   await http.get(url).then((response) {
    //     final nownowPlayingResponse =
    //         NowPlayingResponse.fromJson(response.body);
    //     onDisplayMovie = nownowPlayingResponse.results;
    //     notifyListeners();
    //   });
    // } catch (e) {
    //   print(e);
    // }

    // final response = await http.get(url);

    // final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    // // print(nowPlayingResponse.results[0].title);

    // onDisplayMovie = nowPlayingResponse.results;

    // notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularMovies.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();

    // opcion 2
    // var url = Uri.https(_baseUrl, '3/movie/popular',
    //     {'api_key': _apiKey, 'language': _lenguage, 'page': '1'});

    // final response = await http.get(url);

    // final popularResponse = PopularMovies.fromJson(response.body);

    // popularMovies = [...popularMovies, ...popularResponse.results];

    // notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    print('pidiendo informacion al servidor...');
    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditResponse = CastResponse.fromJson(jsonData);

    moviesCast[movieId] = creditResponse.cast;

    return creditResponse.cast;
  }

  Future<List<Movie>> getMovieSearch(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _lenguage, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Tenemos valor a buscar: $value');
      final results = await this.getMovieSearch(value);
      this._suggestionStreamController.add(results);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
