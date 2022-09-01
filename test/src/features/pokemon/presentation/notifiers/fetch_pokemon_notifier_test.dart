import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/features/pokemon/data/poke_api_respository.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_notifier.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_state.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late PokeAPIRepository pokeAPIRepository;
  late FetchPokemonNotifier fetchPokemonNotifier;

  setUp(() {
    pokeAPIRepository = PokeAPIRepositoryMock();
    final container = ProviderContainer(
      overrides: [
        pokeAPIRepositoryProvider.overrideWithValue(pokeAPIRepository),
      ],
    );
    fetchPokemonNotifier =
        container.read(fetchPokemonNotifierProvider.notifier);
  });

  group('.fetchPokemon', () {
    test('Fetch a single pokemon', () async {
      when(() => pokeAPIRepository.fetchPokemon(any())).thenAnswer(
          (invocation) => Future.value(Either.of(const Pokemon.empty())));
      await fetchPokemonNotifier.fetchPokemon(1);
      expect(fetchPokemonNotifier.debugState.status.isData, true);
    });
  });

  group('.fetchPokemonList', () {
    test('Fetch a list of pokemons', () async {
      when(() => pokeAPIRepository.fetchPokemonList(any(), any())).thenAnswer(
        (invocation) async =>
            Right(List.generate(10, (index) => const Pokemon.empty())),
      );
      await fetchPokemonNotifier.fetchPokemonList();
      expect(fetchPokemonNotifier.debugState.pokemonList.length, 10);
    });
  });

  group('.fetchNextPokemonList', () {
    test('Fetch next pokemon list', () async {
      when(() => pokeAPIRepository.fetchPokemonList(any(), any())).thenAnswer(
        (invocation) async =>
            Right(List.generate(10, (index) => const Pokemon.empty())),
      );
      await fetchPokemonNotifier.fetchNextPokemonList();
      expect(fetchPokemonNotifier.debugState.pokemonList.length, 10);
    });
  });
}
