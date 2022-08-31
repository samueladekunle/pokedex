import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/src/features/pokemon/data/poke_api_respository.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/src/features/pokemon/presentation/notifiers/fetch_pokemon_state.dart';

class FetchPokemonNotifier extends StateNotifier<FetchPokemonState> {
  FetchPokemonNotifier(this.read) : super(FetchPokemonState.initial());

  final Reader read;

  PokeAPIRepository get _pokeAPIRepository => read(pokeAPIRepositoryProvider);

  int _offset = 0;

  static const _kPageLimit = 24;

  Future<void> fetchPokemon(int id) async {
    state = state.copyWith(
      status: FetchPokemonStatus.loading,
      pokemon: const Pokemon.empty(),
    );
    final either = await _pokeAPIRepository.fetchPokemon(id);
    either.fold(
      (exception) {
        state = state.copyWith(
          status: FetchPokemonStatus.error,
          exception: exception,
        );
      },
      (pokemon) {
        state = state.copyWith(
          status: FetchPokemonStatus.data,
          pokemon: pokemon,
        );
      },
    );
  }

  Future<void> fetchPokemonList() async {
    state = state.copyWith(status: FetchPokemonStatus.loading);
    final either =
        await _pokeAPIRepository.fetchPokemonList(_offset, _kPageLimit);
    either.fold(
      (exception) {
        state = state.copyWith(
          exception: exception,
          status: FetchPokemonStatus.error,
        );
      },
      (pokemonList) {
        state = state.copyWith(
          exception: null,
          pokemonList: state.pokemonList.followedBy(pokemonList).toList(),
          status: FetchPokemonStatus.data,
        );
      },
    );
  }

  Future<void> fetchNextPokemonList() async {
    if (!state.status.isLoading) {
      _offset += 24;
      await fetchPokemonList();
    }
  }
}

final fetchPokemonNotifierProvider =
    StateNotifierProvider<FetchPokemonNotifier, FetchPokemonState>((ref) {
  return FetchPokemonNotifier(ref.read);
});
