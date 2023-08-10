import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pokeapi/datamodels/poke_api_pokemon.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PokemonRepository {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon/";
  final String imageBaseUrl =
      "https://www.pkparaiso.com/imagenes/pokedex/pokemon/";

  Future<List<Pokemon>> getPokemonList(int limit) async {
    //This should only add 10 items with offset ?offset=10&limit=20
    final offSet = limit - 10;
    final response =
        await http.get(Uri.parse("$baseUrl?offset=$offSet&limit=10"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;

      List<Pokemon> pokeList = [];
      for (var result in results) {
        pokeList.add(Pokemon.fromJson(result));
      }
      return pokeList;
    } else {
      throw Exception("Failed to load Pokémon list");
    }
  }

  Future<PokemonDetails> getPokemonDetails(int pokeListIndex) async {
    final response = await http.get(Uri.parse("$baseUrl$pokeListIndex/"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = PokemonDetails.fromJson(data);
      return results;
    } else {
      throw Exception("Failed to load Pokémon details");
    }
  }

  Future<String> getPokemonImage(String? imageUrl) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final response = await http.get(
      Uri.parse(imageUrl ?? imageBaseUrl),
    );

    if (response.statusCode == 200) {
      File file =
          File(path.join(documentDirectory.path, path.basename(imageUrl!)));
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    } else {
      throw Exception("Failed to load Pokémon Image");
    }
  }
}
