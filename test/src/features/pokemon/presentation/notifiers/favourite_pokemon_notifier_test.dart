import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/core/exceptions/exceptions.dart';
import 'package:pokedex/src/features/pokemon/data/favourite_pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/favourite_pokemon_notifier.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_state.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late FavouritePokemonRepository favouritePokemonRepository;
  late FavouritePokemonNotifier favouritePokemonNotifier;
  late Pokemon pokemon;

  setUp(() {
    favouritePokemonRepository = FavouritePokemonRepositoryMock();
    final container = ProviderContainer(
      overrides: [
        favouritePokemonRepositoryProvider
            .overrideWithValue(favouritePokemonRepository),
      ],
    );
    favouritePokemonNotifier =
        container.read(favouritePokemonNotifierProvider.notifier);
    pokemon = const Pokemon.empty();
    registerFallbackValue(pokemon);
  });

  group('.watchPokemonList', () {
    test('Fetch list of favourite pokemons', () async {
      when(() => favouritePokemonRepository.watchPokemonList())
          .thenAnswer((invocation) => Stream.value(const Right([])));
      await favouritePokemonNotifier.watchPokemonList();

      expect(
        favouritePokemonNotifier.debugState,
        const FetchPokemonState(
            pokemon: Pokemon.empty(),
            pokemonList: [],
            status: FetchPokemonStatus.data),
      );
    });
  });

  group('.savePokemon', () {
    test('Save pokemon', () async {
      when(() => favouritePokemonRepository.savePokemon(any())).thenAnswer(
          (invocation) => Future.value(Either<AppException, void>.of(null)));
      await favouritePokemonNotifier.savePokemon(pokemon);
      expect(!favouritePokemonNotifier.debugState.status.isError, true);
    });
  });

  group('.deletePokemon', () {
    test('Delete pokemon', () async {
      when(() => favouritePokemonRepository.deletePokemon(any())).thenAnswer(
          (invocation) => Future.value(Either<AppException, void>.of(null)));
      await favouritePokemonNotifier.deletePokemn(pokemon.id);
      expect(!favouritePokemonNotifier.debugState.status.isError, true);
    });
  });
}
