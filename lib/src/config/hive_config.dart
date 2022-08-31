import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';

typedef PokemonBox = Box<Pokemon>;

class HiveTypeId {
  const HiveTypeId._();

  ///
  static const resource = 0;

  ///
  static const pokemon = 1;

  ///
  static const pokemonStat = 2;

  ///
  static const pokemonType = 3;
}

class HiveBoxName {
  const HiveBoxName._();

  ///
  static const favouritePokemon = 'FAVOURITE_POKEMON';
}
