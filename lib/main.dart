import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/src/config/hive_config.dart';
import 'package:pokedex/src/features/pokemon/data/favourite_pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/src/features/pokemon/domain/resource.dart';

import 'src/app.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();

    Hive.registerAdapter(ResourceAdapter());
    Hive.registerAdapter(PokemonAdapter());
    Hive.registerAdapter(PokemonStatAdapter());
    Hive.registerAdapter(PokemonTypeAdapter());

    final favouritePokemonBox =
        await Hive.openBox<Pokemon>(HiveBoxName.favouritePokemon);

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
    };

    runApp(ProviderScope(
      overrides: [
        favouritePokemonBoxProvider.overrideWithValue(favouritePokemonBox),
      ],
      child: const PokedexApp(),
    ));
  }, (error, stack) {
    //
  });
}
