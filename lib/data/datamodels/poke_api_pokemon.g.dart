// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poke_api_pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 0;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      name: fields[0] as String?,
      url: fields[1] as String?,
      details: fields[4] as PokemonDetails?,
    )
      ..imageUrl = fields[2] as String?
      ..imageLocalPath = fields[3] as String?
      ..keyForDetails = fields[5] as int?;
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.imageLocalPath)
      ..writeByte(4)
      ..write(obj.details)
      ..writeByte(5)
      ..write(obj.keyForDetails);
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

class PokemonDetailsAdapter extends TypeAdapter<PokemonDetails> {
  @override
  final int typeId = 1;

  @override
  PokemonDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonDetails(
      moves: (fields[0] as List).cast<MoveInfo>(),
      abilities: (fields[1] as List).cast<AbilityInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, PokemonDetails obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.moves)
      ..writeByte(1)
      ..write(obj.abilities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MoveInfoAdapter extends TypeAdapter<MoveInfo> {
  @override
  final int typeId = 2;

  @override
  MoveInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoveInfo(
      move: fields[0] as Move,
    );
  }

  @override
  void write(BinaryWriter writer, MoveInfo obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.move);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoveInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AbilityInfoAdapter extends TypeAdapter<AbilityInfo> {
  @override
  final int typeId = 3;

  @override
  AbilityInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AbilityInfo(
      ability: fields[0] as Ability,
    );
  }

  @override
  void write(BinaryWriter writer, AbilityInfo obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.ability);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbilityInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AbilityAdapter extends TypeAdapter<Ability> {
  @override
  final int typeId = 4;

  @override
  Ability read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ability(
      name: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ability obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbilityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MoveAdapter extends TypeAdapter<Move> {
  @override
  final int typeId = 5;

  @override
  Move read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Move(
      name: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Move obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
