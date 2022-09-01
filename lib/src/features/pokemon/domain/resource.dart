import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:pokedex/src/config/constants.dart';
import 'package:pokedex/src/config/hive_config.dart';

part 'resource.g.dart';

typedef ResourceList = List<Resource>;

@DataClass()
@HiveType(typeId: HiveTypeId.resource)
@JsonSerializable(explicitToJson: true)
class Resource with _$Resource {
  @HiveField(0)
  @JsonKey(defaultValue: '')
  final String url;

  @HiveField(1)
  @JsonKey(defaultValue: '')
  final String name;

  const Resource({
    required this.url,
    required this.name,
  });

  const Resource._({
    this.url = '',
    this.name = '',
  });

  const factory Resource.empty() = Resource._;

  factory Resource.fromJson(JsonResponse json) => _$ResourceFromJson(json);

  JsonResponse toJson() => _$ResourceToJson(this);
}
