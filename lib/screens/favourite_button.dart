import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmoviedb/service/movie_service.dart';
import 'package:tmoviedb/providers/providers.dart';

class FavouriteButton extends ConsumerWidget {
  const FavouriteButton({
    required this.favouritesNotifier,
    required this.movieID,
    super.key,
  });

  final ValueNotifier<List<String>> favouritesNotifier;
  final String movieID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);

    return IconButton(
      onPressed: () {
        // Create a copy instead of getting the reference
        final favourites = [...favouritesNotifier.value];

        favourites.contains(movieID)
            ? favourites.removeWhere((id) => id == movieID)
            // Using insert so the favourite will show up first in the list
            // instead of add which adds at the end of the list
            : favourites.insert(0, movieID);

        favouritesNotifier.value = favourites;

        sharedPreferences.setStringList(
          'favourites',
          favourites,
        );

        ref.invalidate(getFavouriteMoviesProvider);
      },
      icon: Icon(
        favouritesNotifier.value.contains(movieID)
            ? Icons.favorite
            : Icons.favorite_outline,
      ),
    );
  }
}
