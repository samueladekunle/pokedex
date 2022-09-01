import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:pokedex/src/config/constants.dart';
import 'package:pokedex/src/config/hive_config.dart';
import 'package:pokedex/src/core/extensions/string_extensions.dart';
import 'package:pokedex/src/features/pokemon/domain/resource.dart';

part 'pokemon.g.dart';

typedef PokemonList = List<Pokemon>;

@DataClass()
@HiveType(typeId: HiveTypeId.pokemon)
@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class Pokemon with _$Pokemon {
  @HiveField(0)
  @JsonKey(defaultValue: 0)
  final int id;

  @HiveField(1)
  @JsonKey(defaultValue: '')
  final String name;

  @HiveField(2)
  @JsonKey(defaultValue: 0)
  final num height;

  @HiveField(3)
  @JsonKey(defaultValue: 0)
  final num weight;

  @HiveField(4)
  @JsonKey(defaultValue: [])
  final List<PokemonStat> stats;

  @HiveField(5)
  @JsonKey(defaultValue: [])
  final List<PokemonType> types;

  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
  });

  const Pokemon._({
    this.id = -1,
    this.name = '',
    this.height = 0,
    this.weight = 0,
    this.stats = const [],
    this.types = const [],
  });

  factory Pokemon.fromJson(JsonResponse json) => _$PokemonFromJson(json);

  const factory Pokemon.empty() = Pokemon._;

  factory Pokemon.fromResource(Resource resource) {
    final paths = resource.url.split('/');
    final id = paths[paths.length - 2].toInt();

    return Pokemon(
      id: id,
      name: resource.name,
      height: 0,
      weight: 0,
      stats: [],
      types: [],
    );
  }

  JsonResponse toJson() => _$PokemonToJson(this);
}

@DataClass()
@HiveType(typeId: HiveTypeId.pokemonStat)
@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class PokemonStat with _$PokemonStat {
  @HiveField(0)
  @JsonKey(defaultValue: 0)
  final num baseStat;

  @HiveField(1)
  final Resource stat;

  @HiveField(2)
  @JsonKey(defaultValue: 0)
  final num effort;

  const PokemonStat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory PokemonStat.empty() => const PokemonStat(
        baseStat: 0,
        effort: 0,
        stat: Resource.empty(),
      );

  factory PokemonStat.fromJson(JsonResponse json) =>
      _$PokemonStatFromJson(json);

  JsonResponse toJson() => _$PokemonStatToJson(this);
}

@DataClass()
@HiveType(typeId: HiveTypeId.pokemonType)
@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class PokemonType with _$PokemonType {
  @HiveField(0)
  @JsonKey(defaultValue: 0)
  final num slot;

  @HiveField(1)
  final Resource type;

  const PokemonType({
    required this.slot,
    required this.type,
  });

  factory PokemonType.empty() => const PokemonType(
        slot: 0,
        type: Resource.empty(),
      );

  factory PokemonType.fromJson(JsonResponse json) =>
      _$PokemonTypeFromJson(json);

  JsonResponse toJson() => _$PokemonTypeToJson(this);
}
