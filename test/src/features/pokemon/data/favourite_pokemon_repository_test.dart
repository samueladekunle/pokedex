import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/config/hive_config.dart';
import 'package:pokedex/src/core/exceptions/exceptions.dart';
import 'package:pokedex/src/features/pokemon/data/favourite_pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late PokemonBox box;
  late FavouritePokemonRepository repository;
  late Pokemon pokemon;

  setUp(() {
    box = PokemonBoxMock();
    when(() => box.isOpen).thenReturn(true);
    pokemon = const Pokemon.empty();
    final container = ProviderContainer(
      overrides: [
        favouritePokemonBoxProvider.overrideWithValue(box),
      ],
    );
    addTearDown(() => container.dispose());
    repository = container.read(favouritePokemonRepositoryProvider);
    registerFallbackValue(pokemon);
  });

  group(".watchPokemonList", () {
    test("Emits an empty list when box is empty", () async {
      when(() => box.values).thenAnswer((_) => []);
      final stream = repository.watchPokemonList();
      await expectLater(stream, emitsInOrder([]));
    });
  });

  group(".savePokemon", () {
    test('Saves a pokemon', () async {
      when(() => box.put(any(), any())).thenAnswer((_) => Future<void>.value());
      await repository.savePokemon(pokemon);
      verify(() => box.put(pokemon.id, pokemon)).called(1);
    });

    test('Returns an exception when box is not open', () async {
      when(() => box.isOpen).thenReturn(false);
      final either = repository.savePokemon(pokemon);
      expect(either, completion(isA<Left<AppException, void>>()));
    });
  });

  group('.deletePokemon', () {
    test('Deletes a pokemon', () async {
      when(() => box.delete(any())).thenAnswer((_) => Future<void>.value());
      await repository.deletePokemon(pokemon.id);
      verify(() => box.delete(pokemon.id)).called(1);
    });

    test('Returns an exception when box is not open', () async {
      when(() => box.isOpen).thenReturn(false);
      final either = repository.deletePokemon(pokemon.id);
      expect(either, completion(isA<Left<AppException, void>>()));
    });
  });
}
