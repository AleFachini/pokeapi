import 'package:json_annotation/json_annotation.dart';

part 'poke_api_pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  String? name;
  String? url;
  String? imageUrl;
  String? imageLocalPath;
  PokemonDetails? details;

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
class PokemonDetails {
  final List<MoveInfo> moves;
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
class MoveInfo {
  final Move move;

  MoveInfo({
    required this.move,
  });

  factory MoveInfo.fromJson(Map<String, dynamic> json) =>
      _$MoveInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MoveInfoToJson(this);
}

@JsonSerializable()
class AbilityInfo {
  final Ability ability;

  AbilityInfo({
    required this.ability,
  });

  factory AbilityInfo.fromJson(Map<String, dynamic> json) =>
      _$AbilityInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityInfoToJson(this);
}

@JsonSerializable()
class Ability {
  final String name;
  final String url;

  Ability({required this.name, required this.url});

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@JsonSerializable()
class Move {
  final String name;
  final String url;

  Move({required this.name, required this.url});

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);

  Map<String, dynamic> toJson() => _$MoveToJson(this);
}
