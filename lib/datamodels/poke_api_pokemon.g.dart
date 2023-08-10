// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poke_api_pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) => Pokemon(
      name: json['name'] as String?,
      url: json['url'] as String?,
      details: json['details'] == null
          ? null
          : PokemonDetails.fromJson(json['details'] as Map<String, dynamic>),
    )
      ..imageUrl = json['imageUrl'] as String?
      ..imageLocalPath = json['imageLocalPath'] as String?;

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'imageUrl': instance.imageUrl,
      'imageLocalPath': instance.imageLocalPath,
      'details': instance.details,
    };

PokemonDetails _$PokemonDetailsFromJson(Map<String, dynamic> json) =>
    PokemonDetails(
      moves: (json['moves'] as List<dynamic>)
          .map((e) => MoveInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => AbilityInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonDetailsToJson(PokemonDetails instance) =>
    <String, dynamic>{
      'moves': instance.moves,
      'abilities': instance.abilities,
    };

MoveInfo _$MoveInfoFromJson(Map<String, dynamic> json) => MoveInfo(
      move: Move.fromJson(json['move'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MoveInfoToJson(MoveInfo instance) => <String, dynamic>{
      'move': instance.move,
    };

AbilityInfo _$AbilityInfoFromJson(Map<String, dynamic> json) => AbilityInfo(
      ability: Ability.fromJson(json['ability'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AbilityInfoToJson(AbilityInfo instance) =>
    <String, dynamic>{
      'ability': instance.ability,
    };

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

Move _$MoveFromJson(Map<String, dynamic> json) => Move(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$MoveToJson(Move instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
