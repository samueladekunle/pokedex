// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$Pokemon {
  Pokemon get _self => this as Pokemon;

  Iterable<Object?> get _props sync* {
    yield _self.id;
    yield _self.name;
    yield _self.height;
    yield _self.weight;
    yield _self.stats;
    yield _self.types;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Pokemon &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('Pokemon')
        ..add('id', _self.id)
        ..add('name', _self.name)
        ..add('height', _self.height)
        ..add('weight', _self.weight)
        ..add('stats', _self.stats)
        ..add('types', _self.types))
      .toString();
}

mixin _$PokemonStat {
  PokemonStat get _self => this as PokemonStat;

  Iterable<Object?> get _props sync* {
    yield _self.baseStat;
    yield _self.stat;
    yield _self.effort;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$PokemonStat &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('PokemonStat')
        ..add('baseStat', _self.baseStat)
        ..add('stat', _self.stat)
        ..add('effort', _self.effort))
      .toString();
}

mixin _$PokemonType {
  PokemonType get _self => this as PokemonType;

  Iterable<Object?> get _props sync* {
    yield _self.slot;
    yield _self.type;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$PokemonType &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('PokemonType')
        ..add('slot', _self.slot)
        ..add('type', _self.type))
      .toString();
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 1;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      id: fields[0] as int,
      name: fields[1] as String,
      height: fields[2] as num,
      weight: fields[3] as num,
      stats: (fields[4] as List).cast<PokemonStat>(),
      types: (fields[5] as List).cast<PokemonType>(),
    );
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.stats)
      ..writeByte(5)
      ..write(obj.types);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PokemonStatAdapter extends TypeAdapter<PokemonStat> {
  @override
  final int typeId = 2;

  @override
  PokemonStat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonStat(
      baseStat: fields[0] as num,
      effort: fields[2] as num,
      stat: fields[1] as Resource,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonStat obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.baseStat)
      ..writeByte(1)
      ..write(obj.stat)
      ..writeByte(2)
      ..write(obj.effort);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonStatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PokemonTypeAdapter extends TypeAdapter<PokemonType> {
  @override
  final int typeId = 3;

  @override
  PokemonType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonType(
      slot: fields[0] as num,
      type: fields[1] as Resource,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonType obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.slot)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) => Pokemon(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      height: json['height'] as num? ?? 0,
      weight: json['weight'] as num? ?? 0,
      stats: (json['stats'] as List<dynamic>?)
              ?.map((e) => PokemonStat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      types: (json['types'] as List<dynamic>?)
              ?.map((e) => PokemonType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'height': instance.height,
      'weight': instance.weight,
      'stats': instance.stats.map((e) => e.toJson()).toList(),
      'types': instance.types.map((e) => e.toJson()).toList(),
    };

PokemonStat _$PokemonStatFromJson(Map<String, dynamic> json) => PokemonStat(
      baseStat: json['base_stat'] as num? ?? 0,
      effort: json['effort'] as num? ?? 0,
      stat: Resource.fromJson(json['stat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonStatToJson(PokemonStat instance) =>
    <String, dynamic>{
      'base_stat': instance.baseStat,
      'stat': instance.stat.toJson(),
      'effort': instance.effort,
    };

PokemonType _$PokemonTypeFromJson(Map<String, dynamic> json) => PokemonType(
      slot: json['slot'] as num? ?? 0,
      type: Resource.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonTypeToJson(PokemonType instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'type': instance.type.toJson(),
    };
