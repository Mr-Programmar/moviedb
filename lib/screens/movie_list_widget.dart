import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tmoviedb/model/movie.dart';
import 'package:tmoviedb/screens/favourite_button.dart';
import 'package:tmoviedb/screens/movie_poster_custom_widget.dart';

class MovieListWidget extends ConsumerWidget {
  const MovieListWidget({
    required this.movie,
    this.favouritesNotifier,
    super.key,
  });

  final Movie movie;
  final ValueNotifier<List<String>>? favouritesNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoviePoster(movie.posterPath),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            movie.overview,
                            style: const TextStyle(
                              fontSize: 15.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            DateFormat('dd / MM / yyyy')
                                .format(movie.releaseDate),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (favouritesNotifier != null)
                    FavouriteButton(
                      favouritesNotifier: favouritesNotifier!,
                      movieID: movie.id,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
