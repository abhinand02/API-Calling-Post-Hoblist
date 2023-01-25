import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:login_and_home_page/Model/movies.dart';
import 'package:login_and_home_page/Services/base_url.dart';

class MovieServices {
  static Dio dio = DioBaseUrl.dio;

  static Future<List<Result>?> getMovies() async {
    try {
      var response = await dio.post('/api/movieList', data: {
        "category": "movies",
        "language": "kannada",
        "genre": "all",
        "sort": "voting"
      },);
      print('data');
      MovieList movieList = MovieList.fromJson(response.data);
      // (movieList.result[0] as Map<String,dynamic>) ['title'];
      // final result = movieList.result;
      DateTime releaseDate = DateTime.fromMillisecondsSinceEpoch(movieList.result[0].releasedDate * 1000);
      log(releaseDate.month.toString());
      return movieList.result;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
