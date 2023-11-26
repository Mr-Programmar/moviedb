import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmoviedb/providers/providers.dart';
import 'package:tmoviedb/screens/movie_list_widget.dart';
import 'package:tmoviedb/service/movie_service.dart';

class FavoriteMoviesScreen extends HookConsumerWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(
      getFavouriteMoviesProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: moviesAsyncValue.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(
              child: Text(
                "You've favourited no movies yet",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieListWidget(
                movie: movie,
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
