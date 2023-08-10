import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapi/data/datamodels/poke_api_pokemon.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PokemonRepository {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon/";
  final String imageBaseUrl =
      "https://www.pkparaiso.com/imagenes/pokedex/pokemon/";

  Future<List<Pokemon>> getPokemonList(int limit) async {
    //This should only add 10 items with offset ?offset=10&limit=20
    final offSet = limit - 10;
    try {
      final response = await http
          .get(Uri.parse("$baseUrl?offset=$offSet&limit=10"))
          .timeout(const Duration(
            seconds: 5,
          ));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List<dynamic>;

        List<Pokemon> pokeList = [];
        for (var result in results) {
          pokeList.add(Pokemon.fromJson(result));
        }
        return pokeList;
      }
    } on TimeoutException catch (e) {
      debugPrint('Timeout Exception $e');
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
    return [];
  }

  Future<PokemonDetails?> getPokemonDetails(int pokeListIndex) async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl$pokeListIndex/"))
          .timeout(const Duration(
            seconds: 50,
          ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = PokemonDetails.fromJson(data);
        return results;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String> getPokemonImage(String? imageUrl) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    try {
      final response = await http
          .get(
            Uri.parse(imageUrl ?? imageBaseUrl),
          )
          .timeout(const Duration(
            seconds: 5,
          ));

      if (response.statusCode == 200) {
        File file = File(
          path.join(
            documentDirectory.path,
            path.basename(imageUrl!),
          ),
        );
        //save File at path
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return '';
  }
}
