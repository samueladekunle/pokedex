import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' hide Reader;
import 'package:pokedex/src/core/api/rest_api_repository.dart';
import 'package:pokedex/src/core/exceptions/exceptions.dart';
import 'package:pokedex/src/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/src/features/pokemon/domain/resource.dart';

class PokeAPIRepository {
  const PokeAPIRepository(this.read);

  final Reader read;

  RestAPIRepository get _restAPIRepository => read(restAPIRepositoryProvider);

  Future<Either<AppException, PokemonList>> fetchPokemonList(
      int offset, int pageLimit) async {
    final response =
        await _restAPIRepository.get('pokemon?offset=$offset&limit=$pageLimit');
    return response.map<PokemonList>((data) {
      final list = data['results'] as List;
      final resources = list.map((e) => Resource.fromJson(e)).toList();
      return resources.map((e) => Pokemon.fromResource(e)).toList();
    });
  }

  Future<Either<AppException, Pokemon>> fetchPokemon(int id) async {
    final response = await _restAPIRepository.get('pokemon/$id');
    return response.map<Pokemon>((json) => Pokemon.fromJson(json));
  }
}

final pokeAPIRepositoryProvider = Provider<PokeAPIRepository>((ref) {
  return PokeAPIRepository(ref.read);
});
