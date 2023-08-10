import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poke_api_pokemon.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Pokemon {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? url;
  @HiveField(2)
  String? imageUrl;
  @HiveField(3)
  String? imageLocalPath;
  @HiveField(4)
  PokemonDetails? details;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(5)
  int? keyForDetails;

  Pokemon({
    required this.name,
    required this.url,
    required this.details,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 1)
class PokemonDetails {
  @HiveField(0)
  final List<MoveInfo> moves;
  @HiveField(1)
  final List<AbilityInfo> abilities;

  PokemonDetails({
    required this.moves,
    required this.abilities,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonDetailsToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 2)
class MoveInfo {
  @HiveField(0)
  final Move move;

  MoveInfo({
    required this.move,
  });

  factory MoveInfo.fromJson(Map<String, dynamic> json) =>
      _$MoveInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MoveInfoToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 3)
class AbilityInfo {
  @HiveField(0)
  final Ability ability;

  AbilityInfo({
    required this.ability,
  });

  factory AbilityInfo.fromJson(Map<String, dynamic> json) =>
      _$AbilityInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityInfoToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 4)
class Ability {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  Ability({required this.name, required this.url});

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 5)
class Move {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  Move({required this.name, required this.url});

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);

  Map<String, dynamic> toJson() => _$MoveToJson(this);
}
