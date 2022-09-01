import 'package:mek_data_class/mek_data_class.dart';
import 'package:pokedex/src/core/exceptions/exceptions.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';

part 'fetch_pokemon_state.g.dart';

enum FetchPokemonStatus { initial, loading, data, error }

extension FetchPokemonStatusX on FetchPokemonStatus {
  bool get isInitial => this == FetchPokemonStatus.initial;
  bool get isLoading => this == FetchPokemonStatus.loading;
  bool get isData => this == FetchPokemonStatus.data;
  bool get isError => this == FetchPokemonStatus.error;
}

@DataClass(copyable: true)
class FetchPokemonState with _$FetchPokemonState {
  final Pokemon pokemon;
  final PokemonList pokemonList;
  final FetchPokemonStatus status;
  final AppException? exception;

  const FetchPokemonState({
    required this.pokemon,
    required this.pokemonList,
    required this.status,
    this.exception,
  });

  factory FetchPokemonState.initial() {
    return const FetchPokemonState(
      pokemon: Pokemon.empty(),
      pokemonList: [],
      status: FetchPokemonStatus.initial,
    );
  }
}
