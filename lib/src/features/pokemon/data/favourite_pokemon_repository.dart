import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' hide Reader;
import 'package:pokedex/src/config/hive_config.dart';
import 'package:pokedex/src/core/exceptions/exceptions.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';

/// Before this provider can be used, its value must have
/// been overriden in a [ProviderScope], or [ProviderContainer].
final favouritePokemonBoxProvider = Provider<PokemonBox>((ref) {
  throw UnimplementedError();
});

class FavouritePokemonRepository {
  final Reader read;

  const FavouritePokemonRepository(this.read);

  PokemonBox get _box => read(favouritePokemonBoxProvider);

  Stream<Either<AppException, PokemonList>> watchPokemonList() async* {
    try {
      yield Right(_box.values.toList());
      // ignore: no_leading_underscores_for_local_identifiers
      await for (var _ in _box.watch()) {
        yield Right(_box.values.toList());
      }
    } catch (e) {
      yield Left(AppException(statusMessage: '$e'));
    }
  }

  Future<Either<AppException, void>> savePokemon(Pokemon pokemon) async {
    try {
      unawaited(_box.put(pokemon.id, pokemon));
      return const Right(null);
    } catch (error) {
      return Left(AppException(statusMessage: "$error"));
    }
  }

  Future<Either<AppException, void>> deletePokemon(int id) async {
    try {
      unawaited(_box.delete(id));
      return const Right(null);
    } catch (error) {
      return Left(AppException(statusMessage: "$error"));
    }
  }
}

final favouritePokemonRepositoryProvider =
    Provider<FavouritePokemonRepository>((ref) {
  return FavouritePokemonRepository(ref.read);
});
