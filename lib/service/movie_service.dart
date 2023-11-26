import 'package:dio/dio.dart';
import 'package:tmoviedb/model/movie.dart';

class MovieService {
  MovieService(this.dio);
  Dio dio;
  Future<List<Movie>> getMovies() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        'https://api.themoviedb.org/3/discover/movie',
      );

      final moviesJson =
          (response.data?['results'] as List).cast<Map<String, dynamic>>();

      return moviesJson.map(Movie.fromJson).toList();
    } catch (error) {
      // Throwing String instead of a custom class extending Exception
      // when checking for dio error to shorten project code
      // [error] can be logged using some server side crashlytics
      throw "Couldn't load movies";
    }
  }

  Future<List<Movie>> getFavouriteMovies(List<String> ids) async {
    try {
      // Using a loop to fetch movies is very bad
      // but the API had no way to get movies by list of ids
      // and the get favourites from the API couldn't be used
      // because of the requirements to fetch favourites from local storage
      final movies = <Movie>[];
      for (final id in ids) {
        final response = await dio.get<Map<String, dynamic>>(
          'https://api.themoviedb.org/3/movie/$id',
        );

        if (response.data != null) {
          movies.add(Movie.fromJson(response.data!));
        }
      }
      return movies;
    } catch (error) {
      throw "Couldn't load movies, Something Wrong";
    }
  }
}
