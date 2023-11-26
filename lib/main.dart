import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmoviedb/screens/favorite_movies_screen.dart';
import 'package:tmoviedb/screens/movie_list_widget.dart';
import 'package:tmoviedb/screens/tmdb_home.dart';
import 'package:tmoviedb/service/movie_service.dart';
import 'package:tmoviedb/providers/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB Demo',
      theme: ThemeData(),
      home: const TmdbHome(),
    );
  }
}


