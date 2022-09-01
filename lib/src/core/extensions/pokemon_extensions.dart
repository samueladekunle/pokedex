import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';

extension PokemonX on Pokemon {
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

  String get pokedexId => id.toString().padLeft(3, '0');

  double get bmi {
    if (height == 0 || weight == 0) return 0;
    return (weight / pow(height, 2));
  }

  bool get isEmpty => this == const Pokemon.empty();

  String get baseType {
    return types.isNotEmpty ? types[0].type.name : "";
  }

  double get averagePower {
    if (stats.isEmpty) return 0;
    return stats.map((stat) => stat.baseStat).reduce((a, b) => a + b) /
        stats.length;
  }

  Color get color {
    switch (baseType) {
      case "normal":
        return Colors.green;
      case "fire":
        return Colors.red;
      case "water":
        return Colors.blue;
      case "electric":
        return Colors.yellow;
      case "grass":
        return Colors.green;
      case "ice":
        return Colors.cyan;
      case "fighting":
        return Colors.red;
      case "poison":
        return Colors.purple;
      case "ground":
        return Colors.brown;
      case "flying":
        return Colors.blue;
      case "psychic":
        return Colors.pink;
      case "bug":
        return Colors.yellow;
      case "rock":
        return Colors.brown;
      case "ghost":
        return Colors.purple;
      case "dragon":
        return Colors.purple;
      case "dark":
        return Colors.purple;
      case "steel":
        return Colors.grey;
      case "fairy":
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }
}

extension PokemonListX on PokemonList {
  bool isFavourite(Pokemon pokemon) =>
      any((favourite) => favourite.id == pokemon.id);
}
