// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_pokemon_state.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$FetchPokemonState {
  FetchPokemonState get _self => this as FetchPokemonState;

  Iterable<Object?> get _props sync* {
    yield _self.pokemon;
    yield _self.pokemonList;
    yield _self.status;
    yield _self.exception;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$FetchPokemonState &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('FetchPokemonState')
        ..add('pokemon', _self.pokemon)
        ..add('pokemonList', _self.pokemonList)
        ..add('status', _self.status)
        ..add('exception', _self.exception))
      .toString();

  FetchPokemonState copyWith({
    Pokemon? pokemon,
    List<Pokemon>? pokemonList,
    FetchPokemonStatus? status,
    AppException? exception,
  }) {
    return FetchPokemonState(
      pokemon: pokemon ?? _self.pokemon,
      pokemonList: pokemonList ?? _self.pokemonList,
      status: status ?? _self.status,
      exception: exception ?? _self.exception,
    );
  }
}
