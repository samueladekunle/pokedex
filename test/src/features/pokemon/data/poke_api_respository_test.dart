import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/core/api/rest_api_repository.dart';
import 'package:pokedex/src/features/pokemon/data/poke_api_respository.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late RestAPIRepository restAPIRepository;
  late PokeAPIRepository pokeAPIRepository;

  setUp(() {
    restAPIRepository = RestAPIRepositoryMock();
    final container = ProviderContainer(
      overrides: [
        restAPIRepositoryProvider.overrideWithValue(restAPIRepository),
      ],
    );
    addTearDown(() => container.dispose());
    pokeAPIRepository = container.read(pokeAPIRepositoryProvider);
  });

  group('.fetchPokemonList', () {
    test('Fetch list of pokemons', () async {
      final string = File('test/mocks/pokemon_list.json').readAsStringSync();
      final json = jsonDecode(string);
      when(() => restAPIRepository.get(any()))
          .thenAnswer((invocation) => Future.value(Either.of(json)));
      final either = await pokeAPIRepository.fetchPokemonList(1, 24);
      expect(either.isRight(), true);
    });
  });

  group('.fetchPokemon', () {
    test('Fetch pokemon data', () async {
      final json = {
        'name': 'bulbasaur',
        'url': 'https://pokeapi.co/api/v2/pokemon/1/'
      };
      when(() => restAPIRepository.get(any()))
          .thenAnswer((_) => Future.value(Either.of(json)));
      final either = await pokeAPIRepository.fetchPokemon(1);
      expect(either.isRight(), true);
    });
  });
}
