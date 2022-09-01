import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/config/hive_config.dart';
import 'package:pokedex/src/core/api/rest_api_repository.dart';
import 'package:pokedex/src/features/pokemon/data/favourite_pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/data/poke_api_respository.dart';

class PokemonBoxMock extends Mock implements PokemonBox {}

class RestAPIRepositoryMock extends Mock implements RestAPIRepository {}

class FavouritePokemonRepositoryMock extends Mock
    implements FavouritePokemonRepository {}

class PokeAPIRepositoryMock extends Mock implements PokeAPIRepository {}
