import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster(
    this.posterPath,
  );

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      height: 450,
      width: 300,
      child: Image.network(
        'https://image.tmdb.org/t/p/w300_and_h450_bestv2$posterPath',
        fit: BoxFit.cover,
        // width: 300,
        // height: 450,
      ),
    );
  }
}
