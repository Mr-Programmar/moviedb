import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmoviedb/model/movie.dart';

import '../service/movie_service.dart';

// Caches the provider, so new instances won't be created (a singleton)

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      headers: {
        // API key wasn't added in .env because there isn't much security risk for now
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYmJmMGI4MmU0ZTdkZTUyYzcyOTIxNjcyM2MzNGFhOSIsInN1YiI6IjY1NjFmMWZmZWQ5NmJjMDEwMTVlNTJiMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9SOLeZzHvYY94CyiKwMdkGkFCYifX_jomfcwqqmhBcs',
      },
    ),
  );
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  return throw UnimplementedError();
});

final movieServiceProvider = Provider<MovieService>((ref) {
  // Injecting dio dependency
  return MovieService(ref.read(dioProvider));
});

final getMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  return ref.read(movieServiceProvider).getMovies();
});
final getFavouriteMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  return ref.read(movieServiceProvider).getFavouriteMovies(
        ref.read(sharedPreferencesProvider).getStringList('favourites') ?? [],
      );
});
