import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmoviedb/providers/providers.dart';
import 'package:tmoviedb/screens/favorite_movies_screen.dart';

import 'movie_list_widget.dart';
import '../service/movie_service.dart';

class TmdbHome extends HookConsumerWidget {
  const TmdbHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(getMoviesProvider);
    final sharedPreferences = ref.watch(sharedPreferencesProvider);

    final favouritesNotifier =
        useState(sharedPreferences.getStringList('favourites') ?? []);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB Home'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const FavoriteMoviesScreen(),
                ),
              );
            },
            icon: const Icon(Icons.favorite_border_outlined),
            label: const Text('Favourites'),
          ),
        ],
      ),
      body: moviesAsyncValue.when(
        data: (movies) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieListWidget(
                movie: movie,
                favouritesNotifier: favouritesNotifier,
              );
            },
            itemCount: movies.length,
          );
        },
        error: (error, stacktrace) => Text('$error'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
