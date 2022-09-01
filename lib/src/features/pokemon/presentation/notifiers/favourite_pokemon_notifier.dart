import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/src/features/pokemon/data/favourite_pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_state.dart';

class FavouritePokemonNotifier extends StateNotifier<FetchPokemonState> {
  FavouritePokemonNotifier(this.read) : super(FetchPokemonState.initial());

  final Reader read;

  FavouritePokemonRepository get _favouritePokemonRepository =>
      read(favouritePokemonRepositoryProvider);

  Future<void> watchPokemonList() async {
    _favouritePokemonRepository.watchPokemonList().listen((event) {
      event.fold(
        (exception) {
          state = state.copyWith(
            status: FetchPokemonStatus.error,
            exception: exception,
          );
        },
        (pokemonList) {
          state = state.copyWith(
            status: FetchPokemonStatus.data,
            pokemonList: pokemonList,
          );
        },
      );
    });
  }

  Future<void> savePokemon(Pokemon pokemon) async {
    final either = await _favouritePokemonRepository.savePokemon(pokemon);
    if (either.isLeft()) {
      state = state.copyWith(
        exception: state.exception,
        status: FetchPokemonStatus.error,
      );
    }
  }

  Future<void> deletePokemn(int id) async {
    final either = await _favouritePokemonRepository.deletePokemon(id);
    if (either.isLeft()) {
      state = state.copyWith(
        exception: state.exception,
        status: FetchPokemonStatus.error,
      );
    }
  }
}

final favouritePokemonNotifierProvider =
    StateNotifierProvider<FavouritePokemonNotifier, FetchPokemonState>((ref) {
  return FavouritePokemonNotifier(ref.read);
});
